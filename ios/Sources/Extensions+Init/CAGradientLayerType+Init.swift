//
//  CAGradientLayerType+Init.swift
//  react-native-ios-navigator
//
//  Created by Dominic Go on 4/12/21.
//

import Foundation

extension CAGradientLayerType {
  init?(string: String){
    switch string {
      case "axial" : self = .axial;
      case "radial": self = .radial;
        
      case "conic" :
        if #available(iOS 12.0, *) {
          self = .conic;
          
        } else {
          return nil;
        };
        
      default: return nil;
    }
  };
};
