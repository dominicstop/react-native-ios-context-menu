//
//  RNIMenuActionItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 13, *)
class RNIMenuActionItem: RNIMenuElement {
  
  var actionKey  : String;
  var actionTitle: String;
  
  var icon: RCTMenuIcon;
  var discoverabilityTitle: String?;
  
  var menuState     : String?;
  var menuAttributes: [String]?;
  
// MARK: - Init
// ------------

  init?(dictionary: NSDictionary){
    guard let actionKey   = dictionary["actionKey"  ] as? String,
          let actionTitle = dictionary["actionTitle"] as? String
    else { return nil };
    
    self.actionKey   = actionKey;
    self.actionTitle = actionTitle;
    
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
    
    self.discoverabilityTitle = dictionary["discoverabilityTitle"] as? String;
    
    self.menuState      = dictionary["menuState"     ] as? String;
    self.menuAttributes = dictionary["menuAttributes"] as? [String];
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};


// MARK: - Computed Properties
// ---------------------------

@available(iOS 13, *)
extension RNIMenuActionItem {
  
  var synthesizedMenuElementAttributes: UIMenuElement.Attributes {
    UIMenuElement.Attributes(
      self.menuAttributes?.compactMap {
        UIMenuElement.Attributes(string: $0);
      } ?? []
    );
  };
  
  var synthesizedMenuElementState: UIMenuElement.State {
    guard
      let menuState        = self.menuState,
      let menuElementState = UIMenuElement.State(string: menuState)
    else { return .off };
    
    return menuElementState;
  };
  
  var synthesizedIdentifier: UIAction.Identifier {
    UIAction.Identifier(self.actionKey);
  };
  
  /// Creates a dictionary containing all the raw values that was used to create this `RNIMenuActionItem`
  /// instance. The dictionary created will be suitable for sending it back to js/react (e.g. usually through an
  /// event or promise callback).
  var dictionaryFromRawValues: [String: Any] {
    var dictionary: [String: Any] = [
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
    
    if let menuState = self.menuState {
      dictionary["menuState"] = menuState;
    };
    
    return dictionary;
  };
};

// MARK: - Functions
// -----------------

@available(iOS 13, *)
extension RNIMenuActionItem {
  
  typealias UIActionHandlerWithDict = ([String: Any], UIAction) -> Void;
  
  func makeUIAction(_ handler: @escaping UIActionHandlerWithDict) -> UIAction {
    #if DEBUG
    print("RNIMenuActionItem, makeUIAction...");
    #endif
    
    return UIAction(
      title     : self.actionTitle,
      image     : self.icon.image ,
      identifier: self.synthesizedIdentifier,
      
      discoverabilityTitle: self.discoverabilityTitle,
      
      attributes: self.synthesizedMenuElementAttributes,
      state     : self.synthesizedMenuElementState,
      
      handler: {
        handler(self.dictionaryFromRawValues, $0)
      }
    );
  };
};
