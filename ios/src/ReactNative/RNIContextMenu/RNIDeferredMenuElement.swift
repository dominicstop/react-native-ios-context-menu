//
//  RNIDeferredMenuElement.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 6/23/22.
//

import Foundation
import UIKit


class RNIDeferredMenuElement: RNIMenuElement {
  
  @available(iOS 13.0, *)
  typealias CompletionHandler = ([UIMenuElement]) -> Void;
  
  @available(iOS 13.0, *)
  typealias RequestHandler = (
    _ deferredID: String,
    _ completion: @escaping CompletionHandler
  ) -> Void;
  
  // MARK: - Serialized Properties
  // -----------------------------
  
  var deferredID: String;
  
  override init?(dictionary: NSDictionary){
    guard let deferredID = dictionary["deferredID"] as? String
    else { return nil };
    
    self.deferredID = deferredID;
    
    super.init(dictionary: dictionary);
    
    guard self.type == .deferred
    else { return nil };
  };
  
  @available(iOS 14.0, *)
  func createDeferredElement(handler: @escaping RequestHandler) -> UIDeferredMenuElement {
    // make local copy to prevent using `[weak self]`
    let deferredID = self.deferredID;
    
    return UIDeferredMenuElement { completion in
      handler(deferredID, completion);
    };
  };
};
