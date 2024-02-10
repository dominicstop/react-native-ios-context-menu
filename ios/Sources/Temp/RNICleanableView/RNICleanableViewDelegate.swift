//
//  RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import Foundation

public protocol RNICleanableViewDelegate: AnyObject {

  var viewCleanupKey: Int { get };
  
  func notifyOnViewCleanupRequest(
    sender: RNICleanableViewSenderType,
    item: RNICleanableViewItem
  ) -> Bool;
  
  func notifyOnViewCleanupCompletion();
};
