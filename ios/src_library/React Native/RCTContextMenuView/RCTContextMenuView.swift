//
//  RCTContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import UIKit;


@available(iOS 13, *)
class RCTContextMenuView: UIView {
  
  enum PreviewType: String, CaseIterable, Encodable {
    case DEFAULT = "DEFAULT";
    case CUSTOM  = "CUSTOM";
    
    static func withLabel(_ label: String) -> PreviewType? {
      return self.allCases.first{ $0.rawValue == label };
    };
  };
  
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
  
  private var _previewType: PreviewType = .DEFAULT;
  @objc var previewType: NSString? {
    didSet {
      guard
        let previewTypeString = self.previewType as String?,
        let previewType       = PreviewType(rawValue: previewTypeString)
      else { return };
      
      self._previewType = previewType;
    }
  };
  
  @objc var previewSize: NSDictionary?;
  
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
    guard self._previewType != .DEFAULT else { return nil };
    
    let hasPreviewSize: Bool = (
      self.previewSize?["width" ] != nil ||
      self.previewSize?["height"] != nil
    );
    
    let vc = RCTContextMenuPreviewController();
    vc.reactView = reactPreviewView;
    
    if hasPreviewSize {
      let screenSize: CGRect = UIScreen.main.bounds;
      
      // get preview width and height from props
      let previewWidth  = self.previewSize?["width" ] as? CGFloat ?? screenSize.width;
      let previewHeight = self.previewSize?["height"] as? CGFloat ?? screenSize.height;
      
      vc.preferredContentSize = CGSize(width: previewWidth, height: previewHeight);
    };
    
    vc.boundsDidChangeBlock = { [weak self] (newBounds: CGRect) in
      self?.notifyForBoundsChange(newBounds);
    };
    
    return vc;
  };
};

// -----------------------------------------------------------
// MARK: RCTContextMenuView - UIContextMenuInteractionDelegate
// -----------------------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView: UIContextMenuInteractionDelegate {
  
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
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
};
