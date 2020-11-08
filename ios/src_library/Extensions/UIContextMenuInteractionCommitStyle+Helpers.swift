//
//  UIContextMenuInteractionCommitStyle+Helpers.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/9/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;

@available(iOS 13.0, *)
extension UIContextMenuInteractionCommitStyle {
  static func fromString(_ string: String) -> UIContextMenuInteractionCommitStyle? {
    switch string {
      case "dismiss": return .dismiss;
      case "pop"    : return .pop;
      
      default: return nil;
    };
  };
};
