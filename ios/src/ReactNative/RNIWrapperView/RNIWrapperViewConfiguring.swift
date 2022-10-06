//
//  RNIWrapperViewConfiguring.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 10/7/22.
//

import UIKit


protocol RNIWrapperViewConfiguring: AnyObject {
  func point(
    for sender: RNIWrapperView,
    point: CGPoint,
    with event: UIEvent?
  ) -> Bool?;
};

extension RNIWrapperViewConfiguring {
  func point(
    for sender: RNIWrapperView,
    point: CGPoint,
    with event: UIEvent?
  ) -> Bool? {
    return nil;
  };
};
