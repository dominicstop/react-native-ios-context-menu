//
//  UIViewAnimationCurve+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation

extension UIView.AnimationCurve {
  
  public init?(string: String){
    let match = Self.allCases.first {
      $0.description == string;
    };
    
    guard let match = match else { return nil };
    self = match;
  };
};
