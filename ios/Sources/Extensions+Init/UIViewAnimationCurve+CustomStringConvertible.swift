//
//  UIViewAnimationCurve+CustomStringConvertible.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation

extension UIView.AnimationCurve: CustomStringConvertible {

  public var description: String {
    switch self {
      case .easeInOut:
        return "easeInOut";
        
      case .easeIn:
        return "easeIn";
        
      case .easeOut:
        return "easeOut";
        
      case .linear:
        return "linear";
        
      @unknown default:
        return "unknown";
    };
  };
};

