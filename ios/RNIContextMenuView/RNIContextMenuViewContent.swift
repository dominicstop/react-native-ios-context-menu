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


@objc(RNIContextMenuViewContent)
public final class RNIContextMenuViewContent: UIView, RNIContentView {

  // MARK: - Embedded Types
  // ----------------------
  
  enum NativeIDKey: String {
    case detachedView;
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
    "menuConfig": \.menuConfigProp,
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
  
  public var detachedViewParent: RNIContentViewParentDelegate?;
  public var detachedViewContent: RNIDetachedViewContent?;
  
  public var menuCustomPreviewParent: RNIContentViewParentDelegate?;
  public var menuCustomPreviewContent: RNIWrapperViewContent?;
  
  public var menuAuxiliaryPreviewParent: RNIContentViewParentDelegate?;
  public var menuAuxiliaryPreviewContent: RNIWrapperViewContent?;
  
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
  @objc public var menuConfigProp: NSDictionary? {
    willSet {
      guard let newValue = newValue as? Dictionary<String, Any>,
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
  @objc public var previewConfigProp: NSDictionary? {
    willSet {
      guard let newValue = newValue as? Dictionary<String, Any> else {
        return;
      };
      
      let previewConfig = try? RNIMenuPreviewConfig(fromDict: newValue);
      self.previewConfig = previewConfig ?? .init();
      
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
  @objc public var auxiliaryPreviewConfigProp: NSDictionary? {
    willSet {
      guard let newValue = newValue as? Dictionary<String, Any>,
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
    guard let viewIdentifier = self.previewConfig.viewIdentifier else {
      return nil;
    };
    
    return viewIdentifier.getAssociatedView();
  };
  
  var menuPreviewTargetView: UIView {
    self.customMenuPreviewTargetView ?? self;
  };
  
  var menuTargetedPreview: UITargetedPreview {
    .init(
      view: self.menuPreviewTargetView,
      parameters: self.menuPreviewParameters
    );
  };
  
  var isUsingCustomPreview: Bool {
       self.previewConfig.previewType == .CUSTOM
    && self.menuCustomPreviewContent != nil
  };

  // MARK: Init
  // ----------
  
  public override init(frame: CGRect) {
    super.init(frame: frame);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  }
  
  // MARK: Functions - Setup
  // -----------------------
 
  func _setupIfNeeded(){
    guard !self._didSetup else { return };
    self._didSetup = true;
    
    self.setupInitAuxiliaryPreviewConfigIfNeeded();
    self.setupAddContextMenuInteraction();
    self.setupAddGestureRecognizers();
  };
  
  func setupInitAuxiliaryPreviewConfigIfNeeded(){
    guard self.isAuxiliaryPreviewEnabled,
          self.auxiliaryPreviewConfig == nil
    else {
      return;
    };
    
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
      menuTargetView: self
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
  
  // MARK: Functions
  // ---------------
  
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
  
  /// create custom menu preview based on `previewConfig` and `reactPreviewView`
  func createMenuPreview() -> UIViewController? {
  
    /// don't make preview if `previewType` is set to default.
    guard self.previewConfig.previewType != .DEFAULT else {
      return nil;
    };
    
    self.setDetachedViewsIfNeeded();
    
    // vc that holds the view to show in the preview
    let previewController = RNIContextMenuPreviewController();
    previewController.setup(with: self);
    previewController.view.isUserInteractionEnabled = true;
    
    self.previewController = previewController;
    return previewController;
  };
  
  func setDetachedViewsIfNeeded(){
    guard let detachedViewContent = self.detachedViewContent else {
      return;
    };
    
    let shouldGetDetachedViews =
         self.menuCustomPreviewParent == nil
      || self.menuCustomPreviewContent == nil
      || self.menuAuxiliaryPreviewParent == nil
      || self.menuAuxiliaryPreviewContent == nil;
      
    guard shouldGetDetachedViews else {
      return;
    };
    
    try? detachedViewContent.detachSubviews();

    detachedViewContent.detachedViews.forEach {
      guard let nativeID = $0.reactNativeID,
            let nativeIDKey = NativeIDKey(rawValue: nativeID),
            let contentDelegate = $0.contentDelegate as? RNIWrapperViewContent
      else {
        return;
      };
      
      switch (nativeIDKey) {
        case .contextMenuPreview:
          self.menuCustomPreviewParent = $0;
          self.menuCustomPreviewContent = contentDelegate;
          
        case .contextMenuAuxiliaryPreview:
          self.menuAuxiliaryPreviewParent = $0;
          self.menuAuxiliaryPreviewContent = contentDelegate;
        
        default:
          break;
      };
    };
  };
  
  func setAuxiliaryPreviewConfigSizeIfNeeded(){
    guard let menuAuxiliaryPreviewParent = self.menuAuxiliaryPreviewParent,
          self.auxiliaryPreviewConfig != nil
    else { return };
    
    if self.auxiliaryPreviewConfig!.preferredWidth == nil {
      self.auxiliaryPreviewConfig!.preferredWidth = .constant(
        menuAuxiliaryPreviewParent.bounds.width
      );
    };
    
    if self.auxiliaryPreviewConfig!.preferredHeight == nil {
      self.auxiliaryPreviewConfig!.preferredHeight = .constant(
        menuAuxiliaryPreviewParent.bounds.height
      );
    };
    
    self.contextMenuManager?.auxiliaryPreviewConfig = self.auxiliaryPreviewConfig;
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
    // no-op
  };
    
  public func notifyOnMountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    
    var shouldAddAsSubview = true;
    
    defer {
      if shouldAddAsSubview {
        self.addSubview(childComponentView);
      };
    };
    
    guard let customNativeView = childComponentView as? RNIContentViewParentDelegate,
          let nativeID = childComponentView.reactNativeID,
          let nativeIDKey = NativeIDKey(rawValue: nativeID)
    else {
      return;
    };
    
    switch (customNativeView.contentDelegate, nativeIDKey) {
      case (
        let detachedViewContent as RNIDetachedViewContent,
        .detachedView
      ):
        self.detachedViewParent = customNativeView;
        self.detachedViewContent = detachedViewContent;
        
        self.setDetachedViewsIfNeeded();
        shouldAddAsSubview = false;
        
      default:
        break;
    };
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
    
    childComponentView.removeFromSuperview();
  };
  
  public func notifyDidSetProps(sender: RNIContentViewParentDelegate) {
    self._setupIfNeeded();
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
    resolve resolveBlock: @escaping RNIContentView.PromiseCompletionBlock,
    reject rejectBlock: @escaping RNIContentView.PromiseRejectionBlock
  ) {
    
    do {
      guard let commandArguments = commandArguments as? Dictionary<String, Any> else {
        throw RNIContextMenuError(
            errorCode: .invalidValue,
            description: "Unable to parse commandArguments",
            extraDebugValues: [
              "commandName": commandName,
              "commandArguments": commandArguments,
            ]
          );
      };
      
      switch commandName {
        case "presentMenu":
          try self.presentMenu();
          resolveBlock([:]);
          
        case "dismissMenu":
          try self.dismissMenu();
          resolveBlock([:]);
          
        case "showAuxiliaryPreviewAsPopover":
          try self.showAuxiliaryPreviewAsPopover();
          resolveBlock([:]);
          
        case "provideDeferredElements":
          let deferredID: String =
            try commandArguments.getValueFromDictionary(forKey: "deferredID");
            
          let menuElementsRaw: [Any] =
            try commandArguments.getValueFromDictionary(forKey: "menuItems");
            
          let menuElements: [RNIMenuElement] = menuElementsRaw.compactMap {
            guard let dict = $0 as? Dictionary<String, Any> else {
              return nil;
            };
            
            return (
                 RNIMenuItem(dictionary: dict)
              ?? RNIMenuActionItem(dictionary: dict)
              ?? RNIDeferredMenuElement(dictionary: dict)
              ?? RNIMenuElement(dictionary: dict)
            );
          };
          
          try self.provideDeferredElements(
            id: deferredID,
            menuElements: menuElements
          );
          
          resolveBlock([:]);
          
        default:
          throw RNIContextMenuError(
            errorCode: .invalidValue,
            description: "No matching command for commandName",
            extraDebugValues: [
              "commandName": commandName,
              "commandArguments": commandArguments,
            ]
          );
      };
    
    } catch {
      rejectBlock(error.localizedDescription);
    };
  };
  
  // MARK: - Fabric Only
  // -------------------

  #if RCT_NEW_ARCH_ENABLED
  public func shouldRecycleContentDelegate(
    sender: RNIContentViewParentDelegate
  ) -> Bool {
    return false;
  };
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
 
  public func onRequestMenuAuxiliaryPreview(
    sender: ContextMenuManager
  ) -> UIView? {
    
    guard let menuAuxiliaryPreviewParent = self.menuAuxiliaryPreviewParent else {
      return nil;
    };
    
    let auxPreviewController = RNIBaseViewController();
    auxPreviewController.rootReactView = menuAuxiliaryPreviewParent;
    
    return auxPreviewController.view;
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
//          self.menuCustomPreviewContent?.cleanup();
//          self.menuCustomPreviewContent = detachedView;
//        
//        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
//        case .contextMenuAuxiliaryPreview:
//          self.menuAuxiliaryPreviewParent?.cleanup();
//          self.menuAuxiliaryPreviewParent = detachedView;
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
