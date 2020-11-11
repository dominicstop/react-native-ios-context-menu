//
//  RCTMenuActionItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 13, *)
class RCTMenuActionItem: RCTMenuElement {
  
  var actionKey  : String;
  var actionTitle: String;
  
  var icon: RCTMenuIcon;
  var discoverabilityTitle: String?;
  
  var menuState     : String?;
  var menuAttributes: [String]?;
  
// ------------------------------
// MARK: RCTMenuActionItem - Init
// ------------------------------

  init?(dictionary: NSDictionary){
    guard let actionKey   = dictionary["actionKey"  ] as? NSString,
          let actionTitle = dictionary["actionTitle"] as? NSString
    else {
      #if DEBUG
      print(
          "RCTMenuActionItem, init failed"
        + " - actionKey  : \(dictionary["actionKey"  ] as? NSString ?? "N/A")"
        + " - actionTitle: \(dictionary["actionTitle"] as? NSString ?? "N/A")"
      );
      #endif
      return nil;
    };
    
    self.actionKey   = actionKey   as String;
    self.actionTitle = actionTitle as String;
    
    if let dict = dictionary["icon"] as? NSDictionary,
       let icon = RCTMenuIcon(dictionary: dict) {
      
      self.icon = icon;
    
    // temp support for prev version, remove in the future
    } else if let stringType = dictionary["imageType" ] as? String,
              let iconValue  = dictionary["imageValue"] as? String,
              let iconType   = RCTMenuIcon.IconType(rawValue: stringType) {
      
      self.icon = RCTMenuIcon(type: iconType, value: iconValue);
      
    } else {
      self.icon = RCTMenuIcon();
    };
    
    self.discoverabilityTitle = dictionary["discoverabilityTitle"] as? String;
    
    self.menuState      = dictionary["menuState"     ] as? String;
    self.menuAttributes = dictionary["menuAttributes"] as? [String];
    
    #if DEBUG
    print("RCTMenuActionItem, init"
      + " - actionKey"      + ": \(self.actionKey      )"
      + " - actionTitle"    + ": \(self.actionTitle    )"
      + " - icon"           + ": \(self.icon.dictionary)"
      + " - menuState"      + ": \(self.menuState?     .description ?? "N/A")"
      + " - menuAttributes" + ": \(self.menuAttributes?.description ?? "N/A")"
    );
    #endif
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// ---------------------------------------------
// MARK: RCTMenuActionItem - Computed Properties
// ---------------------------------------------

@available(iOS 13, *)
extension RCTMenuActionItem {
  
  var UIMenuElementAttributes: UIMenuElement.Attributes {
    UIMenuElement.Attributes.init(
      self.menuAttributes?.compactMap {
        UIMenuElement.Attributes.fromString($0);
      } ?? []
    );
  };
  
  var UIMenuElementState: UIMenuElement.State {
    guard
      let menuState        = self.menuState,
      let menuElementState = UIMenuElement.State.fromString(menuState)
    else { return .off };
    
    return menuElementState;
  };
  
  var identifier: UIAction.Identifier {
    UIAction.Identifier(self.actionKey);
  };
  
  var dictionary: [AnyHashable: Any] {
    var dictionary: [AnyHashable: Any] = [
      "actionKey"  : self.actionKey  ,
      "actionTitle": self.actionTitle,
      "icon"       : self.icon       ,
    ];
    
    if let discoverabilityTitle = self.discoverabilityTitle {
      dictionary["discoverabilityTitle"] = discoverabilityTitle;
    };
    
    if let menuAttributes = self.menuAttributes {
      dictionary["menuAttributes"] = menuAttributes;
    };
    
    return dictionary;
  };
};

// -----------------------------------
// MARK: RCTMenuActionItem - Functions
// -----------------------------------

@available(iOS 13, *)
extension RCTMenuActionItem {
  
  typealias UIActionHandlerWithDict = ([AnyHashable: Any], UIAction) -> Void;
  
  func makeUIAction(_ handler: @escaping UIActionHandlerWithDict) -> UIAction {
    #if DEBUG
    print("RCTMenuActionItem, makeUIAction...");
    #endif
    
    return UIAction(
      title     : self.actionTitle,
      image     : self.icon.image ,
      identifier: self.identifier ,
      discoverabilityTitle: self.discoverabilityTitle,
      attributes: self.UIMenuElementAttributes,
      state     : self.UIMenuElementState,
      handler   : { handler(self.dictionary, $0) }
    );
  };
};
