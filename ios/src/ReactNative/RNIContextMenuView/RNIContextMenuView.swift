//
//  RNIContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;


@available(iOS 13, *)
class RNIContextMenuView: UIView {
  
  enum NativeIDKey: String {
    case contextMenuPreview;
    case contextMenuAuxiliaryPreview;
  };
  
  private enum AnchorPosition {
    case top;
    case bottom;
  };
  
  // MARK: - Properties
  // ------------------
  
  weak var bridge: RCTBridge!;
  
  /// Keep track on whether or not the context menu is currently visible.
  var isContextMenuVisible = false;
  
  /// Is set to `true` when the menu is open and an item is pressed and is immediately set back
  /// to `false` once the menu close animation finishes.
  var didPressMenuItem = false;
  
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  /// contains the view to show in the preview
  var previewWrapper: RNIWrapperView?;
  var previewController: RNIContextMenuPreviewController?;
  
  weak var contextMenuViewController: RNIContextMenuViewController?;
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  /// Holds the view to be shown in the auxiliary preview
  weak var previewAuxiliaryViewWrapper: RNIWrapperView?;
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  private var previewAuxiliaryViewPlacement: AnchorPosition?;
  
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  private var shouldEnableAuxPreview = true;
  
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
      
      menuConfig.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle =
        self.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle;

      #if DEBUG
      print("menuConfig didSet"
        + " - RNIMenuItem init"
        + " - menuConfig count: \(menuConfigDict.count)"
      );
      #endif
      
      self._menuConfig = menuConfig;
      
      if #available(iOS 14.0, *),
         self.isContextMenuVisible,
         let interaction: UIContextMenuInteraction = self.contextMenuInteraction {
        
        #if DEBUG
        print("menuConfig didSet"
          + " - Updating  visible menu"
          + " - menuItems: \(menuConfigDict["menuItems"] ?? "N/A")"
        );
        #endif
        
        // context menu is open, update the menu items
        interaction.updateVisibleMenu {(menu: UIMenu) in
          return menuConfig.createMenu {(dict, action) in
            // menu item has been pressed...
            self.didPressMenuItem = true;
            self.onPressMenuItem?(dict);
          };
        };
      };
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
  
  @objc var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  @objc var isContextMenuEnabled = true;
  
  // MARK: - Computed Properties
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
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
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  /// Will return the ff. subviews:
  /// * `_UIMorphingPlatterView` - Contains the context menu preview
  /// * `_UIContextMenu` - Holds the context menu items
  ///
  var contextMenuContentContainer: UIView? {
    self.contextMenuContainerView?.subviews.first {
      !($0 is UIVisualEffectView) && $0.subviews.count > 0
    };
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  /// Holds the context menu preview
  var morphingPlatterView: UIView? {
    self.contextMenuContentContainer?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) == 1;
    };
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  /// Holds the context menu items
  var contextMenuItemsView: UIView? {
    self.contextMenuContentContainer?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) > 1;
    };
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  var isPreviewAuxiliaryViewAttached: Bool {
    self.previewAuxiliaryViewWrapper != nil;
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
      
      wrapperView.willChangeSuperview = true;
      wrapperView.autoCleanupOnJSUnmount = true;
            
      switch nativeIDKey {
        case .contextMenuPreview:
          // if prev. exist, cleanup if needed.
          self.previewWrapper?.cleanup();
          self.previewWrapper = wrapperView;
        
        // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
        case .contextMenuAuxiliaryPreview:
          // TODO: if prev. exist, cleanup if needed.
          // self.previewAuxiliaryViewWrapper?.cleanup();
          self.previewAuxiliaryViewWrapper = wrapperView;
      };
      
      wrapperView.removeFromSuperview();
      wrapperView.willChangeSuperview = false;
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
    if self.window == nil,
       !self.didAttachToParentVC {
      
      // not using UINavigationController... manual cleanup
      self.cleanup();
      
    } else if self.window != nil,
           !self.didAttachToParentVC {
      
      // setup - might be using UINavigationController, attach as child vc
      self.attachToParentVC();
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
  
  func cleanup(){
    
    guard !self.didTriggerCleanup else { return };
    self.didTriggerCleanup = true;
    
    self.contextMenuInteraction?.dismissMenu();
    self.contextMenuInteraction = nil;
    
    // remove preview from registry
    self.previewWrapper?.cleanup();
    
    // remove this view from registry
    RNIUtilities.recursivelyRemoveFromViewRegistry(
      bridge   : self.bridge,
      reactView: self
    );
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
  
  /// create `UIMenu` based on `menuConfig` prop
  func createMenu(_ suggestedAction: [UIMenuElement]) -> UIMenu? {
    guard  let menuConfig = self._menuConfig else {
      #if DEBUG
      print("RNIContextMenuView, createMenu"
        + " - guard check failed, menuConfig: nil"
      );
      #endif
      return nil;
    };
    
    return menuConfig.createMenu { (dict, action) in
      // menu item has been pressed...
      self.didPressMenuItem = true;
      self.onPressMenuItem?(dict);
    };
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
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  func attachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating!
  ){

    guard self.shouldEnableAuxPreview,
          let previewAuxiliaryViewWrapper = self.previewAuxiliaryViewWrapper,
          let previewAuxiliaryView = previewAuxiliaryViewWrapper.reactContent,
          
          let contextMenuContentContainer = self.contextMenuContentContainer,
          let contextMenuContainerView = self.contextMenuContainerView,
          let morphingPlatterView = self.morphingPlatterView
    else { return };
    
    // MARK: Prep - Set Constants
    // --------------------------
    
    let auxConfig = self._auxiliaryPreviewConfig
      ?? RNIContextMenuAuxiliaryPreviewConfig(dictionary: [:]);
    
    let auxiliaryViewHeight: CGFloat = {
      // A - Use height from config
      if let height = auxConfig.height {
        return height;
      };
      
      // B - Infer aux preview height from view
      return previewAuxiliaryView.frame.height;
    }();
    
    let auxiliaryViewWidth: CGFloat = {
      // amount to subtract from width - fix for layout bug
      // if you use the full width, it triggers a bug w/ autolayout where the
      // aux. preview snaps to the top of the screen...
      let adj = 0.5;
      
      switch auxConfig.alignmentHorizontal {
        // A - Set aux preview width to window width
        case .stretchScreen:
          return contextMenuContainerView.frame.width - adj;
        
        // B - Set aux preview width to preview width
        case .stretchPreview:
          return morphingPlatterView.frame.width - adj;
        
        // C - Infer aux preview width from view...
        default:
          return previewAuxiliaryView.frame.width;
      };
    }();
    
    let marginInner = auxConfig.marginPreview;
    let marginOuter = auxConfig.marginAuxiliaryPreview;
    
    let previewAuxiliaryViewSize = CGSize(
      width : auxiliaryViewWidth,
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
    
    /// if the context menu has "menu items", where is it located in relation to the "context menu preview"?
    let menuItemsPlacement: AnchorPosition? = {
      guard menuConfigHasMenuItems,
            let contextMenuItemsView = self.contextMenuItemsView
      else { return nil };
      
      let previewFrame = morphingPlatterView.frame;
      let menuItemsFrame = contextMenuItemsView.frame;
      
      return (menuItemsFrame.midY < previewFrame.midY) ? .bottom : .top;
    }();
    
    /// in which half does the "context menu preview" fall into?
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
    self.previewAuxiliaryViewPlacement = morphingPlatterViewPlacement;

    // MARK: Prep - Compute Offsets
    // ----------------------------
    
    /// distance of aux preview from anchor
    let offset: CGFloat = {
      let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets;
      
      let previewFrame = morphingPlatterView.frame;
      let screenHeight = UIScreen.main.bounds.height;
      
      let marginBase = marginInner + marginOuter;
      
      switch morphingPlatterViewPlacement {
        case .top:
          let topInsets = safeAreaInsets?.top ?? 0;
          let margin = marginBase + topInsets;
          
          let minEdgeY = auxiliaryViewHeight + topInsets;
          let distanceToEdge = previewFrame.minY;
        
          return (previewFrame.minY <= minEdgeY)
            ? max((auxiliaryViewHeight - distanceToEdge + margin), 0)
            : 0;
          
        case .bottom:
          let bottomInsets = safeAreaInsets?.bottom ?? 0;
          let margin = marginBase + bottomInsets;
          
          let tolerance = auxiliaryViewHeight + (safeAreaInsets?.bottom ?? 0);
          let maxEdgeY = screenHeight - tolerance;
          
          let distanceToEdge = screenHeight - previewFrame.maxY;
          return (previewFrame.maxY > maxEdgeY)
            ? -(auxiliaryViewHeight - distanceToEdge + margin)
            : 0;
      };
    }();
    
    // MARK: Set Layout
    // ----------------
    
    /// detach aux. preview
    previewAuxiliaryViewWrapper.removeFromSuperview();
    previewAuxiliaryView.removeFromSuperview();
    
    /// manually set size of aux. preview
    previewAuxiliaryViewWrapper
      .notifyForBoundsChange(size: previewAuxiliaryViewSize);
    
    let wrappedAuxiliaryPreview: UIView = {
      let view = UIView();
      
      let dummyGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil);
      view.addGestureRecognizer(dummyGestureRecognizer);
      
      view.addSubview(previewAuxiliaryView);
      previewAuxiliaryView.translatesAutoresizingMaskIntoConstraints = false;
      
      NSLayoutConstraint.activate([
        previewAuxiliaryView.leadingAnchor
          .constraint(equalTo: view.leadingAnchor),
        
        previewAuxiliaryView.trailingAnchor
          .constraint(equalTo: view.trailingAnchor),
        
        previewAuxiliaryView.topAnchor
          .constraint(equalTo: view.topAnchor),
        
        previewAuxiliaryView.bottomAnchor
          .constraint(equalTo: view.bottomAnchor)
      ]);
      
      return view;
    }();
    
    /// attach `auxiliaryView` to context menu preview
    contextMenuContentContainer.addSubview(wrappedAuxiliaryPreview);
    
    /// enable auto layout
    wrappedAuxiliaryPreview.translatesAutoresizingMaskIntoConstraints = false;
    
    // set layout constraints based on config
    NSLayoutConstraint.activate({
      
      // set initial constraints
      var constraints: Array<NSLayoutConstraint> = [
        // set aux preview height
        wrappedAuxiliaryPreview.heightAnchor
          .constraint(equalToConstant: auxiliaryViewHeight),
      ];
      
      // set vertical alignment constraint - i.e. either...
      constraints.append(shouldAttachToTop
       // A - pin to top or...
       ? wrappedAuxiliaryPreview.bottomAnchor
         .constraint(equalTo: morphingPlatterView.topAnchor, constant: -marginInner)
       
       // B - pin to bottom.
       : wrappedAuxiliaryPreview.topAnchor
          .constraint(equalTo: morphingPlatterView.bottomAnchor, constant: marginInner)
      );
      
      // set horizontal alignment constraints based on config...
      constraints += {
        switch auxConfig.alignmentHorizontal {
          // A - pin to left
          case .previewLeading: return [
            wrappedAuxiliaryPreview.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
          ];
            
          // B - pin to right
          case .previewTrailing: return [
            // TODO: Replace with width anchor
            wrappedAuxiliaryPreview.rightAnchor.constraint(
              equalTo: morphingPlatterView.rightAnchor, constant: -auxiliaryViewWidth)
          ];
            
          // C - pin to center
          case .previewCenter: return [
            wrappedAuxiliaryPreview.centerXAnchor
              .constraint(equalTo: morphingPlatterView.centerXAnchor),
          ];
            
          // D - match preview size
          case .stretchPreview: return [
            wrappedAuxiliaryPreview.leadingAnchor
              .constraint(equalTo: morphingPlatterView.leadingAnchor),
            
            wrappedAuxiliaryPreview.trailingAnchor
              .constraint(equalTo: morphingPlatterView.trailingAnchor),
          ];
          
          // E - stretch to edges of screen
          case .stretchScreen: return [
            wrappedAuxiliaryPreview.leadingAnchor
              .constraint(equalTo: contextMenuContainerView.leadingAnchor),
            
            wrappedAuxiliaryPreview.trailingAnchor
              .constraint(equalTo: contextMenuContainerView.trailingAnchor),
          ];
        };
      }();
      
      return constraints;
    }());
    
    // MARK: Show Aux. View
    // --------------------
    
    // transition - start value
    wrappedAuxiliaryPreview.alpha = 0;
    
    UIView.animate(withDuration: 0.3, animations: {
      // fade in transition
      wrappedAuxiliaryPreview.alpha = 1;
      
      // offset from anchor
      contextMenuContentContainer.frame =
        contextMenuContentContainer.frame.offsetBy(dx: 0, dy: offset)
      
    }, completion: {_ in
      // TODO: Add RN event
    });
  };
  
  // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
  func detachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating?
  ){
    
    guard self.shouldEnableAuxPreview,
          let animator = animator,
          let previewAuxiliaryView = self.previewAuxiliaryViewWrapper?.reactContent
    else { return };
    
    /// Bug:
    /// * "Could not locate shadow view with tag #, this is probably caused by a temporary inconsistency
    ///   between native views and shadow views."
    /// * Triggered when the menu is about to be hidden, iOS removes the context menu along with the
    ///   `previewAuxiliaryViewContainer`
    
    // Add exit transition
    animator.addAnimations {
      var transform = previewAuxiliaryView.transform;
      
      // transition - fade out
      previewAuxiliaryView.alpha = 0;
      
      // transition - zoom out
      transform = transform.scaledBy(x: 0.7, y: 0.7);
      
      // transition - slide out
      switch self.previewAuxiliaryViewPlacement {
        case .top:
          transform = transform.translatedBy(x: 0, y: 50);
          
        case .bottom:
          transform = transform.translatedBy(x: 0, y: -50);
          
        default: break;
      };
      
      // transition - apply transform
      previewAuxiliaryView.transform = transform;
    };
    
    animator.addCompletion {
      previewAuxiliaryView.removeFromSuperview();
      
      // clear value
      self.previewAuxiliaryViewPlacement = nil;
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
      actionProvider : self.createMenu
    );
  };
  
  // context menu display begins
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willDisplayMenuFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
      
    #if DEBUG
    print("RNIContextMenuView, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will show"
    );
    #endif
    
    self.isContextMenuVisible = true;
    self.onMenuWillShow?([:]);
    
    animator?.addCompletion {
      self.onMenuDidShow?([:]);
      
      #if DEBUG
      // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
      // show context menu auxiliary preview
      self.attachContextMenuAuxiliaryPreviewIfAny(animator);
      #endif
    };
  };
  
  // context menu display ends
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willEndFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
      
    #if DEBUG
    print("RNIContextMenuView, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will hide"
    );
    #endif
    
    guard self.isContextMenuVisible else { return };
    
    #if DEBUG
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    // hide preview auxiliary view
    self.detachContextMenuAuxiliaryPreviewIfAny(animator);
    #endif
    
    self.onMenuWillHide?([:]);
    
    if !self.didPressMenuItem {
      // nothing was selected...
      self.onMenuWillCancel?([:]);
    };
    
    animator?.addCompletion {
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
      
    #if DEBUG
    print("RNIContextMenuView, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: preview tapped"
    );
    #endif
    
    let preferredCommitStyle = self._previewConfig.preferredCommitStyle;
    
    self.isContextMenuVisible = false;
    animator.preferredCommitStyle = preferredCommitStyle;
    
    switch preferredCommitStyle {
      case .pop:
        self.onMenuWillHide?([:]);
        
        animator.addCompletion {
          self.onPressMenuPreview?([:]);
          self.onMenuDidHide?([:]);
        };
      
      case .dismiss: fallthrough;
      @unknown default:
        self.onMenuWillHide?([:]);
        self.onPressMenuPreview?([:]);
        
        animator.addCompletion {
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

// MARK: - RNIContextMenu
// ----------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNIContextMenu {
  
  func notifyViewControllerDidPop(sender: RNIContextMenuViewController) {
    // trigger cleanup
    self.cleanup();
  };
  
  // TODO: Move to class instead of protocol
  func attachToParentVC(){
    guard !self.didAttachToParentVC,
          // find the nearest parent view controller
          let parentVC = RNIUtilities
            .getParent(responder: self, type: UIViewController.self)
    else { return };
    
    self.didAttachToParentVC = true;
    
    let childVC = RNIContextMenuViewController(contextMenuView: self);
    childVC.parentVC = parentVC;
    
    self.contextMenuViewController = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
  };
  
  func detachFromParentVC(){
    guard !self.didAttachToParentVC,
          let childVC = self.contextMenuViewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
  };
};
