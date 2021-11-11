//
//  RCTMenuItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 13.0, *)
class RCTMenuItem: RCTMenuElement {
  
  // MARK: - Properties
  // ------------------
  
  var menuTitle: String;
  var icon     : RCTMenuIcon;
  
  var menuOptions: [String]?;
  var menuItems  : [RCTMenuElement]?;
  
  // MARK: - Init
  // ------------

  init?(dictionary: NSDictionary){
    guard let menuTitle = dictionary["menuTitle"] as? NSString
    else { return nil };
    
    self.menuTitle   = menuTitle as String;
    self.menuOptions = dictionary["menuOptions"] as? [String];
    
    if let dict = dictionary["icon"] as? NSDictionary {
      self.icon = RCTMenuIcon(dictionary: dict);
      
    // temp support for icon config shorthand/shortcut
    } else if let stringType = dictionary["iconType" ] as? String,
              let iconValue  = dictionary["iconValue"] as? String,
              let iconType   = RCTMenuIcon.IconType(rawValue: stringType) {
      
      self.icon = RCTMenuIcon(type: iconType, value: iconValue);
    
    // temp support for prev version, remove in the future
    } else if let stringType = dictionary["imageType" ] as? String,
              let iconValue  = dictionary["imageValue"] as? String,
              let iconType   = RCTMenuIcon.IconType(rawValue: stringType) {
      
      self.icon = RCTMenuIcon(type: iconType, value: iconValue);
      
    } else {
      self.icon = RCTMenuIcon();
    };
    
    if let menuElements = dictionary["menuItems"] as? NSArray {
      self.menuItems = menuElements.compactMap {
        if let menuItem = RCTMenuItem(dictionary: $0 as? NSDictionary) {
          #if DEBUG
          print("RCTMenuItem, init - compactMap: Creating RCTMenuItem...");
          #endif
          return menuItem;
          
        } else if let menuAction = RCTMenuActionItem(dictionary: $0 as? NSDictionary) {
          #if DEBUG
          print("RCTMenuItem, init - compactMap: Creating RCTMenuActionItem...");
          #endif
          return menuAction;
          
        } else {
          #if DEBUG
          print("RCTMenuItem, init - compactMap: nil");
          #endif
          return nil;
        };
      };
    };
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// MARK: - Computed Properties
// ---------------------------

@available(iOS 13.0, *)
extension RCTMenuItem {
  /// get `UIMenu.Options` from `menuOptions` strings
  var UIMenuOptions: UIMenu.Options {
    UIMenu.Options(
      self.menuOptions?.compactMap {
        UIMenu.Options(string: $0);
      } ?? []
    );
  };
};

// MARK: - Functions
// -----------------

@available(iOS 13.0, *)
extension RCTMenuItem {
  func createMenu(_ handler: @escaping RCTMenuActionItem.UIActionHandlerWithDict) -> UIMenu {
    let menuItems: [UIMenuElement]? = self.menuItems?.compactMap {
      if let menu = $0 as? RCTMenuItem {
        #if DEBUG
        print("RCTMenuItem, createMenu item: RCTMenuItem");
        #endif
        return menu.createMenu(handler);
        
      } else if let action = $0 as? RCTMenuActionItem {
        #if DEBUG
        print("RCTMenuItem, createMenu item: RCTMenuActionItem");
        #endif
        return action.makeUIAction(handler);
        
      } else {
        #if DEBUG
        print("RCTMenuItem, createMenu item: nil");
        #endif
        return nil;
      };
    };
    
    return UIMenu(
      title: self.menuTitle,
      image: self.icon.image,
      identifier: nil,
      options: self.UIMenuOptions,
      children: menuItems ?? []
    );
  };
};


