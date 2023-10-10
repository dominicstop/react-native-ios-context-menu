//
//  RNIContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;

//  TODO: Add capability constants
/// E.g. `supportsUpdatingMenuWhileVisible`, `supportsDeferredElements` etc.

@available(iOS 13, *)
class RNIContextMenuView: UIView {
  
  enum NativeIDKey: String {
    case contextMenuPreview;
    case contextMenuAuxiliaryPreview;
  };
  
  private enum AnchorPosition: String {
    case top;
    case bottom;
  };
  
  // MARK: - Properties
  // ------------------
  
  weak var bridge: RCTBridge!;
  
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  /// contains the view to show in the preview
  var previewWrapper: RNIWrapperView?;
  var previewController: RNIContextMenuPreviewController?;
  
  weak var viewController: RNINavigationEventsReportingViewController?;
      
  private var deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
  
  // MARK: - Properties - Fags
  // -------------------------
  
  /// Keep track on whether or not the context menu is currently visible.
  var isContextMenuVisible = false;
  
  /// This is set to `true` when the menu is open and an item is pressed, and is immediately set back
  /// to `false` once the menu close animation finishes.
  var didPressMenuItem = false;
  
  /// Whether or not `cleanup` method was called
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
  // MARK: - Properties - Feature Flags
  // ----------------------------------
  
  private var shouldEnableAttachToParentVC: Bool {
    self.cleanupMode == .viewController
  };
  
  private var shouldEnableCleanup: Bool {
    self.cleanupMode != .disabled
  };
  
  // MARK: - Properties - "Auxiliary Preview"-Related (Experimental)
  // ---------------------------------------------------------------
  
  /// Keep track on whether or not the aux. preview is currently visible.
  var isAuxPreviewVisible = false;

  /// Holds the view to be shown in the auxiliary preview
  var previewAuxiliaryViewWrapper: RNIWrapperView?;
  
  /// Cached value - in which side of the preview was aux. preview attached to?
  /// Cleared when the aux. preview is hidden.
  private var morphingPlatterViewPlacement: AnchorPosition?;
  
  // MARK: - RN Exported Event Props
  // -------------------------------
  
  @objc var onMenuWillShow  : RCTBubblingEventBlock?;
  @objc var onMenuWillHide  : RCTBubblingEventBlock?;
  @objc var onMenuWillCancel: RCTBubblingEventBlock?;
  
  @objc var onMenuDidShow  : RCTBubblingEventBlock?;
  @objc var onMenuDidHide  : RCTBubblingEventBlock?;
  @objc var onMenuDidCancel: RCTBubblingEventBlock?;
  
  @objc var onPressMenuItem   : RCTBubblingEventBlock?;
  @objc var onPressMenuPreview: RCTBubblingEventBlock?;
  
  @objc var onMenuWillCreate: RCTBubblingEventBlock?;
  @objc var onRequestDeferredElement: RCTBubblingEventBlock?;
  
  // MARK: - RN Exported Event Props - "Auxiliary Preview"-Related (Experimental)
  // ----------------------------------------------------------------------------

  @objc var onMenuAuxiliaryPreviewWillShow: RCTBubblingEventBlock?;
  @objc var onMenuAuxiliaryPreviewDidShow : RCTBubblingEventBlock?;
  
  // MARK: - RN Exported Props
  // -------------------------
    
  private var _menuConfig: RNIMenuItem?;
  @objc var menuConfig: NSDictionary? {
    didSet {
      guard
        let menuConfigDict = self.menuConfig, menuConfigDict.count > 0,
        let menuConfig     = RNIMenuItem(dictionary: menuConfigDict)
      else {
        self._menuConfig = nil;
        return;
      };
      
      menuConfig.delegate = self;
      
      menuConfig.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle =
        self.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle;
      
      self.updateContextMenuIfVisible(with: menuConfig);
      
      // cleanup `deferredElementCompletionMap`
      self.cleanupOrphanedDeferredElements(currentMenuConfig: menuConfig);
      
      // update config
      self._menuConfig = menuConfig;
    }
  };
  
  private var _previewConfig = PreviewConfig();
  @objc var previewConfig: NSDictionary? {
    didSet {
      guard let dictionary = self.previewConfig
      else { return };
      
      let previewConfig = PreviewConfig(dictionary: dictionary);
      self._previewConfig = previewConfig;
      
      // update the vc's previewConfig
      if let previewController = self.previewController {
        previewController.previewConfig = previewConfig;
      };
    }
  };
  
  @objc var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  @objc var isContextMenuEnabled = true;
  
  private var _internalCleanupMode: RNICleanupMode = .automatic;
  @objc var internalCleanupMode: String? {
    willSet {
      guard
        let rawString = newValue,
        let cleanupMode = RNICleanupMode(rawValue: rawString)
      else { return };
      
      self._internalCleanupMode = cleanupMode;
    }
  };
  
  // MARK: - RN Exported Props: "Auxiliary Context Menu Preview"-Related (Experimental)
  // ----------------------------------------------------------------------------------
  
  @objc var isAuxiliaryPreviewEnabled = true;
  
  private var _auxiliaryPreviewConfig: RNIContextMenuAuxiliaryPreviewConfig?;
  @objc var auxiliaryPreviewConfig: NSDictionary? {
    didSet {
      guard
        let configDict = self.auxiliaryPreviewConfig,
        configDict.count > 0
      else {
        self._auxiliaryPreviewConfig = nil;
        return;
      };
      
      let config = RNIContextMenuAuxiliaryPreviewConfig(dictionary: configDict);
      self._auxiliaryPreviewConfig = config;
    }
  };
  
  // MARK: - Computed Properties
  // ---------------------------
  
  var isUsingCustomPreview: Bool {
    self._previewConfig.previewType == .CUSTOM && self.previewWrapper != nil
  };
  
  var cleanupMode: RNICleanupMode {
    get {
      switch self._internalCleanupMode {
        case .automatic: return .reactComponentWillUnmount;
        default: return self._internalCleanupMode;
      };
    }
  };

  // MARK: - Computed Properties - "Auxiliary Context Menu Preview"-Related
  // ----------------------------------------------------------------------
  
  /// Gets the `_UIContextMenuContainerView` that's holding the context menu controls.
  /// **Note**: This `UIView` instance  only exists whenever there's a context menu interaction.
  ///
  /// Contains the ff. subviews:
  /// * `UIVisualEffectView` - BG blur view
  /// * `UIView` - Holds `_UIMorphingPlatterView`  and `_UIContextMenu`
  ///
  /// Debug Description
  /// ```
  /// <_UIContextMenuContainerView:
  ///   frame = (0 0; 375 667); autoresize = W+H;
  ///   gestureRecognizers = <NSArray>;
  ///   layer = <CALayer>;
  /// >
  /// ```
  ///
  /// View Hierarchy (as of iOS `15.2`)
  /// ```
  /// <_UIContextMenuContainerView>
  ///    // Blur background view
  ///    <UIVisualEffectView>
  ///      <_UIVisualEffectBackdropView/>
  ///    </UIVisualEffectView>
  ///
  ///    // Contains the context menu preview and list items, as well as
  ///    // the aux. preview.
  ///    <UIView>
  ///      // Contains the context menu preview
  ///      <_UIMorphingPlatterView>
  ///        <_UIPlatterSoftShadowView/>
  ///        <_UIPlatterClippingView/>
  ///        <_UIPlatterClippingView/>
  ///      </_UIMorphingPlatterView>
  ///
  ///      // Contains the context menu list
  ///      <_UIContextMenuView>
  ///        <_UIContextMenuListView>
  ///          <UIView>
  ///            <UIView>
  ///
  ///              // Blur backdrop for menu items list
  ///              <UIVisualEffectView>
  ///                <_UIVisualEffectBackdropView/>
  ///              </UIVisualEffectView>
  ///
  ///             // Contains the menu items
  ///             <UICollectionView/>
  ///
  ///            </UIView>
  ///          </UIView>
  ///        </_UIContextMenuListView>
  ///      </_UIContextMenuView>
  ///
  ///      // This is the aux. preview we inserted...
  ///      <RCTView/>
  ///    </UIView>
  /// </_UIContextMenuContainerView>
  /// ```
  var contextMenuContainerView: UIView? {
    self.window?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) > 0
    };
  };
  
  /// Will return the ff. subviews:
  /// * `_UIMorphingPlatterView` - Contains the context menu preview
  /// * `_UIContextMenu` - Holds the context menu items
  ///
  var contextMenuContentContainer: UIView? {
    self.contextMenuContainerView?.subviews.first {
      !($0 is UIVisualEffectView) && $0.subviews.count > 0
    };
  };
  
  /// Holds the context menu preview
  var morphingPlatterView: UIView? {
    self.contextMenuContentContainer?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) == 1;
    };
  };
  
  /// Holds the context menu items
  var contextMenuItemsView: UIView? {
    self.contextMenuContentContainer?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) > 1;
    };
  };
  
  var isPreviewAuxiliaryViewAttached: Bool {
    self.previewAuxiliaryViewWrapper != nil;
  };
  
  /// Shorthand to get the "preview view" that we want to display in the context menu preview.
  ///
  /// Note: This is the view that we received from JS side via `RNIWrapperView`.
  /// The wrapper view  is configured to use "dummy mode".
  var previewAuxiliaryView: UIView? {
    self.previewAuxiliaryViewWrapper?.reactViews.first
  };
  
  // MARK: - Init
  // ------------
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    
    self.bridge = bridge;
    
    // Add context menu interaction...
    self.setupAddContextMenuInteraction();
    
    #if DEBUG
    // `RCTInvalidating` doesn't trigger in view instance, so use observer
    NotificationCenter.default.addObserver(self,
      selector: #selector(self.onRCTBridgeWillReloadNotification),
      name: NSNotification.Name(rawValue: "RCTBridgeWillReloadNotification"),
      object: nil
    );
    #endif
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  // MARK: - RN Lifecycle
  // --------------------

  override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    super.insertSubview(subview, at: atIndex);
    
    if let wrapperView = subview as? RNIWrapperView,
       let nativeID    = subview.nativeID,
       let nativeIDKey = NativeIDKey(rawValue: nativeID) {
      
      wrapperView.isMovingToParent = true;
      
      switch nativeIDKey {
        case .contextMenuPreview:
          // if prev. exist, cleanup first.
          if self.previewWrapper !== wrapperView {
            self.previewWrapper?.cleanup();
          };
          
          self.previewWrapper = wrapperView;
        
        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
        case .contextMenuAuxiliaryPreview:
          // if prev. exist, cleanup first
          if self.previewAuxiliaryViewWrapper !== wrapperView {
            self.previewAuxiliaryViewWrapper?.cleanup();
          };
          
          self.previewAuxiliaryViewWrapper = wrapperView;
      };
      
      wrapperView.removeFromSuperview();
      wrapperView.isMovingToParent = false;
    };
  };
  
  #if DEBUG
  @objc func onRCTBridgeWillReloadNotification(_ notification: Notification){
    self.cleanup();
  };
  #endif
  
  // MARK: - View Lifecycle
  // ----------------------
  
  public override func didMoveToWindow() {
    
    let isMovingToNilWindow = self.window == nil;
    
    // not attached to parent vc yet...
    if !self.didAttachToParentVC {
     
      if isMovingToNilWindow {
        // moving to nil window and not attached to parent vc,
        // possible end of lifecycle for this view...
        //
        // trigger manual cleanup
        self.cleanup();
        
      } else {
        // Moving to a non-nil window and is not attached to a parent yet...
        //
        // The VC attached to this view is possibly being attached as a child
        // view controller to a view controller managed by
        // `UINavigationController`...
        //
        // begin setup - attach this view as child vc
        self.attachToParentVC();
      };
    };
  };
};

// MARK: - View Module Commands
// ----------------------------

@available(iOS 13, *)
extension RNIContextMenuView {
  func dismissMenu(){
    self.contextMenuInteraction?.dismissMenu();
  };
  
  // TODO: Add error throws
  func provideDeferredElements(id deferredID: String, menuElements: [RNIMenuElement]){
    if let completion = self.deferredElementCompletionMap[deferredID] {

      // create + add menu elements
      completion( menuElements.compactMap { menuElement in
        menuElement.createMenuElement(
          actionItemHandler: { [unowned self] in
            self.handleOnPressMenuActionItem(dict: $0, action: $1);
            
          }, deferredElementHandler: { [unowned self] in
            self.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
          }
        );
      });
      
      // cleanup
      self.deferredElementCompletionMap.removeValue(forKey: deferredID);
    };
  };
};

// MARK: - Private Functions
// -------------------------

@available(iOS 13, *)
fileprivate extension RNIContextMenuView {
  
  /// Add a context menu interaction to view
  func setupAddContextMenuInteraction(){
    self.contextMenuInteraction = {
      let interaction = UIContextMenuInteraction(delegate: self);
      self.addInteraction(interaction);
      
      return interaction;
    }();
  };
  
  func createMenu(with menuConfig: RNIMenuItem? = nil) -> UIMenu? {
    guard let menuConfig = menuConfig ?? self._menuConfig
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
    // alias to variable
    let previewConfig = self._previewConfig;
    
    /// don't make preview if `previewType` is set to default.
    guard previewConfig.previewType != .DEFAULT
    else { return nil };
    
    // vc that holds the view to show in the preview
    let vc = RNIContextMenuPreviewController();
    vc.previewWrapper = self.previewWrapper;
    vc.previewConfig = previewConfig;
    vc.view.isUserInteractionEnabled = true;
    
    self.previewController = vc;
    return vc;
  };
  
  /// configure target preview based on `previewConfig`
  func makeTargetedPreview() -> UITargetedPreview {
    // alias to variable
    let previewConfig = self._previewConfig;
    
    // create preview parameters based on `previewConfig`
    let parameters: UIPreviewParameters = {
      let param = UIPreviewParameters();
      
      // set preview bg color
      param.backgroundColor = previewConfig.backgroundColor;
      
      // set the preview border shape
      if let borderRadius = previewConfig.borderRadius {
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
    }();
    
    if let targetNode = previewConfig.targetViewNode,
       let targetView = self.bridge.uiManager.view(forReactTag: targetNode) {
      
      // A - Targeted preview provided....
      return UITargetedPreview(
        view: targetView,
        parameters: parameters
      );
      
    } else {
      // B - No targeted preview provided....
      return UITargetedPreview(
        view: self,
        parameters: parameters
      );
    };
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
    self.onPressMenuItem?(dict);
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self.deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.onRequestDeferredElement?([
      "deferredID": deferredID,
    ]);
  };
  
  func attachToParentVC(){
    guard self.shouldEnableAttachToParentVC,
          !self.didAttachToParentVC,
          
          // find the nearest parent view controller
          let parentVC = RNIUtilities
            .getParent(responder: self, type: UIViewController.self)
    else { return };
    
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
    guard self.deferredElementCompletionMap.count > 0
    else { return };
    
    let currentDeferredElements = RNIMenuElement.recursivelyGetAllElements(
      from: currentMenuConfig,
      ofType: RNIDeferredMenuElement.self
    );
      
    // get the deferred elements that are not in the new config
    let orphanedKeys = self.deferredElementCompletionMap.keys.filter { deferredID in
      !currentDeferredElements.contains {
        $0.deferredID == deferredID
      };
    };
    
    // cleanup
    orphanedKeys.forEach {
      self.deferredElementCompletionMap.removeValue(forKey: $0);
    };
  };
  
  func detachFromParentVCIfAny(){
    guard !self.didAttachToParentVC,
          let childVC = self.viewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  func attachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating!
  ){

    guard self.isAuxiliaryPreviewEnabled,
          let previewAuxiliaryViewWrapper = self.previewAuxiliaryViewWrapper,
          let previewAuxiliaryView = self.previewAuxiliaryView,
          
          let contextMenuContentContainer = self.contextMenuContentContainer,
          let contextMenuContainerView = self.contextMenuContainerView,
          let morphingPlatterView = self.morphingPlatterView
    else { return };
    
    // MARK: Prep - Set Constants
    // --------------------------
    
    let auxConfig = self._auxiliaryPreviewConfig
      ?? RNIContextMenuAuxiliaryPreviewConfig(dictionary: [:]);
    
    // where should the aux. preview be attached to?
    let targetView = self.isUsingCustomPreview
      ? morphingPlatterView
      : contextMenuContentContainer;
    
    let auxiliaryViewHeight: CGFloat = {
      // Begin inferring the height of the aux. view...
      
      // A - Use height from config
      if let height = auxConfig.height {
        return height;
      };
      
      // B - Infer aux preview height from view
      return previewAuxiliaryView.frame.height;
    }();
    
    let auxiliaryViewWidth: CGFloat = {
      // Begin inferring the width of the aux. view...
      
      switch auxConfig.alignmentHorizontal {
        // A - Set aux preview width to window width
        case .stretchScreen:
          return contextMenuContainerView.frame.width;
        
        // B - Set aux preview width to preview width
        case .stretchPreview:
          return morphingPlatterView.frame.width;
        
        // C - Infer aux config or aux preview width from view...
        default:
          return auxConfig.width ?? previewAuxiliaryView.frame.width;
      };
    }();
    
    /// distance of aux. preview from the context menu preview
    let marginInner = auxConfig.marginPreview;
    
    /// distance of the aux. preview from the edges of the screen
    let marginOuter = auxConfig.marginAuxiliaryPreview;
    
    // amount to add to width - fix for layout bug
    //
    // if you use the actual width, it triggers a bug w/ autolayout where the
    // aux. preview snaps to the top of the screen...
    let adj = 0.5;
    
    let previewAuxiliaryViewSize = CGSize(
      width : auxiliaryViewWidth + adj,
      height: auxiliaryViewHeight
    );
    
    // MARK: Prep - Determine Size and Position
    // ----------------------------------------
    
    /// * Determine the size and position of the context menu preview.
    /// * Determine where to place the aux. preview in relation to the context menu preview.
    
    /// Based on the current "menu config", does it have menu items?
    let menuConfigHasMenuItems: Bool = {
      guard let menuItems = self._menuConfig?.menuItems
      else { return false };
      
      return menuItems.count > 0;
    }();
    
    /// if the context menu has "menu items", where is it located in relation to the "menu preview"?
    let menuItemsPlacement: AnchorPosition? = {
      guard menuConfigHasMenuItems,
            let contextMenuItemsView = self.contextMenuItemsView
      else { return nil };
      
      let previewFrame = morphingPlatterView.frame;
      let menuItemsFrame = contextMenuItemsView.frame;
      
      return (menuItemsFrame.midY < previewFrame.midY) ? .bottom : .top;
    }();
    
    /// in which vertical half does the "context menu preview" fall into?
    let morphingPlatterViewPlacement: AnchorPosition = {
      let previewFrame = morphingPlatterView.frame;
      let screenBounds = UIScreen.main.bounds;
      
      return (previewFrame.midY < screenBounds.midY) ? .top : .bottom;
    }();
    
    /// whether to attach the `auxiliaryView` on the top or bottom of the context menu
    let shouldAttachToTop: Bool = {
      switch auxConfig.anchorPosition {
        case .top   : return true;
        case .bottom: return false;
          
        case .automatic: break;
      };
      
      switch menuItemsPlacement {
        case .top   : return true;
        case .bottom: return false;
          
        default:
          // the context menu does not have menu items, determine anchor position
          // of auxiliary view via the position of the preview in the screen
          return morphingPlatterViewPlacement == .bottom;
      };
    }();
    
    // temp. save aux. preview position for later...
    self.morphingPlatterViewPlacement = morphingPlatterViewPlacement;

    // MARK: Prep - Compute Offsets
    // ----------------------------
    
    /// the amount to nudge the context menu
    let yOffset: CGFloat = {
      let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets;
      
      let previewFrame = morphingPlatterView.frame;
      let screenHeight = UIScreen.main.bounds.height;
      
      let marginBase = marginInner + marginOuter;
      
      switch morphingPlatterViewPlacement {
        case .top:
          let topInsets = safeAreaInsets?.top ?? 0;
          let margin = marginBase + topInsets;
          
          let minEdgeY = auxiliaryViewHeight + topInsets + margin;
          let distanceToEdge = auxiliaryViewHeight - previewFrame.minY;
        
          return (previewFrame.minY <= minEdgeY)
            ? max((distanceToEdge + margin), 0)
            : 0;
          
        case .bottom:
          let bottomInsets = safeAreaInsets?.bottom ?? 0;
          let margin = marginBase + bottomInsets;
          
          let tolerance = auxiliaryViewHeight + margin;
          let maxEdgeY = screenHeight - tolerance;
          let previewFrameMaxY = previewFrame.maxY + marginInner;
          
          let distanceToEdge = screenHeight - previewFrame.maxY;
          
          return (previewFrameMaxY > maxEdgeY)
            ? -(auxiliaryViewHeight - distanceToEdge + margin)
            : 0;
      };
    }();
    
    // MARK: Set Layout
    // ----------------
    
    // Bugfix: Stop bubbling touch events from propagating to parent
    previewAuxiliaryView.addGestureRecognizer(
      UITapGestureRecognizer(target: nil, action: nil)
    );
    
    /// manually set size of aux. preview
    previewAuxiliaryViewWrapper
      .notifyForBoundsChange(size: previewAuxiliaryViewSize);

    /// enable auto layout
    previewAuxiliaryView.translatesAutoresizingMaskIntoConstraints = false;
    
    /// attach `auxiliaryView` to context menu preview
    targetView.addSubview(previewAuxiliaryView);
    
    // set layout constraints based on config
    NSLayoutConstraint.activate({
      
      // set initial constraints
      var constraints: Array<NSLayoutConstraint> = [
        // set aux preview height
        previewAuxiliaryView.heightAnchor
          .constraint(equalToConstant: auxiliaryViewHeight),
      ];
      
      // set vertical alignment constraint - i.e. either...
      constraints.append(shouldAttachToTop
       // A - pin to top or...
       ? previewAuxiliaryView.bottomAnchor
         .constraint(equalTo: morphingPlatterView.topAnchor, constant: -marginInner)
       
       // B - pin to bottom.
       : previewAuxiliaryView.topAnchor
          .constraint(equalTo: morphingPlatterView.bottomAnchor, constant: marginInner)
      );
      
      // set horizontal alignment constraints based on config...
      constraints += {
        switch auxConfig.alignmentHorizontal {
          // A - pin to left
          case .previewLeading: return [
            previewAuxiliaryView.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
            
            previewAuxiliaryView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // B - pin to right
          case .previewTrailing: return [
            previewAuxiliaryView.rightAnchor.constraint(
              equalTo: morphingPlatterView.rightAnchor),
            
            previewAuxiliaryView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // C - pin to center
          case .previewCenter: return [
            previewAuxiliaryView.centerXAnchor
              .constraint(equalTo: morphingPlatterView.centerXAnchor),
            
            previewAuxiliaryView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // D - match preview size
          case .stretchPreview: return [
            previewAuxiliaryView.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
            
            previewAuxiliaryView.trailingAnchor
              .constraint(equalTo: morphingPlatterView.trailingAnchor),
          ];
          
          // E - stretch to edges of screen
          case .stretchScreen: return [
            previewAuxiliaryView.leadingAnchor
              .constraint(equalTo: contextMenuContainerView.leadingAnchor),
            
            previewAuxiliaryView.trailingAnchor
              .constraint(equalTo: contextMenuContainerView.trailingAnchor),
          ];
        };
      }();
      
      return constraints;
    }());
    
    //  MARK: Show Aux. View - Prep
    // ----------------------------
    
    let transitionConfigEntrance = auxConfig.transitionConfigEntrance;
    
    // object to send to js when the "will/did" show events fire
    let eventObject: Dictionary<String, Any> = [
      "size": [
        "width" : previewAuxiliaryViewSize.width,
        "height": previewAuxiliaryViewSize.height,
      ],
      
      "menuHasItems": menuConfigHasMenuItems,
      "menuItemsPlacement": menuItemsPlacement?.rawValue ?? "unknown",
      "previewPosition": morphingPlatterViewPlacement.rawValue,
      "isAuxiliaryPreviewAttachedToTop": shouldAttachToTop,
    ];
    
    // closures to set the start/end values for the entrance transition
    let (setTransitionStateStart, setTransitionStateEnd): (() -> (), () -> ()) = {
      var transform = previewAuxiliaryView.transform;
      
      let setTransformForTransitionSlideStart = { (yOffset: CGFloat) in
        switch morphingPlatterViewPlacement {
          case .top:
            transform = transform.translatedBy(x: 0, y: -yOffset);
            
          case .bottom:
            transform = transform.translatedBy(x: 0, y: yOffset);
        };
      };
      
      let setTransformForTransitionZoomStart = { (scaleOffset: CGFloat) in
        let scale = 1 - scaleOffset;
        transform = transform.scaledBy(x: scale, y: scale);
      };
      
      switch auxConfig.transitionConfigEntrance.transition {
        case .fade: return ({
          // A - fade - entrance transition
          previewAuxiliaryView.alpha = 0;
        }, {
          // B - fade - exit transition
          previewAuxiliaryView.alpha = 1;
        });
          
        case let .slide(slideOffset): return ({
          // A - slide - entrance transition
          // fade - start
          previewAuxiliaryView.alpha = 0;
          
          // slide - start
          setTransformForTransitionSlideStart(slideOffset);
          
          // apply transform
          previewAuxiliaryView.transform = transform;
          
        }, {
          // B - slide - exit transition
          // fade - end
          previewAuxiliaryView.alpha = 1;
 
          // slide - end - reset transform
          previewAuxiliaryView.transform = .identity;
        });
          
        case let .zoom(zoomOffset): return ({
            // A - zoom - entrance transition
            // fade - start
            previewAuxiliaryView.alpha = 0;
            
            // zoom - start
            setTransformForTransitionZoomStart(zoomOffset);
            
            // start - apply transform
            previewAuxiliaryView.transform = transform;
            
          }, {
            // B - zoom - exit transition
            // fade - end
            previewAuxiliaryView.alpha = 1;
            
            // zoom - end - reset transform
            previewAuxiliaryView.transform = .identity;
          });
          
        case let .zoomAndSlide(slideOffset, zoomOffset): return ({
          // A - zoomAndSlide - entrance transition
          // fade - start
          previewAuxiliaryView.alpha = 0;
        
          // slide - start
          setTransformForTransitionSlideStart(slideOffset);
          
          // zoom - start
          setTransformForTransitionZoomStart(zoomOffset);
          
          // start - apply transform
          previewAuxiliaryView.transform = transform;
                    
        }, {
          // B - zoomAndSlide - exit transition
          // fade - end
          previewAuxiliaryView.alpha = 1;
          
          // slide/zoom - end - reset transform
          previewAuxiliaryView.transform = .identity;
        });
          
        case .none:
          // don't use any entrance transitions...
          fallthrough;
          
        default:
          // noop entrance + exit transition
          return ({},{});
      };
    }();
    
    // MARK: Show Aux. View
    // --------------------
    
    // trigger will show event
    self.onMenuAuxiliaryPreviewWillShow?([:]);
    self.isAuxPreviewVisible = true;
    
    // transition - set start/initial values
    setTransitionStateStart();
    
    // MARK: Bugfix - Aux-Preview Touch Event on Screen Edge
    let shouldSwizzle = yOffset != 0;
    if shouldSwizzle {
      Self.auxPreview = previewAuxiliaryView;
      Self.swizzlePoint();
    };
    
    UIView.animate(
      withDuration: transitionConfigEntrance.duration,
      delay       : transitionConfigEntrance.delay,
      options     : transitionConfigEntrance.options,
      animations  : {

        // transition in - set end values
        setTransitionStateEnd();
        
        // offset from anchor
        contextMenuContentContainer.frame =
          contextMenuContentContainer.frame.offsetBy(dx: 0, dy: yOffset)
      
      }, completion: {_ in
        // trigger did show event
        self.onMenuAuxiliaryPreviewDidShow?(eventObject);
      }
    );
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  func detachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating?
  ){
    
    guard self.isAuxiliaryPreviewEnabled,
          self.isAuxPreviewVisible,
          
          let animator = animator,
          let previewAuxiliaryView = self.previewAuxiliaryView
    else { return };
    
    /// Bug:
    /// * "Could not locate shadow view with tag #, this is probably caused by a temporary inconsistency
    ///   between native views and shadow views."
    /// * Triggered when the menu is about to be hidden, iOS removes the context menu along with the
    ///   `previewAuxiliaryViewContainer`
    ///
    
    // reset flag
    self.isAuxPreviewVisible = false;
    
    // Add exit transition
    animator.addAnimations { [unowned self] in
      var transform = previewAuxiliaryView.transform;
      
      // transition - fade out
      previewAuxiliaryView.alpha = 0;
      
      // transition - zoom out
      transform = transform.scaledBy(x: 0.7, y: 0.7);
      
      // transition - slide out
      switch self.morphingPlatterViewPlacement {
        case .top:
          transform = transform.translatedBy(x: 0, y: 50);
          
        case .bottom:
          transform = transform.translatedBy(x: 0, y: -50);
          
        default: break;
      };
      
      // transition - apply transform
      previewAuxiliaryView.transform = transform;
    };
    
    animator.addCompletion { [unowned self] in
      previewAuxiliaryView.removeFromSuperview();
      
      // clear value
      self.morphingPlatterViewPlacement = nil;
      
      // MARK: Bugfix - Aux-Preview Touch Event on Screen Edge
      if Self.isSwizzlingApplied {
        // undo swizzling
        Self.swizzlePoint();
        Self.auxPreview = nil;
      };
    };
  };
};

// MARK: - UIContextMenuInteractionDelegate
// ----------------------------------------

@available(iOS 13, *)
extension RNIContextMenuView: UIContextMenuInteractionDelegate {
  
  // create context menu
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint
  ) -> UIContextMenuConfiguration? {
    
    guard self.isContextMenuEnabled else { return nil };
    
    self.onMenuWillCreate?([:]);
    
    // Note: Xcode beta + running on device (iPhone XR + iOS 15.1) causes
    // crashes when the context menu is being created
    return UIContextMenuConfiguration(
      identifier     : nil,
      previewProvider: self.createMenuPreview,
      actionProvider : { [unowned self] _ in
        self.createMenu();
      }
    );
  };
  
  // context menu display begins
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willDisplayMenuFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    
    self.isContextMenuVisible = true;
    self.onMenuWillShow?([:]);
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    let transitionEntranceDelay = self._auxiliaryPreviewConfig?
      .transitionEntranceDelay ?? .AFTER_PREVIEW;
    
    let shouldUseAlternateWayToShowAuxPreview =
      transitionEntranceDelay != .AFTER_PREVIEW;
    
    
    // A - show context menu auxiliary preview via new way
    // i.e. immediately show aux. preview but with a slight delay
    if shouldUseAlternateWayToShowAuxPreview {
      
      // the animator does not have a `percentComplete` - so this is just a guess
      // on how long the context menu entrance animation is
      //
      // Note: will break if slow animations enabled
      let delay = transitionEntranceDelay.seconds;
      
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
        self?.attachContextMenuAuxiliaryPreviewIfAny(nil);
      };
    };
    
    animator?.addCompletion { [unowned self] in
      self.onMenuDidShow?([:]);
      
      // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
      // B - show context menu auxiliary preview via old way
      // i.e. wait for context menu preview to become visible before showing
      // the aux. preview.
      if !shouldUseAlternateWayToShowAuxPreview {
        self.attachContextMenuAuxiliaryPreviewIfAny(animator);
      };
    };
  };
  
  // context menu display ends
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willEndFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    
    guard self.isContextMenuVisible else { return };
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    // hide preview auxiliary view
    self.detachContextMenuAuxiliaryPreviewIfAny(animator);

    self.onMenuWillHide?([:]);
    
    if !self.didPressMenuItem {
      // nothing was selected...
      self.onMenuWillCancel?([:]);
    };
    
    animator?.addCompletion { [unowned self] in
      self.onMenuDidHide?([:]);
      
      if !self.didPressMenuItem {
        // nothing was selected...
        self.onMenuDidCancel?([:]);
      };
      
      // reset flag
      self.didPressMenuItem = false;
    };
    
    // reset flag
    self.isContextMenuVisible = false;
  };
  
  // context menu preview tapped
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionCommitAnimating
  ) {
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    // hide preview auxiliary view
    self.detachContextMenuAuxiliaryPreviewIfAny(animator);
    
    let preferredCommitStyle = self._previewConfig.preferredCommitStyle;
    
    self.isContextMenuVisible = false;
    animator.preferredCommitStyle = preferredCommitStyle;
    
    switch preferredCommitStyle {
      case .pop:
        self.onMenuWillHide?([:]);
        
        animator.addCompletion { [unowned self] in
          self.onPressMenuPreview?([:]);
          self.onMenuDidHide?([:]);
        };
      
      case .dismiss: fallthrough;
      @unknown default:
        self.onMenuWillHide?([:]);
        self.onPressMenuPreview?([:]);
        
        animator.addCompletion { [unowned self] in
          self.onMenuDidHide?([:]);
        };
    };
  };

  #if swift(>=5.7)
  func contextMenuInteraction(
      _ interaction: UIContextMenuInteraction,
      configuration: UIContextMenuConfiguration,
      highlightPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
  #else
  /// deprecated in iOS 16
  func contextMenuInteraction(
    _ : UIContextMenuInteraction,
    previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
  
    return self.makeTargetedPreview();
  };
  #endif
  
  
  #if swift(>=5.7)
  func contextMenuInteraction(
      _ interaction: UIContextMenuInteraction,
      configuration: UIContextMenuConfiguration,
      dismissalPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
  #else
  /// deprecated in iOS 16
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForDismissingMenuWithConfiguration
    configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
  #endif
};

// MARK: - RNINavigationEventsNotifiable
// ----------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNINavigationEventsNotifiable {
  
  func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController) {
    if self.cleanupMode == .viewController {
      // trigger cleanup
      self.cleanup();
    };
  };
};

// MARK: - RNICleanable
// --------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNICleanable {
  
  func cleanup(){
    guard self.shouldEnableCleanup,
          !self.didTriggerCleanup
    else { return };
    
    self.didTriggerCleanup = true;
    
    self.contextMenuInteraction?.dismissMenu();
    self.contextMenuInteraction = nil;
    
    // remove deferred handlers
    self.deferredElementCompletionMap.removeAll();
    
    self.detachFromParentVCIfAny();
    
    // remove preview from registry
    self.previewWrapper?.cleanup();
    self.previewAuxiliaryViewWrapper?.cleanup();
    
    self.previewWrapper = nil;
    self.previewController = nil;
    self.previewAuxiliaryViewWrapper = nil;
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
};

// MARK: - RNIJSComponentWillUnmountNotifiable
// -------------------------------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNIJSComponentWillUnmountNotifiable {
  
  func notifyOnJSComponentWillUnmount(){
    guard self.cleanupMode == .reactComponentWillUnmount
    else { return };
    
    self.cleanup();
  };
};

// MARK: - RNIMenuElementEventsNotifiable
// --------------------------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNIMenuElementEventsNotifiable {
  
  func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self._menuConfig else { return };
    self.updateContextMenuIfVisible(with: menuConfig);
  };
};

// MARK: - UIView - "Auxiliary Preview"-Related (Experimental)
// -----------------------------------------------------------

// Bugfix: Fix for aux-preview not receiving touch event when appearing
// on screen edge
fileprivate extension UIView {
  static weak var auxPreview: UIView? = nil;
  
  static var isSwizzlingApplied = false
  
  @objc dynamic func _point(
    inside point: CGPoint,
    with event: UIEvent?
  ) -> Bool {
    guard let auxPreview = Self.auxPreview,
          self.subviews.contains(where: { $0 === auxPreview })
    else {
      // call original impl.
      return self._point(inside: point, with: event);
    };
    
    return true;
  };
  
  static func swizzlePoint(){
    let selectorOriginal = #selector( point(inside: with:));
    let selectorSwizzled = #selector(_point(inside: with:));
    
    guard let methodOriginal = class_getInstanceMethod(UIView.self, selectorOriginal),
          let methodSwizzled = class_getInstanceMethod(UIView.self, selectorSwizzled)
    else { return };
    
    Self.isSwizzlingApplied.toggle();
    method_exchangeImplementations(methodOriginal, methodSwizzled);
  };
};
