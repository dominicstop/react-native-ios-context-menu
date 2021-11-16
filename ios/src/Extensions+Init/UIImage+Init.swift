//
//  UIImage+Init.swift
//  react-native-ios-navigator
//
//  Created by Dominic Go on 10/2/21.
//

import Foundation
import UIKit

extension UIImage.RenderingMode {
  init?(string: String){
    switch string {
      case "automatic"     : self = .automatic;
      case "alwaysOriginal": self = .alwaysOriginal;
      case "alwaysTemplate": self = .alwaysTemplate;
        
      default: return nil;
    };
  };
};

@available(iOS 13.0, *)
extension UIImage.SymbolWeight {
  init?(string: String){
    switch string {
      case "unspecified": self = .unspecified;
      case "ultraLight" : self = .ultraLight;
      case "thin"       : self = .thin;
      case "light"      : self = .light;
      case "regular"    : self = .regular;
      case "medium"     : self = .medium;
      case "semibold"   : self = .semibold;
      case "bold"       : self = .bold;
      case "heavy"      : self = .heavy;
      case "black"      : self = .black;

      default: return nil;
    };
  };
};

@available(iOS 13.0, *)
extension UIImage.SymbolScale {
  init?(string: String){
    switch string {
      case "default"     : self = .`default`;
      case "unspecified" : self = .unspecified;
      case "small"       : self = .small;
      case "medium"      : self = .medium;
      case "large"       : self = .large;

      default: return nil;
    };
  };
};
