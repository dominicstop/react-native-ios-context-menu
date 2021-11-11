//
//  RCTContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;


@available(iOS 13, *)
class RCTContextMenuView: UIView {
  
  // -------------------------------------
  // MARK: RCTContextMenuView - Properties
  // -------------------------------------
  
  weak var bridge: RCTBridge!;
  
  var isContextMenuVisible = false;
  var didPressMenuItem     = false;
  
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  weak var reactPreviewView : UIView?;
  weak var previewController: RCTContextMenuPreviewController?;
  
  // ---------------------------------------------
  // MARK: RCTContextMenuView - RN Event Callbacks
  // ---------------------------------------------
  
  @objc var onMenuWillShow  : RCTBubblingEventBlock?;
  @objc var onMenuWillHide  : RCTBubblingEventBlock?;
  @objc var onMenuWillCancel: RCTBubblingEventBlock?;
  
  @objc var onMenuDidShow  : RCTBubblingEventBlock?;
  @objc var onMenuDidHide  : RCTBubblingEventBlock?;
  @objc var onMenuDidCancel: RCTBubblingEventBlock?;
  
  @objc var onPressMenuItem   : RCTBubblingEventBlock?;
  @objc var onPressMenuPreview: RCTBubblingEventBlock?;
  
  @objc var onMenuWillCreate: RCTBubblingEventBlock?;
  
  // -----------------------------------
  // MARK: RCTContextMenuView - RN Props
  // -----------------------------------
    
  private var _menuConfig: RCTMenuItem?;
  @objc var menuConfig: NSDictionary? {
    didSet {
      guard
        let menuConfig     = self.menuConfig, menuConfig.count > 0,
        let rootMenuConfig = RCTMenuItem(dictionary: menuConfig)
      else { return };
      
      #if DEBUG
      print("menuConfig didSet"
        + " - RCTMenuItem init"
        + " - menuConfig count: \(menuConfig.count)"
      );
      #endif
      
      self._menuConfig = rootMenuConfig;
      
      if #available(iOS 14.0, *)  ,
         self.isContextMenuVisible,
         let interaction: UIContextMenuInteraction = self.contextMenuInteraction {
        
        #if DEBUG
        print("menuConfig didSet"
          + " - Updating  visible menu"
          + " - menuItems: \(menuConfig["menuItems"] ?? "N/A")"
        );
        #endif
        
        // context menu is open, update the menu items
        interaction.updateVisibleMenu {(menu: UIMenu) in
          return rootMenuConfig.createMenu {(dict, action) in
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
  
  // -------------------------------
  // MARK: RCTContextMenuView - Init
  // -------------------------------
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    
    self.bridge = bridge;
    self.contextMenuInteraction = {
      let interaction = UIContextMenuInteraction(delegate: self);
      self.addInteraction(interaction);
      
      return interaction;
    }();
    
    /// init shared `RCTImageLoader` instance if nil
    if RCTMenuIcon.ImageLoader.sharedInstance == nil,
       let module      = bridge.module(for: RCTImageLoader.self),
       let imageLoader = module as? RCTImageLoader {
      
      RCTMenuIcon.ImageLoader.sharedInstance = imageLoader;
    };
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  // -----------------------------------------
  // MARK: RCTContextMenuButton - RN Lifecycle
  // -----------------------------------------

  override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    super.insertSubview(subview, at: atIndex);
    
    if atIndex == 0 {
      subview.removeFromSuperview();
      self.reactPreviewView = subview;
    };
  };
};

// ------------------------------------------------
// MARK: RCTContextMenuView - ViewManager Functions
// ------------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView {
  @objc func dissmissMenu(){
    self.contextMenuInteraction?.dismissMenu();
  };
};

// --------------------------------------------
// MARK: RCTContextMenuView - Private Functions
// --------------------------------------------

@available(iOS 13, *)
fileprivate extension RCTContextMenuView {
  
  func notifyForBoundsChange(_ newBounds: CGRect){
    guard
      let bridge    = self.bridge,
      let reactView = self.reactPreviewView
    else { return };
        
    bridge.uiManager.setSize(newBounds.size, for: reactView);
  };
  
  /// create `UIMenu` based on `menuConfig` prop
  func createMenu(_ suggestedAction: [UIMenuElement]) -> UIMenu? {
    guard  let menuConfig = self._menuConfig else {
      #if DEBUG
      print("RCTContextMenuView, createMenu"
        + " - guard check failed, menuConfig: nil"
      );
      #endif
      return nil;
    };
    
    return menuConfig.createMenu { (dict, action) in
      self.didPressMenuItem = true;
      self.onPressMenuItem?(dict);
    };
  };
  
  /// create custom menu preview based on `previewConfig` and `reactPreviewView`
  func createMenuPreview() -> UIViewController? {
    // alias to variable
    let previewConfig = self._previewConfig;
    
    /// dont make preview if `previewType` is default.
    guard previewConfig.previewType != .DEFAULT
    else { return nil };
    
    let vc = RCTContextMenuPreviewController();
    vc.reactView = self.reactPreviewView;
    vc.previewConfig = previewConfig;
    
    vc.boundsDidChangeBlock = { [weak self] (newBounds: CGRect) in
      self?.notifyForBoundsChange(newBounds);
    };
    
    self.previewController = vc;
    return vc;
  };
  
  /// confgiure target preview based on `previewConfig`
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
       let targetView = self.bridge.uiManager.view(forReactTag: targetNode){
      
      return UITargetedPreview(
        view: targetView,
        parameters: parameters
      );
      
    } else {
      return UITargetedPreview(
        view: self,
        parameters: parameters
      );
    };
  };
};

// -----------------------------------------------------------
// MARK: RCTContextMenuView - UIContextMenuInteractionDelegate
// -----------------------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView: UIContextMenuInteractionDelegate {
  
  // create context menu
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    self.onMenuWillCreate?([:]);
    
    return UIContextMenuConfiguration(
      identifier     : nil,
      previewProvider: self.createMenuPreview,
      actionProvider : self.createMenu
    );
  };
  
  // context menu display begins
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    #if DEBUG
    print("RCTContextMenuView, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will show"
    );
    #endif
    
    self.isContextMenuVisible = true;
    self.onMenuWillShow?([:]);
    
    animator?.addCompletion {
      self.onMenuDidShow?([:]);
    };
  };
  
  // context menu display ends
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    #if DEBUG
    print("RCTContextMenuView, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will hide"
    );
    #endif
    
    guard self.isContextMenuVisible else { return };
    
    self.onMenuWillHide?([:]);
    if !self.didPressMenuItem {
      self.onMenuWillCancel?([:]);
    };
    
    animator?.addCompletion {
      if !self.didPressMenuItem {
        self.onMenuDidCancel?([:]);
      };
      
      self.onMenuDidHide?([:]);
      self.didPressMenuItem = false;
    };
    
    self.isContextMenuVisible = false;
  };
  
  // context menu preview tapped
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
    #if DEBUG
    print("RCTContextMenuView, UIContextMenuInteractionDelegate"
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

  func contextMenuInteraction(_ : UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration) -> UITargetedPreview? {
    return self.makeTargetedPreview();
  };
  
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    return self.makeTargetedPreview();
  };
};
