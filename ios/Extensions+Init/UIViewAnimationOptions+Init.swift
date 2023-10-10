//
//  UIViewAnimate+Init.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 6/18/22.
//

import UIKit


extension UIView.AnimationOptions {
  init?(string: String){
    switch string {
      case "curveEaseIn"   : self = .curveEaseIn;
      case "curveEaseOut"  : self = .curveEaseOut;
      case "curveEaseInOut": self = .curveEaseInOut;
      case "curveLinear"   : self = .curveLinear;
        
      default: return nil;
    };
  };
};
