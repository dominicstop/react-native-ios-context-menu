//
//  RNICleanupMode.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/20/22.
//

import Foundation


enum RNICleanupMode: String {
  
  case automatic;
  
  /// Trigger cleanup via view controller lifecycle
  case viewController;
  
  /// Trigger cleanup via react lifecycle `componentWillUnmount` event sent from js
  case reactComponentWillUnmount;
  
  case disabled;
  
};
