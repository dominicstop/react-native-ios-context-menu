//
//  CGVector+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation

extension CGVector {
  
  init?(dict: Dictionary<String, Any>) {
    guard let dx = dict["dx"] as? NSNumber,
          let dy = dict["dy"] as? NSNumber
    else { return nil };
    
    self.init(
      dx: dx.doubleValue,
      dy: dy.doubleValue
    );
  }
};
