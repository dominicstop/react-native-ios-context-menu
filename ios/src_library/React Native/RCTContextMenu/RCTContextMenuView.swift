//
//  RCTContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import Foundation
import UIKit

@available(iOS 13, *)
class RCTContextMenuView: UIView {
  
  @objc var onPressMenuItem: RCTDirectEventBlock?;
    
  private var _menuConfig: RCTMenuItem<RCTMenuElementItem>?;
  @objc var menuConfig: NSDictionary? {
    didSet {
      guard
        let menuConfig = self.menuConfig,
        menuConfig.count > 0 else { return };
      
      #if DEBUG
      print("menuConfig didSet"
        + " - RCTMenuItem init"
        + " - menuConfig count: \(menuConfig.count)"
      );
      #endif
      
      self._menuConfig = RCTMenuItem(dictionary: menuConfig);
    }
  };
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    
    let interaction = UIContextMenuInteraction(delegate: self);
    self.addInteraction(interaction);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

// -----------------------------------------------------------
// MARK: RCTContextMenuView - UIContextMenuInteractionDelegate
// -----------------------------------------------------------

@available(iOS 13, *)
extension RCTContextMenuView: UIContextMenuInteractionDelegate {
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    guard  let menuConfig = self._menuConfig else {
      #if DEBUG
      print("guard check failed - contextMenuInteraction, menuConfig: is nil");
      #endif
      return nil;
    };
    
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
      return menuConfig.createMenu({ (key, action) in
        self.onPressMenuItem?(["key": key]);
      })
    });
  };
};
