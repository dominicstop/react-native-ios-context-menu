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
  
  weak var previewAuxiliaryViewWrapper: RNIWrapperView?;
  weak var contextMenuViewController: RNIContextMenuViewController?;
  
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
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
      else { return };
      
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
  
  @objc var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  @objc var isContextMenuEnabled = true;
  
  // MARK: - Computed Properties
  
  /// Gets the `_UIContextMenuContainerView` that's holding the context menu controls.
  /// Subviews:
  /// * `UIVisualEffectView` - BG blur view
  /// * `UIView` - Holds `_UIMorphingPlatterView`  and `_UIContextMenu`
  ///
  /// **Note**: This is only exist whenever there's a context menu interaction
  ///
  var contextMenuContainerView: UIView? {
    self.window?.subviews.first {
      ($0.gestureRecognizers?.count ?? 0) > 0
    };
  };
  
  /// Contains the ff. subviews:
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
          
        case .contextMenuAuxiliaryPreview:
          // if prev. exist, cleanup if needed.
          //self.previewAuxiliaryViewWrapper?.cleanup();
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
  
  func attachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating?
  ){
    
    enum AnchorPosition {
      case top, bottom;
    };

    guard animator != nil,
          let previewAuxiliaryViewWrapper = self.previewAuxiliaryViewWrapper,
          let previewAuxiliaryView = previewAuxiliaryViewWrapper.reactContent,
          let contextMenuContentContainer = self.contextMenuContentContainer,
          let morphingPlatterView = self.morphingPlatterView
    else { return };
    
    /// Based on the current "menu config", does it have menu items?
    let menuConfigHasMenuItems: Bool = {
      guard let menuItems = self._menuConfig?.menuItems
      else { return false };
      
      return menuItems.count > 0;
    }();
    
    // if the context menu has "menu items", where is it located in relation to
    // the "context menu preview"?
    let menuItemsPlacement: AnchorPosition? = {
      guard menuConfigHasMenuItems,
            let contextMenuItemsView = self.contextMenuItemsView
      else { return nil };
      
      let previewFrame = morphingPlatterView.frame;
      let menuItemsFrame = contextMenuItemsView.frame;
      
      return (menuItemsFrame.midY < previewFrame.midY) ? .bottom : .top;
    }();
    
    // in which half does the "context menu preview" fall into?
    let morphingPlatterViewPlacement: AnchorPosition = {
      let previewFrame = morphingPlatterView.frame;
      let screenBounds = UIScreen.main.bounds;
      
      return (previewFrame.midY < screenBounds.midY) ? .top : .bottom;
    }();
    
    /// whether to attach the `auxiliaryView` on the top or bottom of the context menu
    let shouldAttachToTop: Bool = {
      switch menuItemsPlacement {
        case .top   : return true;
        case .bottom: return false;
          
        default:
          // the context menu does not have menu items, determine anchor position
          // of auxiliary view via the position of the preview in the screen
          return morphingPlatterViewPlacement == .bottom;
      };
    }();
    
    // // TODO: Temp - `auxiliaryView` margins
    let marginLeading: CGFloat = 10;
    let marginTrailing: CGFloat = 10;
    
    let auxiliaryViewHeight: CGFloat = 100;
    
    /// enable auto layout
    previewAuxiliaryView.translatesAutoresizingMaskIntoConstraints = false;
    
    /// attach `auxiliaryView` to context menu preview
    contextMenuContentContainer.addSubview(previewAuxiliaryView);
    
    NSLayoutConstraint.activate([
      previewAuxiliaryView.leadingAnchor
        .constraint(equalTo: morphingPlatterView.leadingAnchor),
      
      previewAuxiliaryView.trailingAnchor
        .constraint(equalTo: morphingPlatterView.trailingAnchor),
      
      // TODO: Temp
      previewAuxiliaryView.heightAnchor
        .constraint(equalToConstant: auxiliaryViewHeight),
      
      shouldAttachToTop
        ? previewAuxiliaryView.bottomAnchor
          .constraint(equalTo: morphingPlatterView.topAnchor, constant: -marginLeading)
      
        : previewAuxiliaryView.topAnchor
          .constraint(equalTo: morphingPlatterView.bottomAnchor, constant: marginLeading)
    ]);
    
    
    let offset: CGFloat = {
      let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets;
      
      let previewFrame = morphingPlatterView.frame;
      let screenHeight = UIScreen.main.bounds.height;
      
      let marginBase = marginLeading + marginTrailing;
      
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
    
    // transition - start value
    previewAuxiliaryView.alpha = 0;
    
    // fade in transition
    UIView.animate(withDuration: 0.3) {
      previewAuxiliaryView.alpha = 1;
      
      contextMenuContentContainer.frame =
        contextMenuContentContainer.frame.offsetBy(dx: 0, dy: offset)
    };
  };
  
  func detachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating?
  ){
    guard let animator = animator,
          let previewAuxiliaryView = self.previewAuxiliaryViewWrapper?.reactContent
    else { return };
    
    /// Bug:
    /// * "Could not locate shadow view with tag #, this is probably caused by a temporary inconsistency
    ///   between native views and shadow views."
    /// * Triggered when the menu is about to be hidden, iOS removes the context menu along with the
    ///   `previewAuxiliaryViewContainer`
    
    animator.addAnimations {
      previewAuxiliaryView.alpha = 0;
    };
    
    //animator.addCompletion {
    //  previewAuxiliaryViewContainer.removeFromSuperview();
    //};
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
      // experimental
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
    // experimental
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

  func contextMenuInteraction(
    _ : UIContextMenuInteraction,
    previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration
) -> UITargetedPreview? {
  
    return self.makeTargetedPreview();
  };
  
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForDismissingMenuWithConfiguration
    configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
};

// MARK: - RNIContextMenu
// ----------------------

@available(iOS 13, *)
extension RNIContextMenuView: RNIContextMenu {
  
  func notifyViewControllerDidPop(sender: RNIContextMenuViewController) {
    // trigger cleanup
    self.cleanup();
  };
  
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
