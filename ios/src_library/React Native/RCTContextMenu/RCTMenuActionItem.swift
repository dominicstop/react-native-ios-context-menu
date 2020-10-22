//
//  RCTMenuActionItem.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import Foundation;
import UIKit;


public enum ImageType: String, CaseIterable, Encodable {
  case NONE   = "NONE";
  case URL    = "URL";
  case SYSTEM = "SYSTEM";
  
  static func withLabel(_ label: String) -> ImageType? {
    return self.allCases.first{ $0.rawValue == label };
  };
};

// -----------------
// MARK: RCTMenuActionItem
// -----------------

@available(iOS 13, *)
struct RCTMenuActionItem: Hashable, Encodable {
  typealias UIActionHandlerWithKey = (String, UIAction) -> Void;
  
  var key           : String;
  var title         : String;
  var imageType     : ImageType;
  var imageValue    : String?;
  var menuState     : String?;
  var menuAttributes: [String]?;
  
  var submenuItems: [RCTMenuActionItem]?;
  
};

// ------------------------
// MARK: RCTMenuActionItem - Init
// ------------------------

@available(iOS 13, *)
extension RCTMenuActionItem {
  init?(dictionary: NSDictionary){
    guard
      let key   = dictionary["key"  ] as? String,
      let title = dictionary["title"] as? String

    else {
      #if DEBUG
      print("RCTMenuActionItem, init failed... dumping dictionary:");
      dump(dictionary);
      #endif
      return nil;
    };
    
    self.key   = key;
    self.title = title;

    self.imageType = {
      let text = dictionary["imageType"] as? String ?? "";
      return ImageType.withLabel(text) ?? .NONE;
    }();
    
    self.menuState      = dictionary["menuState"     ] as? String;
    self.imageValue     = dictionary["imageValue"    ] as? String;
    self.menuAttributes = dictionary["menuAttributes"] as? [String];
    
    if let submenuItems = dictionary["submenuItems"] as? NSArray {
      self.submenuItems = submenuItems.compactMap {
        RCTMenuActionItem(dictionary: $0 as? NSDictionary)
      };
    };
  };
  
  init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// ---------------------------------------
// MARK: RCTMenuActionItem - Computed Properties
// ---------------------------------------

@available(iOS 13, *)
extension RCTMenuActionItem {
  
  // Note: using computed property bc UIMenuElement.Attributes,
  // UIElement.State does not conform to Hashable/Encodable so
  // we cant use them as properties
  
  var uiMenuElementAttributes: UIMenuElement.Attributes {
    UIMenuElement.Attributes.init(
      self.menuAttributes?.compactMap {
        UIMenuElement.Attributes.fromString($0);
      } ?? []
    );
  };
  
  var uiMenuElementState: UIMenuElement.State {
    guard
      let menuState        = self.menuState,
      let menuElementState = UIMenuElement.State.fromString(menuState)
    else { return .off };
    
    return menuElementState;
  };
  
  var identifier: UIAction.Identifier {
    UIAction.Identifier(self.key);
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

// -----------------------------
// MARK: RCTMenuActionItem - Functions
// -----------------------------

@available(iOS 13, *)
extension RCTMenuActionItem {
  
  func makeSubmenu(_ handler: @escaping UIActionHandlerWithKey) -> UIMenuElement {
    return UIMenu(
      title: self.title,
      image: self.image,
      children:
        self.submenuItems?.compactMap { $0.makeUIAction(handler) }
        ?? []
    );
  };
  
  func makeUIAction(_ handler: @escaping UIActionHandlerWithKey) -> UIMenuElement {
    return self.submenuItems != nil
      ? self.makeSubmenu(handler)
      : UIAction(
          title     : self.title,
          image     : self.image,
          identifier: self.identifier,
          attributes: self.uiMenuElementAttributes,
          state     : self.uiMenuElementState,
          handler   : { handler(self.key, $0) }
        );
  };
  
  func makeUIMenuElement(handler: @escaping UIActionHandlerWithKey) -> UIMenuElement {
    return self.submenuItems != nil
      ? self.makeSubmenu (handler)
      : self.makeUIAction(handler)
  };
};
