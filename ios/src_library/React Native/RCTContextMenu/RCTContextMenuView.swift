//
//  RCTContextMenuView.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import Foundation
import UIKit


class RCTContextMenuView: UIView {
  
  @objc var onPressMenuItem: RCTDirectEventBlock?;
  
  @objc var menuTitle: NSString = "";
  
  private var _menuOptions: UIMenu.Options = [];
  @objc var menuOptions: NSArray? {
    didSet {
      guard
        let menuOptions = self.menuOptions,
        menuOptions.count > 0 else { return };
      
      self._menuOptions = UIMenu.Options.init(
        menuOptions.compactMap {
          UIMenu.Options.fromString($0 as? String)
        }
      );
    }
  };
  
  private var _menuItems: [RCTMenuActionItem] = [];
  @objc var menuItems: NSArray? {
    didSet {
      guard
        let menuItems = self.menuItems,
        menuItems.count > 0 else { return };
      
      self._menuItems = self.parseMenuItems(menuItems);
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
  
  // -----------------------
  // MARK: Private Functions
  // -----------------------
  
  private func parseMenuItems(_ items: NSArray) -> [RCTMenuActionItem] {
    return items.compactMap {
      guard
         let dict     = $0 as? NSDictionary,
         let menuItem = RCTMenuActionItem.init(dictionary: dict)
       else { return nil };
      
      return menuItem;
    };
  };
  
  private func makeContextMenu() -> UIMenu {
    
    
    // Create and return a UIMenu with the actions from menuItems
    return UIMenu(
      title   : self.menuTitle as String,
      options : self._menuOptions,
      children: self._menuItems.compactMap {
        $0.makeUIMenuElement(){ (key, action) in
          self.onPressMenuItem?(["key": key]);
        };
      }
    );
  };
};

extension RCTContextMenuView: UIContextMenuInteractionDelegate {
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
      return self.makeContextMenu();
    });
  };
};
