//
//  UIContextMenuInteractionCommitStyle+Init.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/12/21.
//

import UIKit;

@available(iOS 13.0, *)
extension UIContextMenuInteractionCommitStyle {
  init?(string: String) {
    switch string {
      case "dismiss": self = .dismiss;
      case "pop"    : self = .pop;
      
      default: return nil;
    };
  };
};
