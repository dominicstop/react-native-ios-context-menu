//
//  RNIContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit
import ExpoModulesCore
import ReactNativeIosUtilities
import DGSwiftUtilities
import ContextMenuAuxiliaryPreview


public class RNIContextMenuView:
  ExpoView, RNINavigationEventsNotifiable, RNICleanable,
  RNIMenuElementEventsNotifiable, ContextMenuManagerDelegate {

  // MARK: - Embedded Types
  // ----------------------
  
  enum NativeIDKey: String {
    case contextMenuPreview;
    case contextMenuAuxiliaryPreview;
  };
  
  // MARK: - Properties
  // ------------------
  
  var contextMenuManager: ContextMenuManager?;
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  var detachedViews: [WeakRef<RNIDetachedView>] = [];
  
  var menuAuxiliaryPreviewView: RNIDetachedView?;
  var menuCustomPreviewView: RNIDetachedView?;
  
  var previewController: RNIContextMenuPreviewController?;
  weak var viewController: RNINavigationEventsReportingViewController?;
  
  var _deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
    
  var longPressGestureRecognizer: UILongPressGestureRecognizer!;
  
  override public var reactTag: NSNumber! {
    didSet {
      try? RNICleanableViewRegistryShared.register(
        forDelegate: self,
        shouldIncludeDelegateInViewsToCleanup: true,
        shouldProceedCleanupWhenDelegateIsNil: true
      );
    }
  };
    
  // MARK: - Properties - Flags
  // --------------------------
  
  /// Keep track on whether or not the context menu is currently visible.
  var isContextMenuVisible = false;
  
  // TODO: Fix 
  /// This is set to `true` when the menu is open and an item is pressed, and
  /// is immediately set back to `false` once the menu close animation
  /// finishes.
  var didPressMenuItem = false;
  
  /// Whether or not `cleanup` method was called
  var _didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;

  // MARK: Properties - Props
  // ------------------------

  private(set) public var menuConfig: RNIMenuItem?;
  public var menuConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0,
            
            let menuConfig = RNIMenuItem(dictionary: newValue)
      else {
        self.menuConfig = nil;
        return;
      };
      
      menuConfig.delegate = self;
      
      menuConfig.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle =
        self.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle;
      
      self.updateContextMenuIfVisible(with: menuConfig);
      
      // cleanup `deferredElementCompletionMap`
      self.cleanupOrphanedDeferredElements(currentMenuConfig: menuConfig);
      
      // update config
      self.menuConfig = menuConfig;
    }
  };
  
  private(set) public var previewConfig = RNIMenuPreviewConfig();
  public var previewConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue else { return };
      
      let previewConfig = RNIMenuPreviewConfig(dictionary: newValue);
      self.previewConfig = previewConfig;
      
      // update the vc's previewConfig
      if let previewController = self.previewController {
        previewController.view.setNeedsLayout();
      };
    }
  };
  
  public var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  public var isContextMenuEnabled = true;
  
  private(set) public var viewCleanupMode: RNIViewCleanupMode = .default;
  public var internalViewCleanupModeRaw: Dictionary<String, Any>? {
    willSet {
      let nextValue: RNIViewCleanupMode = {
        guard let newValue = newValue,
              let viewCleanupMode = try? RNIViewCleanupMode(fromDict: newValue)
        else {
          return .default;
        };
        
        return viewCleanupMode;
      }();
      
      self.viewCleanupMode = nextValue;
      
      if let cleanableViewItem = self.associatedCleanableViewItem {
        cleanableViewItem.viewCleanupMode = nextValue;
      };
    }
  };
  
  // TODO: Rename to: shouldCancelReactTouchesWhenContextMenuIsShown
  public var shouldPreventLongPressGestureFromPropagating = true {
    willSet {
      let oldValue = self.shouldPreventLongPressGestureFromPropagating;
      
      guard newValue != oldValue,
            let longPressGestureRecognizer = self.longPressGestureRecognizer
      else { return };
      
      longPressGestureRecognizer.isEnabled = newValue;
    }
  };

  public var isAuxiliaryPreviewEnabled = true {
    willSet {
      self.contextMenuManager?.isAuxiliaryPreviewEnabled = newValue;
    }
  };
  
  private(set) public var auxiliaryPreviewConfig: AuxiliaryPreviewConfig!;
  public var auxiliaryPreviewConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0
      else {
        self.setupInitAuxiliaryPreviewConfigIfNeeded();
        return;
      };
      
      let config: AuxiliaryPreviewConfig = {
        if let newConfig = AuxiliaryPreviewConfig(dict: newValue) {
          return newConfig;
        };
        
        let deprecatedConfig =
          RNIContextMenuAuxiliaryPreviewConfig(dictionary: newValue);
        
        return AuxiliaryPreviewConfig(config: deprecatedConfig);
      }();
      
      self.contextMenuManager?.auxiliaryPreviewConfig = config;
      self.auxiliaryPreviewConfig = config;
    }
  };
  
  // MARK: Properties - Props - Events
  // ---------------------------------
  
  public let onMenuWillShow   = EventDispatcher("onMenuWillShow");
  public let onMenuWillHide   = EventDispatcher("onMenuWillHide");
  public let onMenuWillCancel = EventDispatcher("onMenuWillCancel");
  
  public let onMenuDidShow   = EventDispatcher("onMenuDidShow");
  public let onMenuDidHide   = EventDispatcher("onMenuDidHide");
  public let onMenuDidCancel = EventDispatcher("onMenuDidCancel");
  
  public let onPressMenuItem    = EventDispatcher("onPressMenuItem");
  public let onPressMenuPreview = EventDispatcher("onPressMenuPreview");
  
  public let onMenuWillCreate = EventDispatcher("onMenuWillCreate");
  
  public let onRequestDeferredElement =
    EventDispatcher("onRequestDeferredElement");

  // TODO: WIP - To be implemented
  public var onMenuAuxiliaryPreviewWillShow =
    EventDispatcher("onMenuAuxiliaryPreviewWillShow");
  
  // TODO: WIP - To be implemented
  public var onMenuAuxiliaryPreviewDidShow =
    EventDispatcher("onMenuAuxiliaryPreviewDidShow");
  
  // MARK: - Computed Properties
  // ---------------------------
  
  /// create `UIPreviewParameters` based on `previewConfig`
  var menuPreviewParameters: UIPreviewParameters {
    let param = UIPreviewParameters();
      
    // set preview bg color
    param.backgroundColor = self.previewConfig.backgroundColor;
    
    // set the preview border shape
    if let borderRadius = self.previewConfig.borderRadius {
      let previewShape = UIBezierPath(
        // get width/height from custom preview view
        roundedRect: CGRect(
          origin: CGPoint(x: 0, y: 0),
          size  : self.frame.size
        ),
        // set the preview corner radius
        cornerRadius: borderRadius
      );
      
      // set preview border shape
      param.visiblePath = previewShape;
      
      // set preview border shadow
      if #available(iOS 14, *){
        param.shadowPath = previewShape;
      };
    };
      
    return param;
  };
  
  /// Get a ref. to the view specified in `PreviewConfig.targetViewNode`
  var customMenuPreviewTargetView: UIView? {
    guard let bridge = self.appContext?.reactBridge,
          let targetNode = self.previewConfig.targetViewNode,
          let targetView = bridge.uiManager.view(forReactTag: targetNode)
    else { return nil }
    
    return targetView;
  };
  
  var menuPreviewTargetView: UIView {
    self.customMenuPreviewTargetView ?? self;
  };
  
  var menuTargetedPreview: UITargetedPreview {
    return .init(
      view: self.menuPreviewTargetView,
      parameters: self.menuPreviewParameters
    );
  };
  
  var isUsingCustomPreview: Bool {
       self.previewConfig.previewType == .CUSTOM
    && self.menuCustomPreviewView != nil
  };

  // MARK: Init + Lifecycle
  // ----------------------

  public required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext);
    
    self.setupInitAuxiliaryPreviewConfigIfNeeded();
    self.setupAddContextMenuInteraction();
    self.setupAddGestureRecognizers();
  };
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  deinit {
    try? self.viewCleanupMode.triggerCleanupIfNeededForDeinit(
      for: self,
      shouldForceCleanup: true
    );
  };
  
  // MARK: - RN Lifecycle
  // --------------------

  public override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  public override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    super.insertSubview(subview, at: atIndex);
    
    if let cleanableViewItem = self.associatedCleanableViewItem {
      cleanableViewItem.viewsToCleanup.append(
        .init(with: subview)
      );
    };
    
    guard let detachedView = subview as? RNIDetachedView,
          let nativeID = detachedView.nativeID,
          let nativeIDKey = NativeIDKey(rawValue: nativeID)
    else { return };
    
    switch nativeIDKey {
        case .contextMenuPreview:
          self.menuCustomPreviewView?.cleanup();
          self.menuCustomPreviewView = detachedView;
        
        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
        case .contextMenuAuxiliaryPreview:
          self.menuAuxiliaryPreviewView?.cleanup();
          self.menuAuxiliaryPreviewView = detachedView;
    };
    
    self.detachedViews.append(
      .init(with: detachedView)
    );
    
    try? detachedView.detach();
  };
  
  #if DEBUG
  @objc func onRCTBridgeWillReloadNotification(_ notification: Notification){
    self.cleanup();
  };
  #endif
  
  // MARK: - View Lifecycle
  // ----------------------
  
  public override func didMoveToWindow() {
    let shouldAttachToParentVC = self.viewCleanupMode.shouldAttachToParentController(
      forView: self,
      associatedViewController: self.viewController,
      currentWindow: self.window
    );
      
    if shouldAttachToParentVC {
      // begin setup - attach this view as child vc
      self.attachToParentVC();
    
    } else {
      // trigger manual cleanup
      try? self.viewCleanupMode.triggerCleanupIfNeededForDidMoveToWindow(
        forView: self,
        associatedViewController: self.viewController,
        currentWindow: self.window
      );
    };
  };
  
  // MARK: - Functions
  // -----------------
  
  func setupInitAuxiliaryPreviewConfigIfNeeded(){
    guard self.isAuxiliaryPreviewEnabled,
          self.auxiliaryPreviewConfig == nil
    else { return };
    
    self.auxiliaryPreviewConfig = .init(
      verticalAnchorPosition: .automatic,
      horizontalAlignment: .stretchTarget,
      marginInner: 12,
      marginOuter: 12,
      transitionConfigEntrance: .syncedToMenuEntranceTransition(
        shouldAnimateSize: true
      ),
      transitionExitPreset: .zoomAndSlide()
    );
  };
  
  /// Add a context menu interaction to view
  func setupAddContextMenuInteraction(){
    let contextMenuInteraction = UIContextMenuInteraction(delegate: self);
    self.addInteraction(contextMenuInteraction);
    
    self.contextMenuInteraction = contextMenuInteraction;
    
    let contextMenuManager = ContextMenuManager(
      contextMenuInteraction: contextMenuInteraction,
      menuTargetView: self.menuPreviewTargetView
    );
   
    contextMenuManager.auxiliaryPreviewConfig = self.auxiliaryPreviewConfig;
    contextMenuManager.delegate = self;
    
    self.contextMenuManager = contextMenuManager;
  };
  
  func setupAddGestureRecognizers(){
    let longPressGestureRecognizer = UILongPressGestureRecognizer(
      target: self,
      action: #selector(Self.handleLongPressGesture(_:))
    );
    
    self.longPressGestureRecognizer = longPressGestureRecognizer;
    
    longPressGestureRecognizer.delegate = self;
    longPressGestureRecognizer.isEnabled =
      self.shouldPreventLongPressGestureFromPropagating;
    
    self.addGestureRecognizer(longPressGestureRecognizer);
  };
  
  func createMenu(with menuConfig: RNIMenuItem? = nil) -> UIMenu? {
    guard let menuConfig = menuConfig ?? self.menuConfig
    else { return nil };
    
    return menuConfig.createMenu(actionItemHandler: { [weak self] in
      // A. menu item has been pressed...
      self?.handleOnPressMenuActionItem(dict: $0, action: $1);
      
    }, deferredElementHandler: { [weak self] in
      // B. deferred element is requesting for items to load...
      self?.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
    });
  };
  
  func setAuxiliaryPreviewConfigSizeIfNeeded(){
    guard let menuAuxiliaryPreviewView = self.menuAuxiliaryPreviewView,
          self.auxiliaryPreviewConfig != nil
    else { return };
    
    if self.auxiliaryPreviewConfig!.preferredWidth == nil {
      self.auxiliaryPreviewConfig!.preferredWidth = .constant(
        menuAuxiliaryPreviewView.bounds.width
      );
    };
    
    if self.auxiliaryPreviewConfig!.preferredHeight == nil {
      self.auxiliaryPreviewConfig!.preferredHeight = .constant(
        menuAuxiliaryPreviewView.bounds.height
      );
    };
    
    self.contextMenuManager?.auxiliaryPreviewConfig = self.auxiliaryPreviewConfig;
  };
  
  /// create custom menu preview based on `previewConfig` and `reactPreviewView`
  func createMenuPreview() -> UIViewController? {
  
    /// don't make preview if `previewType` is set to default.
    guard self.previewConfig.previewType != .DEFAULT
    else { return nil };
    
    // vc that holds the view to show in the preview
    let vc = RNIContextMenuPreviewController();
    vc.contextMenuView = self;
    vc.view.isUserInteractionEnabled = true;
    
    self.previewController = vc;
    return vc;
  };
  
  func updateContextMenuIfVisible(with menuConfig: RNIMenuItem){
    guard #available(iOS 14.0, *),
          self.isContextMenuVisible,
          
          let interaction = self.contextMenuInteraction,
          let menu = self.createMenu(with: menuConfig)
    else { return };
    
    // context menu is open, update the menu items
    interaction.updateVisibleMenu { _ in
      return menu;
    };
  };
  
  func handleOnPressMenuActionItem(
    dict: [String: Any],
    action: UIAction
  ){
    self.didPressMenuItem = true;
    self.onPressMenuItem.callAsFunction(dict);
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self._deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.onRequestDeferredElement.callAsFunction([
      "deferredID": deferredID,
    ]);
  };
  
  @objc func handleLongPressGesture(_ sender: UILongPressGestureRecognizer){
    // no-op
  };
  
  func attachToParentVC(){
    guard !self.didAttachToParentVC else { return };
        
    // find the nearest parent view controller
    let parentVC = RNIHelpers.getParent(
      responder: self,
      type: UIViewController.self
    );
    
    guard let parentVC = parentVC else { return };
    self.didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.delegate = self;
    childVC.parentVC = parentVC;
    
    self.viewController = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
  };
  
  func cleanupOrphanedDeferredElements(currentMenuConfig: RNIMenuItem) {
    guard self._deferredElementCompletionMap.count > 0
    else { return };
    
    let currentDeferredElements = RNIMenuElement.recursivelyGetAllElements(
      from: currentMenuConfig,
      ofType: RNIDeferredMenuElement.self
    );
      
    // get the deferred elements that are not in the new config
    let orphanedKeys = self._deferredElementCompletionMap.keys.filter { deferredID in
      !currentDeferredElements.contains {
        $0.deferredID == deferredID
      };
    };
    
    // cleanup
    orphanedKeys.forEach {
      self._deferredElementCompletionMap.removeValue(forKey: $0);
    };
  };
  
  func detachFromParentVCIfAny(){
    guard !self.didAttachToParentVC,
          let childVC = self.viewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
    childVC.view.removeFromSuperview();
  };
  
  // MARK: - Functions - View Module Commands
  // ----------------------------------------
  
  func dismissMenu() throws {
    guard let contextMenuInteraction = self.contextMenuInteraction else {
      throw RNIContextMenuError(
        errorCode: .unexpectedNilValue,
        description: "contextMenuInteraction is nil"
      );
    };
    
    contextMenuInteraction.dismissMenu();
  };
  
  func provideDeferredElements(
    id deferredID: String,
    menuElements rawMenuElements: [RNIMenuElement]
  ) throws {
    
    guard let completionHandler = self._deferredElementCompletionMap[deferredID]
    else {
      throw RNIContextMenuError(
        description: "No matching deferred completion handler found for deferredID",
        extraDebugValues: ["deferredID": deferredID]
      );
    };
    
    // create menu elements
    let menuElements = rawMenuElements.compactMap { menuElement in
      menuElement.createMenuElement(
        actionItemHandler: { [unowned self] in
          self.handleOnPressMenuActionItem(dict: $0, action: $1);
          
        }, deferredElementHandler: { [unowned self] in
          self.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
        }
      );
    };
    
    // add menu elements
    completionHandler(menuElements);
  
    // cleanup
    self._deferredElementCompletionMap.removeValue(forKey: deferredID);
  };
  
  func presentMenu() throws {
    guard self.isContextMenuEnabled else {
      throw RNIContextMenuError.init(
        errorCode: .guardCheckFailed,
        description: "Context menu is disabled"
      );
    };
    
    guard !self.isContextMenuVisible else {
      throw RNIContextMenuError.init(
        errorCode: .guardCheckFailed,
        description: "Context menu is already visible"
      );
    };
    
    guard let contextMenuManager = self.contextMenuManager else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "Unable to get contextMenuManager"
      );
    };
    
    try contextMenuManager.presentMenu(atLocation: .zero);
  };
  
  func showAuxiliaryPreviewAsPopover() throws {
    guard let contextMenuManager = self.contextMenuManager else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "Unable to get contextMenuManager"
      );
    };
    
    guard let parentViewController = self.parentViewController else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "Unable to get parentViewController"
      );
    };
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.setAuxiliaryPreviewConfigSizeIfNeeded();
    
      try? contextMenuManager.showAuxiliaryPreviewAsPopover(
        presentingViewController: parentViewController
      );
    };
  };
  
  // MARK: - RNICleanable
  // --------------------
  
  public func cleanup(){
    guard let viewCleanupKey = self.viewCleanupKey else { return };
    
    try? RNICleanableViewRegistryShared.notifyCleanup(
      forKey: viewCleanupKey,
      sender: .cleanableViewDelegate(self),
      shouldForceCleanup: true,
      cleanupTrigger: nil
    );
  };
  
  // MARK: - RNINavigationEventsNotifiable
  // -------------------------------------
  
  public func notifyViewControllerDidPop(
    sender: RNINavigationEventsReportingViewController
  ) {
    try? self.viewCleanupMode
      .triggerCleanupIfNeededForViewControllerDidPopEvent(for: self);
  };
  
  // MARK: - RNIMenuElementEventsNotifiable
  // --------------------------------------
  
  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self.menuConfig else { return };
    self.updateContextMenuIfVisible(with: menuConfig);
  };
  
  // MARK: ContextMenuManagerDelegate
  // --------------------------------
  
  public func onRequestMenuAuxiliaryPreview(sender: ContextMenuManager) -> UIView? {
    guard let menuAuxiliaryPreviewView = self.menuAuxiliaryPreviewView
    else { return nil };
  
    let layoutWrapperView = AutoLayoutWrapperView(frame: .zero);
    layoutWrapperView.addSubview(menuAuxiliaryPreviewView);
    
    return layoutWrapperView;
  };
};
