//
//  RCTMenuActionItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


@available(iOS 13, *)
class RCTMenuActionItem: RCTMenuElement {
  
  var actionKey  : String;
  var actionTitle: String;
  
  var imageType: ImageType = .NONE;
  
  var imageValue    : String?;
  var menuState     : String?;
  var menuAttributes: [String]?;
  
// ------------------------------
// MARK: RCTMenuActionItem - Init
// ------------------------------

  init?(dictionary: NSDictionary){
    guard
      let actionKey   = dictionary["actionKey"  ] as? NSString,
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

    self.imageType = {
      let text = dictionary["imageType"] as? String ?? "";
      return ImageType.withLabel(text) ?? .NONE;
    }();
    
    self.menuState      = dictionary["menuState"     ] as? String;
    self.imageValue     = dictionary["imageValue"    ] as? String;
    self.menuAttributes = dictionary["menuAttributes"] as? [String];
    
    #if DEBUG
    print("RCTMenuActionItem, init"
      + " - actionKey"      + ": \(self.actionKey  )"
      + " - actionTitle"    + ": \(self.actionTitle)"
      + " - menuState"      + ": \(self.menuState?     .description ?? "N/A")"
      + " - imageValue"     + ": \(self.imageValue?    .description ?? "N/A")"
      + " - menuAttributes" + ": \(self.menuAttributes?.description ?? "N/A")"
    );
    #endif
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// ---------------------------------------
// MARK: RCTMenuActionItem - Computed Properties
// ---------------------------------------

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
  
  var image: UIImage? {
    switch self.imageType {
      case .NONE: return nil;
      case .URL : return nil; // to be implemented
      
      case .SYSTEM:
        guard let imageValue = self.imageValue else { return nil };
        return UIImage(systemName: imageValue);
    };
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
    
    let dictionary: [AnyHashable: Any] = [
      "actionKey"     : self.actionKey  ,
      "actionTitle"   : self.actionTitle,
      "imageType"     : self.imageType  ,
      "imageValue"    : self.imageValue     ?? [],
      "menuAttributes": self.menuAttributes ?? [],
    ];
    
    return UIAction(
      title     : self.actionTitle,
      image     : self.image,
      identifier: self.identifier,
      attributes: self.UIMenuElementAttributes,
      state     : self.UIMenuElementState,
      handler   : { handler(dictionary, $0) }
    );
  };
};
