//
//  UIViewAnimationCurve+CaseIterable.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation

extension UIView.AnimationCurve: CaseIterable {

  public static var allCases: [UIView.AnimationCurve] = [
    .easeIn,
    .easeOut,
    .easeInOut,
    .linear,
  ];
};
