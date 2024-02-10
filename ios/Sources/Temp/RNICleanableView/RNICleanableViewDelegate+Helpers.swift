//
//  RNICleanableViewDelegate+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import React
import DGSwiftUtilities


public extension RNICleanableViewDelegate where Self: RCTView {

  var associatedCleanableViewItem: RNICleanableViewItem? {
    get {
      RNICleanableViewRegistry.shared.getEntry(forKey: self.viewCleanupKey);
    }
  };
  
  var viewsToCleanup: Array<WeakRef<UIView>>? {
    self.associatedCleanableViewItem?.viewsToCleanup;
  };
};
