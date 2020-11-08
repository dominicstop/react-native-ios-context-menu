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
  
  weak var bridge: RCTBridge?;
  
  var isContextMenuVisible = false;
  var didPressMenuItem     = false;
  
  var contextMenuInteraction: UIContextMenuInteraction?;
  
  var reactPreviewView: UIView?;
  
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
        let rootMenuConfig = RCTMenuItem(dictionary: menuConfig) else { return };
      
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
      guard let previewConfigDict = self.previewConfig else { return }
      self._previewConfig = PreviewConfig(dictionary: previewConfigDict);
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

// --------------------------------------------
// MARK: RCTContextMenuView - Private Functions
// --------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView {
  
  private func notifyForBoundsChange(_ newBounds: CGRect){
    guard
      let bridge    = self.bridge,
      let reactView = self.reactPreviewView else { return };
        
    bridge.uiManager.setSize(newBounds.size, for: reactView);
  };
  
  /// get the menu preview size based on `PreviewConfig` prop
  private func getPreviewSize() -> CGSize {
    // alias to variable
    let previewConfig = self._previewConfig;
    // get screen size
    let screenSize: CGRect = UIScreen.main.bounds;
    
    /// get frame from react custom preview
    /// the frame of `reactPreviewView` and it's first subview are the same, the difference is that
    /// the first child (i.e. the view returned from the `renderPreview` prop) will be rendered/mounted
    /// when the context menu is about to be shown, meanwhile `reactPreviewView` will always be
    /// mounted. Thus, when `renderPreview`is mounted, `reactPreviewView` will have the same
    /// frame size, but when `renderPreview` is not mounted,  the frame size  of `reactPreviewView`
    /// will be (0, 0) since it doesn't have any subviews. The first subview of `reactPreviewView` will be
    /// `nil` when `renderPreview` is not mounted.
    let previewFrame = self.reactPreviewView?.subviews.first?.frame;
    
    // get the preview width from previewConfig
    let previewWidth: CGFloat = {
      let screenWidth = screenSize.width;
      
      switch previewConfig.previewWidth {
        case .inherit: return previewFrame?.width ?? screenWidth;
        case .stretch: return 0;
          
        case let .custom(size): return size;
      };
    }();
    
    // get the preview height from previewConfig
    let previewHeight: CGFloat = {
      let screenHeight = screenSize.height;
      
      switch previewConfig.previewHeight {
        case .inherit: return previewFrame?.height ?? screenHeight;
        case .stretch: return 0;
          
        case let .custom(size): return size;
      };
    }();
    
    return CGSize(width: previewWidth, height: previewHeight);
  };
  
  /// create `UIMenu` based on `menuConfig` prop
  private func createMenu(_ suggestedAction: [UIMenuElement]) -> UIMenu? {
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
  
  
  private func createMenuPreview() -> UIViewController? {
    // alias to variable
    let previewConfig = self._previewConfig;
    
    /// dont make preview if `previewType` is default.
    guard previewConfig.previewType != .DEFAULT else { return nil };
    
    let vc = RCTContextMenuPreviewController();
    vc.reactView = self.reactPreviewView;
    
    vc.view.backgroundColor = .clear;
    vc.preferredContentSize = self.getPreviewSize();
    
    vc.boundsDidChangeBlock = { [weak self] (newBounds: CGRect) in
      self?.notifyForBoundsChange(newBounds);
    };

    return vc;
  };
  
  private func makeTargetedPreview() -> UITargetedPreview {
    // alias to variable
    let previewConfig = self._previewConfig;
    
    guard self._previewConfig.previewType == .CUSTOM  else {
      // no custom preview defined
      return UITargetedPreview(view: self);
    };
    
    return UITargetedPreview(view: self, parameters: {
      let parameters = UIPreviewParameters();
      
      // set preview bg color
      parameters.backgroundColor = previewConfig.backgroundColor;
      
      // set preview border shape
      parameters.visiblePath = UIBezierPath(
        // get width/height from custom preview view
        roundedRect: CGRect(
          origin: CGPoint(x: 0, y: 0),
          size  : self.frame.size
        ),
        // set the preview corner radius
        cornerRadius: previewConfig.previewBorderRadius
      );
      
      return parameters;
    }());
  };
};

// -----------------------------------------------------------
// MARK: RCTContextMenuView - UIContextMenuInteractionDelegate
// -----------------------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView: UIContextMenuInteractionDelegate {
  
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    self.onMenuWillCreate?([:]);
    
    return UIContextMenuConfiguration(
      identifier: nil,
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
    self.isContextMenuVisible = false;
    self.onPressMenuPreview?([:]);
  };

  func contextMenuInteraction(_ : UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration) -> UITargetedPreview? {
    return self.makeTargetedPreview();
  };
  
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    return self.makeTargetedPreview();
  };
};
