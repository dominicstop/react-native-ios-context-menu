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
  
  var menuTitle: String;
  
  var menuOptions: [String]?;
  var imageType  : ImageType = .NONE;
  var imageValue : String?;
  
  var menuItems: [RCTMenuElement]?;
  
// ------------------------
// MARK: RCTMenuItem - Init
// ------------------------

  init?(dictionary: NSDictionary){
    guard let menuTitle = dictionary["menuTitle"] as? NSString else {
      #if DEBUG
      print("RCTMenuItem, init failed - menuTitle: nil");
      #endif
      return nil;
    };
    
    self.menuTitle = menuTitle as String;
    
    if let string    = dictionary["imageType"] as? String,
       let imageType = ImageType(rawValue: string) {
      
      self.imageType = imageType;
    };
    
    self.imageValue  = dictionary["imageValue" ] as? String;
    self.menuOptions = dictionary["menuOptions"] as? [String];
    
    #if DEBUG
    print("RCTMenuItem, init"
      + " - menuTitle"   + ": \(self.menuTitle)"
      + " - imageType"   + ": \(self.imageType)"
      + " - imageValue"  + ": \(self.imageValue ?? "N/A")"
      + " - menuOptions" + ": \(self.menuOptions?.description ?? "N/A")"
      + " - menuItems"   + ": \((dictionary["menuItems"] as? NSArray)?.count ?? 0) items"
    );
    #endif
    
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
    
    #if DEBUG
    print("RCTMenuItem, init"
      + " - menuItems" + ": \(self.menuItems?.count ?? 0) Items"
    );
    #endif
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// ---------------------------------------
// MARK: RCTMenuItem - Computed Properties
// ---------------------------------------

@available(iOS 13.0, *)
extension RCTMenuItem {
  /// get `UIMenu.Options` from `menuOptions` strings
  var UIMenuOptions: UIMenu.Options {
    UIMenu.Options.init(
      self.menuOptions?.compactMap {
        UIMenu.Options.fromString($0);
      } ?? []
    );
  };
  
  var image: UIImage? {
    switch self.imageType {
      case .NONE: return nil;
      case .URL : return nil; // to be implemented
      
      case .SYSTEM:
        guard let imageValue = self.imageValue else { return nil };
        return UIImage(systemName: imageValue);
        
      case .ASSET:
        guard let imageValue = self.imageValue else { return nil };
        return UIImage(named: imageValue);
    };
  };
};

// -----------------------------
// MARK: RCTMenuItem - Functions
// -----------------------------

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
    
    #if DEBUG
    print("RCTMenuItem, createMenu"
      + " - menuItems count: \(menuItems?.count ?? 0)"
    );
    #endif
    
    return UIMenu(
      title: self.menuTitle,
      image: self.image,
      identifier: nil,
      options: self.UIMenuOptions,
      children: menuItems ?? []
    );
  };
};




