//
//  RNIContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;
import ExpoModulesCore
import ReactNativeIosUtilities
import DGSwiftUtilities


public class RNIContextMenuView:
  ExpoView, RNINavigationEventsNotifiable, RNICleanable,
  RNIJSComponentWillUnmountNotifiable, RNIMenuElementEventsNotifiable {

  // MARK: - Embedded Types
  // ----------------------
  
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
  
  var detachedViews: [WeakRef<RNIDetachedView>] = [];
  
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  var previewController: RNIContextMenuPreviewController?;
  weak var viewController: RNINavigationEventsReportingViewController?;
  
  var menuCustomPreviewView: RNIDetachedView?;
      
  private var deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
    
  var longPressGestureRecognizer: UILongPressGestureRecognizer!;
    
  // MARK: - Properties - Flags
  // --------------------------
  
  /// Keep track on whether or not the context menu is currently visible.
  var isContextMenuVisible = false;
  
  /// This is set to `true` when the menu is open and an item is pressed, and
  /// is immediately set back to `false` once the menu close animation
  /// finishes.
  var didPressMenuItem = false;
  
  /// Whether or not `cleanup` method was called
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
  // MARK: - Properties - "Auxiliary Preview"-Related (Experimental)
  // ---------------------------------------------------------------
  
  /// Keep track on whether or not the aux. preview is currently visible.
  var isAuxPreviewVisible = false;
  
  /// Cached value - in which side of the preview was aux. preview attached to?
  /// Cleared when the aux. preview is hidden.
  private var morphingPlatterViewPlacement: AnchorPosition?;

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
  
  private(set) public var previewConfig = PreviewConfig();
  public var previewConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue else { return };
      
      let previewConfig = PreviewConfig(dictionary: newValue);
      self.previewConfig = previewConfig;
      
      // update the vc's previewConfig
      if let previewController = self.previewController {
        previewController.view.setNeedsLayout();
      };
    }
  };
  
  public var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  public var isContextMenuEnabled = true;
  
  private(set) public var internalCleanupMode: RNICleanupMode = .automatic;
  public var internalCleanupModeRaw: String? {
    willSet {
      guard let rawString = newValue,
            let cleanupMode = RNICleanupMode(rawValue: rawString)
      else { return };
      
      self.internalCleanupMode = cleanupMode;
    }
  };
  
  public var shouldPreventLongPressGestureFromPropagating = true {
    willSet {
      let oldValue = self.shouldPreventLongPressGestureFromPropagating;
      
      guard newValue != oldValue,
            let longPressGestureRecognizer = self.longPressGestureRecognizer
      else { return };
      
      longPressGestureRecognizer.isEnabled = newValue;
    }
  };
  
  // MARK: Properties - Props - "Auxiliary Context Menu Preview"-Related (Experimental)
  // ----------------------------------------------------------------------------------

  public var isAuxiliaryPreviewEnabled = true;
  
  private(set) public var auxiliaryPreviewConfig: RNIContextMenuAuxiliaryPreviewConfig?;
  public var auxiliaryPreviewConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0
      else {
        self.auxiliaryPreviewConfig = nil;
        return;
      };
      
      let config = RNIContextMenuAuxiliaryPreviewConfig(dictionary: newValue);
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
  
  // MARK: Properties - Props - Events - "Auxiliary Preview"-Related (Experimental)
  // ------------------------------------------------------------------------------

  public var onMenuAuxiliaryPreviewWillShow =
    EventDispatcher("onMenuAuxiliaryPreviewWillShow");
    
  public var onMenuAuxiliaryPreviewDidShow =
    EventDispatcher("onMenuAuxiliaryPreviewDidShow");
  
  // MARK: - Computed Properties
  // ---------------------------
  
  var isUsingCustomPreview: Bool {
       self.previewConfig.previewType == .CUSTOM
    && self.menuCustomPreviewView != nil
  };
  
  var cleanupMode: RNICleanupMode {
    get {
      switch self.internalCleanupMode {
        case .automatic:
          return .reactComponentWillUnmount;
          
        default:
          return self.internalCleanupMode;
      };
    }
  };
  
  // MARK: - Computed Properties - "Auxiliary Context Menu Preview"-Related
  // ----------------------------------------------------------------------
  
  /// Gets the `_UIContextMenuContainerView` that's holding the context menu
  /// controls.
  ///
  /// **Note**: This `UIView` instance  only exists whenever there's a context
  /// menu interaction.
  /// `
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
  
  var menuAuxiliaryPreviewView: RNIDetachedView?;
  
  var isPreviewAuxiliaryViewAttached: Bool {
    self.menuAuxiliaryPreviewView != nil;
  };
  
  // MARK: Init + Lifecycle
  // ----------------------

  public required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext);
    
    self.setupAddContextMenuInteraction();
    self.setupAddGestureRecognizers();
  };
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  // MARK: - RN Lifecycle
  // --------------------

  public override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  public override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    super.insertSubview(subview, at: atIndex);
    
    guard let detachedView = subview as? RNIDetachedView,
          let nativeID = detachedView.nativeID,
          let nativeIDKey = NativeIDKey(rawValue: nativeID)
    else { return };
    
    switch nativeIDKey {
        case .contextMenuPreview:
          self.menuCustomPreviewView = detachedView;
        
        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
        case .contextMenuAuxiliaryPreview:
          self.menuAuxiliaryPreviewView = detachedView;
    };
    
    self.detachedViews.append(
      .init(with: detachedView)
    );
    
    detachedView.detach();
  };
  
  #if DEBUG
  @objc func onRCTBridgeWillReloadNotification(_ notification: Notification){
    self.cleanup();
  };
  #endif
  
  // MARK: - View Lifecycle
  // ----------------------
  
  public override func didMoveToWindow() {
    let didMoveToNilWindow = self.window == nil;
    
    /// A. Not attached to a parent VC yet
    /// B. Moving to a non-nil window
    /// C. attach as "child vc" to "parent vc" enabled
    ///
    /// the VC attached to this view is possibly being attached as a child
    /// view controller to a view controller managed by
    /// `UINavigationController`...
    ///
    let shouldAttachToParentVC =
         !self.didAttachToParentVC
      && !didMoveToNilWindow
      && self.cleanupMode.shouldAttachToParentVC;
      
    
    /// A. Not attached to a parent VC yet
    /// B. Moving to a nil window
    /// C. Attach as "child vc" to "parent vc" disabled
    ///
    /// Moving to nil window and not attached to parent vc, possible end of
    /// lifecycle for this view...
    ///
    let shouldTriggerCleanup =
         !self.didAttachToParentVC
      && didMoveToNilWindow
      && !self.cleanupMode.shouldAttachToParentVC;
      
      
    if shouldAttachToParentVC {
      // begin setup - attach this view as child vc
      self.attachToParentVC();
    
    } else if shouldTriggerCleanup {
      // trigger manual cleanup
      self.cleanup();
    };
  };
  
  // MARK: - Functions
  // -----------------
  
  /// Add a context menu interaction to view
  func setupAddContextMenuInteraction(){
    self.contextMenuInteraction = {
      let interaction = UIContextMenuInteraction(delegate: self);
      self.addInteraction(interaction);
      
      return interaction;
    }();
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
  
  /// configure target preview based on `previewConfig`
  func makeTargetedPreview() -> UITargetedPreview {
  
    // create preview parameters based on `previewConfig`
    let parameters: UIPreviewParameters = {
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
    }();
    
    if let bridge = self.appContext?.reactBridge,
       let targetNode = self.previewConfig.targetViewNode,
       let targetView = bridge.uiManager.view(forReactTag: targetNode) {
      
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
    self.onPressMenuItem.callAsFunction(dict);
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self.deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.onRequestDeferredElement.callAsFunction([
      "deferredID": deferredID,
    ]);
  };
  
  @objc func handleLongPressGesture(_ sender: UILongPressGestureRecognizer){
    // no-op
  };
  
  func attachToParentVC(){
    guard self.cleanupMode.shouldAttachToParentVC,
          !self.didAttachToParentVC,
          
          // find the nearest parent view controller
          let parentVC = RNIHelpers.getParent(
            responder: self,
            type: UIViewController.self
          )
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
          let menuAuxiliaryPreviewView = self.menuAuxiliaryPreviewView,
          let contextMenuContentContainer = self.contextMenuContentContainer,
          let contextMenuContainerView = self.contextMenuContainerView,
          let morphingPlatterView = self.morphingPlatterView
    else { return };
    
    // MARK: Prep - Set Constants
    // --------------------------
    
    let auxConfig = self.auxiliaryPreviewConfig
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
      return menuAuxiliaryPreviewView.frame.height;
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
          return auxConfig.width ?? menuAuxiliaryPreviewView.frame.width;
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
      guard let menuItems = self.menuConfig?.menuItems else { return false };
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
    menuAuxiliaryPreviewView.addGestureRecognizer(
      UITapGestureRecognizer(target: nil, action: nil)
    );
    
    /// manually set size of aux. preview
    menuAuxiliaryPreviewView.updateBounds(newSize: previewAuxiliaryViewSize);

    /// enable auto layout
    menuAuxiliaryPreviewView.translatesAutoresizingMaskIntoConstraints = false;
    
    /// attach `auxiliaryView` to context menu preview
    targetView.addSubview(menuAuxiliaryPreviewView);
    
    // set layout constraints based on config
    NSLayoutConstraint.activate({
      
      // set initial constraints
      var constraints: Array<NSLayoutConstraint> = [
        // set aux preview height
        menuAuxiliaryPreviewView.heightAnchor
          .constraint(equalToConstant: auxiliaryViewHeight),
      ];
      
      // set vertical alignment constraint - i.e. either...
      constraints.append(shouldAttachToTop
       // A - pin to top or...
       ? menuAuxiliaryPreviewView.bottomAnchor
         .constraint(equalTo: morphingPlatterView.topAnchor, constant: -marginInner)
       
       // B - pin to bottom.
       : menuAuxiliaryPreviewView.topAnchor
          .constraint(equalTo: morphingPlatterView.bottomAnchor, constant: marginInner)
      );
      
      // set horizontal alignment constraints based on config...
      constraints += {
        switch auxConfig.alignmentHorizontal {
          // A - pin to left
          case .previewLeading: return [
            menuAuxiliaryPreviewView.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
            
            menuAuxiliaryPreviewView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // B - pin to right
          case .previewTrailing: return [
            menuAuxiliaryPreviewView.rightAnchor.constraint(
              equalTo: morphingPlatterView.rightAnchor),
            
            menuAuxiliaryPreviewView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // C - pin to center
          case .previewCenter: return [
            menuAuxiliaryPreviewView.centerXAnchor
              .constraint(equalTo: morphingPlatterView.centerXAnchor),
            
            menuAuxiliaryPreviewView.widthAnchor
              .constraint(equalToConstant: auxiliaryViewWidth),
          ];
            
          // D - match preview size
          case .stretchPreview: return [
            menuAuxiliaryPreviewView.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
            
            menuAuxiliaryPreviewView.trailingAnchor
              .constraint(equalTo: morphingPlatterView.trailingAnchor),
          ];
          
          // E - stretch to edges of screen
          case .stretchScreen: return [
            menuAuxiliaryPreviewView.leadingAnchor
              .constraint(equalTo: contextMenuContainerView.leadingAnchor),
            
            menuAuxiliaryPreviewView.trailingAnchor
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
      var transform = menuAuxiliaryPreviewView.transform;
      
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
          menuAuxiliaryPreviewView.alpha = 0;
        }, {
          // B - fade - exit transition
          menuAuxiliaryPreviewView.alpha = 1;
        });
          
        case let .slide(slideOffset): return ({
          // A - slide - entrance transition
          // fade - start
          menuAuxiliaryPreviewView.alpha = 0;
          
          // slide - start
          setTransformForTransitionSlideStart(slideOffset);
          
          // apply transform
          menuAuxiliaryPreviewView.transform = transform;
          
        }, {
          // B - slide - exit transition
          // fade - end
          menuAuxiliaryPreviewView.alpha = 1;
 
          // slide - end - reset transform
          menuAuxiliaryPreviewView.transform = .identity;
        });
          
        case let .zoom(zoomOffset): return ({
            // A - zoom - entrance transition
            // fade - start
            menuAuxiliaryPreviewView.alpha = 0;
            
            // zoom - start
            setTransformForTransitionZoomStart(zoomOffset);
            
            // start - apply transform
            menuAuxiliaryPreviewView.transform = transform;
            
          }, {
            // B - zoom - exit transition
            // fade - end
            menuAuxiliaryPreviewView.alpha = 1;
            
            // zoom - end - reset transform
            menuAuxiliaryPreviewView.transform = .identity;
          });
          
        case let .zoomAndSlide(slideOffset, zoomOffset): return ({
          // A - zoomAndSlide - entrance transition
          // fade - start
          menuAuxiliaryPreviewView.alpha = 0;
        
          // slide - start
          setTransformForTransitionSlideStart(slideOffset);
          
          // zoom - start
          setTransformForTransitionZoomStart(zoomOffset);
          
          // start - apply transform
          menuAuxiliaryPreviewView.transform = transform;
                    
        }, {
          // B - zoomAndSlide - exit transition
          // fade - end
          menuAuxiliaryPreviewView.alpha = 1;
          
          // slide/zoom - end - reset transform
          menuAuxiliaryPreviewView.transform = .identity;
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
    self.onMenuAuxiliaryPreviewWillShow.callAsFunction([:]);
    self.isAuxPreviewVisible = true;
    
    // transition - set start/initial values
    setTransitionStateStart();
    
    // MARK: Bugfix - Aux-Preview Touch Event on Screen Edge
    let shouldSwizzle = yOffset != 0;
    if shouldSwizzle {
      Self.auxPreview = menuAuxiliaryPreviewView;
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
        self.onMenuAuxiliaryPreviewDidShow.callAsFunction(eventObject);
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
          let menuAuxiliaryPreviewView = self.menuAuxiliaryPreviewView
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
      var transform = menuAuxiliaryPreviewView.transform;
      
      // transition - fade out
      menuAuxiliaryPreviewView.alpha = 0;
      
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
      menuAuxiliaryPreviewView.transform = transform;
    };
    
    animator.addCompletion { [unowned self] in
      menuAuxiliaryPreviewView.removeFromSuperview();
      
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
  
  // MARK: - Functions - View Module Commands
  // ----------------------------------------
  
  func dismissMenu(){
    self.contextMenuInteraction?.dismissMenu();
  };
  
  func provideDeferredElements(
    id deferredID: String,
    menuElements rawMenuElements: [RNIMenuElement]
  ) throws {
    
    guard let completionHandler = self.deferredElementCompletionMap[deferredID]
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
    self.deferredElementCompletionMap.removeValue(forKey: deferredID);
  };
  
  // MARK: - RNINavigationEventsNotifiable
  // -------------------------------------
  
  public func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController) {
    if self.cleanupMode == .viewController {
      // trigger cleanup
      self.cleanup();
    };
  };
  
  // MARK: - RNICleanable
  // --------------------
  
  public func cleanup(){
    guard self.cleanupMode.shouldEnableCleanup,
          !self.didTriggerCleanup
    else { return };
    
    self.didTriggerCleanup = true;
    
    self.contextMenuInteraction?.dismissMenu();
    self.contextMenuInteraction = nil;
    
    // remove deferred handlers
    self.deferredElementCompletionMap.removeAll();
    
    self.detachFromParentVCIfAny();
    
    // remove preview from registry
    self.menuCustomPreviewView?.cleanup();
    self.menuAuxiliaryPreviewView?.cleanup();
    
    self.detachedViews.forEach {
      $0.ref?.cleanup();
    };
    
    self.menuCustomPreviewView = nil;
    self.previewController = nil;
    self.menuAuxiliaryPreviewView = nil;
    self.detachedViews = [];
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
  
  // MARK: - RNIJSComponentWillUnmountNotifiable
  // -------------------------------------------
  
  public func notifyOnJSComponentWillUnmount(){
    guard self.cleanupMode == .reactComponentWillUnmount
    else { return };
    
    self.cleanup();
  };
  
  // MARK: - RNIMenuElementEventsNotifiable
  // --------------------------------------
  
  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self.menuConfig else { return };
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
