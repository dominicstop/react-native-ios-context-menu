//
//  RNIContextMenuViewContent.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

import UIKit
import DGSwiftUtilities
import ContextMenuAuxiliaryPreview
import react_native_ios_utilities


@objc(RNIContextMenuViewDelegate)
public final class RNIContextMenuViewContent: UIView, RNIContentView {

  // MARK: - Embedded Types
  // ----------------------
  
  enum NativeIDKey: String {
    case contextMenuPreview;
    case contextMenuAuxiliaryPreview;
  };
  
  public enum Events: String, CaseIterable {
    case onDidSetViewID;
    
    case onMenuWillShow;
    case onMenuWillHide;
    case onMenuWillCancel;
    case onMenuDidShow;
    case onMenuDidHide;
    case onMenuDidCancel;
    case onPressMenuItem;
    case onPressMenuPreview;
    case onMenuWillCreate;
    case onRequestDeferredElement;
    
    // TODO: WIP - To be impl.
    case onMenuAuxiliaryPreviewWillShow;
    case onMenuAuxiliaryPreviewDidShow;
  };
  
  // MARK: - Static Properties
  // -------------------------
  
  public static var propKeyPathMap: Dictionary<String, PartialKeyPath<RNIContextMenuViewContent>> = [
    "menuConfig": \.menuConfig,
    "previewConfig": \.previewConfigProp,
    "shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle": \.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle,
    "isContextMenuEnabled": \.isContextMenuEnabled,
    "shouldPreventLongPressGestureFromPropagating": \.shouldPreventLongPressGestureFromPropagating,
    "isAuxiliaryPreviewEnabled": \.isAuxiliaryPreviewEnabled,
    "auxiliaryPreviewConfig": \.auxiliaryPreviewConfigProp,
  ];
  
  // MARK: Properties
  // ----------------
  
  var _didSetup = false;
  
  var _deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
    
  weak var navEventsVC: RNINavigationEventsReportingViewController?;
  var longPressGestureRecognizer: UILongPressGestureRecognizer!;
  
  // TODO: WIP - To be re-impl.
  var detachedViews: [WeakRef</* RNIDetachedView? */ UIView>] = [];
  var menuAuxiliaryPreviewView: /* RNIDetachedView? */ UIView?;
  var menuCustomPreviewView: /* RNIDetachedView? */ UIView?;
  
  var previewController: RNIContextMenuPreviewController?;
    
  // MARK: Public Properties
  // ----------------------
  
  public var contextMenuManager: ContextMenuManager?;
  public var contextMenuInteraction: UIContextMenuInteraction?;
  
   /// Keep track on whether or not the context menu is currently visible.
  internal(set) public var isContextMenuVisible = false;
  
  // TODO: Fix 
  /// This is set to `true` when the menu is open and an item is pressed, and
  /// is immediately set back to `false` once the menu close animation
  /// finishes.
  internal(set) public var didPressMenuItem = false;
  
  /// Whether or not the current view was successfully added as child VC
  private(set) public var didAttachToParentVC = false;
  
  // MARK: - Properties - RNIContentViewDelegate
  // -------------------------------------------
  
  public weak var parentReactView: RNIContentViewParentDelegate?;
  
  // MARK: Properties - Props
  // ------------------------
  
  public var reactProps: NSDictionary = [:];
  
  private(set) public var menuConfig: RNIMenuItem?;
  @objc public var menuConfigProp: Dictionary<String, Any>? {
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
  @objc public var previewConfigProp: Dictionary<String, Any>? {
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
  
  @objc public var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  @objc public var isContextMenuEnabled = true;
  
  // TODO: Rename to: shouldCancelReactTouchesWhenContextMenuIsShown
  @objc public var shouldPreventLongPressGestureFromPropagating = true {
    willSet {
      let oldValue = self.shouldPreventLongPressGestureFromPropagating;
      
      guard newValue != oldValue,
            let longPressGestureRecognizer = self.longPressGestureRecognizer
      else { return };
      
      longPressGestureRecognizer.isEnabled = newValue;
    }
  };

  @objc public var isAuxiliaryPreviewEnabled = true {
    willSet {
      self.contextMenuManager?.isAuxiliaryPreviewEnabled = newValue;
    }
  };
  
  private(set) public var auxiliaryPreviewConfig: AuxiliaryPreviewConfig!;
  @objc public var auxiliaryPreviewConfigProp: Dictionary<String, Any>? {
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
    // TODO: WIP - To be re-impl.
    // guard let bridge = self.reactGetPaperBridge(),
    //       let targetNode = self.previewConfig.targetViewNode,
    //       let targetView = bridge.uiManager.view(forReactTag: targetNode)
    // else { return nil }
    //
    // return targetView;
    
    return nil;
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

  // MARK: Init
  // ----------
  
  public override init(frame: CGRect) {
    super.init(frame: frame);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  }
  
  // MARK: Functions
  // ---------------
  
  public override func didMoveToWindow() {
    guard self.window != nil,
          let parentReactView = self.parentReactView
    else { return };
    
    // if shouldAttachToParentVC {
    //   // begin setup - attach this view as child vc
    //   self.attachToParentVC();
    // };
    
    print(
      "RNIContextMenuViewDelegate.didMoveToWindow",
      "\n - reactProps:", self.reactProps.description,
      "\n"
    );
    
    self._setupContent();
    return;
  };
  
  func _setupContent(){
    guard !self._didSetup else { return };
    self._didSetup = true;
  };
  
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
    
    self.dispatchEvent(
      for: .onPressMenuItem,
      withPayload: dict
    );
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self._deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.dispatchEvent(
      for: .onRequestDeferredElement,
      withPayload: [
        "deferredID": deferredID,
      ]
    );
  };
  
  @objc func handleLongPressGesture(_ sender: UILongPressGestureRecognizer){
    // no-op
  };
  
  func attachToParentVC(){
    guard !self.didAttachToParentVC else { return };
        
    // find the nearest parent view controller
    let parentVC = self.recursivelyFindNextResponder(
      withType: UIViewController.self
    );
    
    guard let parentVC = parentVC else { return };
    self.didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.delegate = self;
    childVC.parentVC = parentVC;
    
    self.navEventsVC = childVC;

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
          let navEventsVC = self.navEventsVC
    else { return };
    
    navEventsVC.willMove(toParent: nil);
    navEventsVC.removeFromParent();
    navEventsVC.view.removeFromSuperview();
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
};

// MARK: - RNIContextMenuViewDelegate+RNIContentViewDelegate
// --------------------------------------------------

extension RNIContextMenuViewContent: RNIContentViewDelegate {

  public typealias KeyPathRoot = RNIContextMenuViewContent;

  // MARK: Paper + Fabric
  // --------------------
  
  public func notifyOnInit(sender: RNIContentViewParentDelegate) {
    print(
      "RNIContextMenuViewDelegate.notifyOnInit",
      "\n - reactProps:", self.reactProps.description,
      "\n"
    );
    return;
  };
    
  public func notifyOnMountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    #if !RCT_NEW_ARCH_ENABLED
    superBlock();
    #endif
    
    // Note: Window might not be available yet
    self.addSubview(childComponentView);
  };
  
  public func notifyOnUnmountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    #if !RCT_NEW_ARCH_ENABLED
    superBlock();
    #endif
    
  }
  
  public func notifyDidSetProps(sender: RNIContentViewParentDelegate) {
    // no-op
  };
  
  public func notifyOnUpdateLayoutMetrics(
    sender: RNIContentViewParentDelegate,
    oldLayoutMetrics: RNILayoutMetrics,
    newLayoutMetrics: RNILayoutMetrics
  ) {
    // no-op
  };
  
  public func notifyOnViewCommandRequest(
    sender: RNIContentViewParentDelegate,
    forCommandName commandName: String,
    withCommandArguments commandArguments: NSDictionary,
    resolve resolveBlock: (NSDictionary) -> Void,
    reject rejectBlock: (String) -> Void
  ) {
    
    switch commandName {
      case "presentMenu":
        break;
        
      case "dismissMenu":
        break;
        
      case "showAuxiliaryPreviewAsPopover":
        break;
        
      case "provideDeferredElements":
        break;
        
      default:
        rejectBlock("No matching command for commandName");
        return;
    };
  };
  
  // MARK: - Fabric Only
  // -------------------

  #if RCT_NEW_ARCH_ENABLED
  public func notifyOnUpdateProps(
    sender: RNIContentViewParentDelegate,
    oldProps: NSDictionary,
    newProps: NSDictionary
  ) {
    // no-op
  };
  
  public func notifyOnUpdateState(
    sender: RNIContentViewParentDelegate,
    oldState: NSDictionary?,
    newState: NSDictionary
  ) {
    // no-op
  };
  
  public func notifyOnFinalizeUpdates(
    sender: RNIContentViewParentDelegate,
    updateMaskRaw: Int,
    updateMask: RNIComponentViewUpdateMask
  ) {
    // no-op
  };
  
  public func notifyOnPrepareForReuse(sender: RNIContentViewParentDelegate) {
    self._didSetup = false;
  };
  
  public func shouldRecycleContentDelegate(
    sender: RNIContentViewParentDelegate
  ) -> Bool {
    return false;
  };
  #else
  
  // MARK: - Paper Only
  // ------------------
  
  #endif
};


// MARK: - RNINavigationEventsNotifiable
// -------------------------------------

extension RNIContextMenuViewContent: RNIMenuElementEventsNotifiable {

  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self.menuConfig else { return };
    self.updateContextMenuIfVisible(with: menuConfig);
  };
};

// MARK: - ContextMenuManagerDelegate
// ----------------------------------

extension RNIContextMenuViewContent: ContextMenuManagerDelegate {
 
  public func onRequestMenuAuxiliaryPreview(sender: ContextMenuManager) -> UIView? {
    guard let menuAuxiliaryPreviewView = self.menuAuxiliaryPreviewView
    else { return nil };
    
    // TODO: WIP - To be re-impl.
    // let layoutWrapperView = AutoLayoutWrapperView(frame: .zero);
    let layoutWrapperView = UIView(frame: .zero);
    layoutWrapperView.addSubview(menuAuxiliaryPreviewView);
    
    return layoutWrapperView;
  };
};

// MARK: - RNINavigationEventsNotifiable
// -------------------------------------

extension RNIContextMenuViewContent: RNINavigationEventsNotifiable {
  
  public func notifyViewControllerDidPop(
    sender: RNINavigationEventsReportingViewController
  ) {
    // TODO: WIP - To be re-impl.
    // try? self.viewCleanupMode
    //  .triggerCleanupIfNeededForViewControllerDidPopEvent(for: self);
  };
};

// MARK: - Temp
// ------------

//
//public class RNIContextMenuView:
//
//  // MARK: - Properties
//  // ------------------
//
//  override public var reactTag: NSNumber! {
//    didSet {
//      try? RNICleanableViewRegistryShared.register(
//        forDelegate: self,
//        shouldIncludeDelegateInViewsToCleanup: true,
//        shouldProceedCleanupWhenDelegateIsNil: true
//      );
//    }
//  };
//
//  // MARK: Init + Lifecycle
//  // ----------------------
//
//  public required init(appContext: AppContext? = nil) {
//    super.init(appContext: appContext);
//    
//    self.setupInitAuxiliaryPreviewConfigIfNeeded();
//    self.setupAddContextMenuInteraction();
//    self.setupAddGestureRecognizers();
//  };
//  
//  public required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented");
//  };
//  
//  deinit {
//    try? self.viewCleanupMode.triggerCleanupIfNeededForDeinit(
//      for: self,
//      shouldForceCleanup: true
//    );
//  };
//  
//  // MARK: - RN Lifecycle
//  // --------------------
//
//  
//  public override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
//    super.insertSubview(subview, at: atIndex);
//    
//    if let cleanableViewItem = self.associatedCleanableViewItem {
//      cleanableViewItem.viewsToCleanup.append(
//        .init(with: subview)
//      );
//    };
//    
//    guard let detachedView = subview as? RNIDetachedView,
//          let nativeID = detachedView.nativeID,
//          let nativeIDKey = NativeIDKey(rawValue: nativeID)
//    else { return };
//    
//    switch nativeIDKey {
//        case .contextMenuPreview:
//          self.menuCustomPreviewView?.cleanup();
//          self.menuCustomPreviewView = detachedView;
//        
//        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
//        case .contextMenuAuxiliaryPreview:
//          self.menuAuxiliaryPreviewView?.cleanup();
//          self.menuAuxiliaryPreviewView = detachedView;
//    };
//    
//    self.detachedViews.append(
//      .init(with: detachedView)
//    );
//    
//    try? detachedView.detach();
//  };
//  
//  public override func didMoveToSuperview() {
//    guard self.superview != nil else { return };
//    self._tempBeginDebugging();
//  };
//  
//  #if DEBUG
//  @objc func onRCTBridgeWillReloadNotification(_ notification: Notification){
//    self.cleanup();
//  };
//  #endif
//  
//  // MARK: - View Lifecycle
//  // ----------------------
//  
//  public override func didMoveToWindow() {
//    
//  };
//};
//
