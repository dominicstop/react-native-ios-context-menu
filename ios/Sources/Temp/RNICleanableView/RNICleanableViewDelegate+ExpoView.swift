//
//  ExpoView+RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import Foundation
import React
import ExpoModulesCore

extension RNICleanableViewDelegate where Self: ExpoView {
  
  var bridge: RCTBridge? {
    self.appContext?.reactBridge;
  };
};
