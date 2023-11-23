//
//  CGPoint+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation


extension CGPoint {
  
  public init?(dict: Dictionary<String, Any>){
    guard let x = dict["x"] as? NSNumber,
          let y = dict["y"] as? NSNumber
    else { return nil };
    
    self.init(
      x: x.doubleValue,
      y: y.doubleValue
    );
  };
};
