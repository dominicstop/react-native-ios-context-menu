//
//  RNIDeferredMenuElement.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 6/23/22.
//

import Foundation
import UIKit


public class RNIDeferredMenuElement: RNIMenuElement {
  
  @available(iOS 13.0, *)
  public typealias CompletionHandler = ([UIMenuElement]) -> Void;
  
  @available(iOS 13.0, *)
  public typealias RequestHandler = (
    _ deferredID: String,
    _ completion: @escaping CompletionHandler
  ) -> Void;
  
  // MARK: - Serialized Properties
  // -----------------------------
  
  public var deferredID: String;
  public var shouldCache: Bool;
  
  public override init?(dictionary: Dictionary<String, Any>){
    guard let deferredID = dictionary["deferredID"] as? String
    else { return nil };
    
    self.deferredID = deferredID;
    self.shouldCache = dictionary["shouldCache"] as? Bool ?? true;
    
    super.init(dictionary: dictionary);
    
    guard self.type == .deferred
    else { return nil };
  };
  
  @available(iOS 14.0, *)
  public func createDeferredElement(
    handler: @escaping RequestHandler
  ) -> UIDeferredMenuElement {
  
    // make local copy to prevent using `[weak self]`
    let cachedDeferredID = self.deferredID;
    
    #if swift(>=5.5)
    if !self.shouldCache,
       #available(iOS 15.0, *) {
      
      return UIDeferredMenuElement.uncached { completion in
        handler(cachedDeferredID, completion);
      };
    };
    #endif
    
    return UIDeferredMenuElement { completion in
      handler(cachedDeferredID, completion);
    };
  };
};
