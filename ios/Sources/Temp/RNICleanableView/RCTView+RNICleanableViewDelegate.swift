//
//  RCTView+RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import React

public extension RNICleanableViewDelegate where Self: RCTView {
  
  var viewCleanupKey: Int {
    self.reactTag.intValue;
  };
};
