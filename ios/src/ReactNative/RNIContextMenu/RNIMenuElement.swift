//
//  RCTMenuProtocols.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/24/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


class RNIMenuElement  {
  
  enum MenuElementType: String, Encodable {
    case action, deferred, menu;
  };
  
  var type: MenuElementType?;
  
  init?(dictionary: NSDictionary){
    self.type = {
      guard let string = dictionary["type"] as? String
      else { return nil };
      
      return MenuElementType(rawValue: string);
    }();
  };
  
  @available(iOS 13.0, *)
  func createMenuElement(
    actionItemHandler      actionHandler  : @escaping RNIMenuActionItem.ActionItemHandler,
    deferredElementHandler deferredHandler: @escaping RNIDeferredMenuElement.RequestHandler
  ) -> UIMenuElement? {
    
    if let menuItem = self as? RNIMenuItem  {
      return menuItem.createMenu(
        actionItemHandler: actionHandler,
        deferredElementHandler: deferredHandler
      );
      
    } else if let actionItem = self as? RNIMenuActionItem {
      return actionItem.createAction(handler: actionHandler);
      
    } else if #available(iOS 14.0, *),
              let deferredElement = self as? RNIDeferredMenuElement {
      
      return deferredElement.createDeferredElement(handler: deferredHandler);
    };
    
    return nil;
  };
};

extension RNIMenuElement: Encodable, Hashable {
  static func == (lhs: RNIMenuElement, rhs: RNIMenuElement) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs);
  };
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self).hashValue)
  };
};
