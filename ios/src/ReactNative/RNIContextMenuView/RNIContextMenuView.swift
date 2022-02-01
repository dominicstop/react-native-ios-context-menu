//
//  RNIContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;


@available(iOS 13, *)
class RNIContextMenuView: UIView {
  
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
  
  weak var previewAuxiliaryViewContainer: UIView?;
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
      guard let menuConfigDict = self.menuConfig else { return };
      let menuConfig = RNIMenuItem(dictionary: menuConfigDict);
      
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
    self.previewAuxiliaryViewContainer != nil;
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
    
    if let previewWrapper = subview as? RNIWrapperView {
      // a previous preview view already exists... cleanup if needed.
      self.previewWrapper?.cleanup();
      
      self.previewWrapper = previewWrapper;
      
      previewWrapper.willChangeSuperview = true;
      previewWrapper.autoCleanupOnJSUnmount = true;
      
      previewWrapper.removeFromSuperview();
      previewWrapper.willChangeSuperview = false;
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
    // temp. disable
    return;
    
    guard animator != nil,
          let contextMenuContentContainer = self.contextMenuContentContainer,
          let morphingPlatterView = self.morphingPlatterView
    else { return };
    
    /// whether to attach the `auxiliaryView` on the top or bottom of the context menu
    let shouldAttachToTop: Bool = {
      let previewFrame = morphingPlatterView.frame;
      let screenBounds = UIScreen.main.bounds;
      
      return previewFrame.midY < screenBounds.midY;
    }();
    
    let auxiliaryView: UIButton = {
      let button = UIButton(frame: CGRect(
        origin: .zero,
        size: CGSize(width: 100, height: 75)
      ));
      
      button.setTitle("Hello World", for: .normal);
      button.backgroundColor = .systemPurple;
      button.layer.cornerRadius = 15;
      
      button.addTarget(self, action: #selector(self.onTouchDownContextMenuAuxiliaryPreview), for: .touchDown);
      button.addTarget(self, action: #selector(self.onTouchUpInsideContextMenuAuxiliaryPreview), for: .touchUpInside);
      
      
      button.translatesAutoresizingMaskIntoConstraints = false;
      
      //button.frame = button.frame.offsetBy(dx: 0, dy: -button.frame.height)
      
      return button;
    }();
    
    self.previewAuxiliaryViewContainer = auxiliaryView;
    
    let margin: CGFloat = 10;
    
    /// attach `auxiliaryView` to context menu preview
    contextMenuContentContainer.addSubview(auxiliaryView);
    
    NSLayoutConstraint.activate([
      auxiliaryView.leadingAnchor .constraint(equalTo: morphingPlatterView.leadingAnchor ),
      auxiliaryView.trailingAnchor.constraint(equalTo: morphingPlatterView.trailingAnchor),
      
      shouldAttachToTop
        ? auxiliaryView.bottomAnchor
          .constraint(equalTo: morphingPlatterView.topAnchor, constant: -margin)
      
        : auxiliaryView.topAnchor
          .constraint(equalTo: morphingPlatterView.bottomAnchor, constant: margin)
    ]);
    
    auxiliaryView.alpha = 0;
    
    // fade in transition
    UIView.animate(withDuration: 0.3) {
      auxiliaryView.alpha = 1;
    };
  };
  
  func detachContextMenuAuxiliaryPreviewIfAny(
    _ animator: UIContextMenuInteractionAnimating?
  ){
    // temp. disable
    return;
    guard let animator = animator,
          let previewAuxiliaryViewContainer = self.previewAuxiliaryViewContainer
    else { return };
    
    animator.addAnimations {
      previewAuxiliaryViewContainer.alpha = 0;
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
    
    return UIContextMenuConfiguration(
      identifier     : nil,
      previewProvider: self.createMenuPreview,
      actionProvider : self.createMenu
    );
  };
  
  @objc func onTouchDownContextMenuAuxiliaryPreview(){
    
    guard let button = self.previewAuxiliaryViewContainer as? UIButton
    else { return };
    
    button.layer.opacity = 0.5;
  };
  
  @objc func onTouchUpInsideContextMenuAuxiliaryPreview(){
    print("button pressed");
    
    guard let button = self.previewAuxiliaryViewContainer as? UIButton
    else { return };
    
    UIView.animate(withDuration: 0.3) {
      button.layer.opacity = 1;
    };
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
