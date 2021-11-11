//
//  UIMenuElement+Init.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/12/21.
//

import UIKit

@available(iOS 13, *)
extension UIMenuElement.Attributes {
  init?(string: String){
    switch string {
      case "hidden"     : self = .hidden;
      case "disabled"   : self = .disabled;
      case "destructive": self = .destructive;
      
      default: return nil;
    };
  };
};

@available(iOS 13, *)
extension UIMenuElement.State {
  init?(string: String){
    switch string {
      case "on"   : self = .on;
      case "off"  : self = .off;
      case "mixed": self = .mixed;
      
      default: return nil;
    };
  };
};
