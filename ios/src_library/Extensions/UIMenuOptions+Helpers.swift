//
//  UIMenuOptions+Helpers.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

extension UIMenu.Options {
  static func fromString(_ string: String) -> UIMenu.Options? {
    switch string {
      case "destructive"  : return .destructive;
      case "displayInline": return .displayInline;
      
      default: return nil;
    };
  };
  
  static func fromString(_ string: String?) -> UIMenu.Options? {
    guard let string = string else { return nil };
    return UIMenu.Options.fromString(string);
  };
};
