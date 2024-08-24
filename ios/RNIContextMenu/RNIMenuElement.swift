//
//  RCTMenuProtocols.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/24/20.
//

import Foundation


public class RNIMenuElement  {
  
  // MARK: - Embedded Types
  // ----------------------
  
  public enum MenuElementType: String, Encodable {
    case action, deferred, menu;
  };
  
  // MARK: - Class Members
  // ---------------------
  
  @available(iOS 13.0, *)
  public static func recursivelyGetAllElements<T>(
    from menuConfig: RNIMenuItem,
    ofType type: T.Type
  ) -> [T] {
  
    guard let menuItems = menuConfig.menuItems
    else { return [] };
    
    var matchingElements: [T] = [];
    
    for menuItem in menuItems {
      if let submenu = menuItem as? RNIMenuItem {
        // recursive
        matchingElements.append(
          contentsOf: Self.recursivelyGetAllElements(
            from: submenu,
            ofType: T.self
          )
        );
        
      } else if let element = menuItem as? T {
        matchingElements.append(element);
      };
    };
    
    return matchingElements;
  };
  
  // MARK: - Properties
  // ------------------
  
  public var type: MenuElementType?;
  
  public weak var parent: RNIMenuElement?;
  public weak var delegate: RNIMenuElementEventsNotifiable?;
  
  // MARK: - Init
  // ------------
  
  public init?(dictionary: Dictionary<String, Any>){
    self.type = {
      guard let string = dictionary["type"] as? String
      else { return nil };
      
      return MenuElementType(rawValue: string);
    }();
  };
  
  // MARK: - Functions
  // -----------------
  
  @available(iOS 13.0, *)
  public func createMenuElement(
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

// MARK: - RNIMenuElementEventsNotifiable
// --------------------------------------

extension RNIMenuElement: RNIMenuElementEventsNotifiable {
  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let delegate = self.delegate ?? self.parent?.delegate
    else { return };
    
    delegate.notifyOnMenuElementUpdateRequest(for: element);
  };
};
