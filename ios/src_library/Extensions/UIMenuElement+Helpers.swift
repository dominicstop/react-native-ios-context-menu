//
//  UIMenuElement+Helpers.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/15/20.
//

import UIKit;


@available(iOS 13, *)
extension UIMenuElement.Attributes {
  static func fromString(_ string: String) -> UIMenuElement.Attributes? {
    switch string {
      case "hidden"     : return .hidden;
      case "disabled"   : return .disabled;
      case "destructive": return .destructive;
      
      default: return nil;
    };
  };
};

@available(iOS 13, *)
extension UIMenuElement.State {
  static func fromString(_ string: String) -> UIMenuElement.State? {
    switch string {
      case "on"   : return .on;
      case "off"  : return .off;
      case "mixed": return .mixed;
      
      default: return nil;
    };
  };
};

