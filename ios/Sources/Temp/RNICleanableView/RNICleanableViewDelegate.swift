//
//  RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import Foundation
import React

public protocol RNICleanableViewDelegate: AnyObject {

  var viewCleanupKey: Int { get };
  
  var bridge: RCTBridge? { get };
  
  func notifyOnViewCleanupRequest(
    sender: RNICleanableViewSenderType,
    item: RNICleanableViewItem
  ) -> Bool;
  
  func notifyOnViewCleanupCompletion();
  
  
};
