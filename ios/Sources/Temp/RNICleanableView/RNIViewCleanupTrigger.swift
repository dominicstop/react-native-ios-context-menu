//
//  RNIViewCleanupTrigger.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/11/24.
//

import Foundation

public enum RNIViewCleanupTrigger: String {
  case instanceDeinit;
  case reactComponentWillUnmount;
  case viewControllerLifecycle;
  case didMoveToNilWindow;
};
