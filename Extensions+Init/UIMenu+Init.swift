//
//  UIMenu+Init.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/12/21.
//

import UIKit

@available(iOS 13, *)
extension UIMenu.Options {
  init?(string: String){
    switch string {
      case "destructive"  : self = .destructive;
      case "displayInline": self = .displayInline;
      
      default: return nil;
    };
  };
};

