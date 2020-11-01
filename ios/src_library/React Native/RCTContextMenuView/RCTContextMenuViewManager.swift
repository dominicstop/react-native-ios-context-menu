//
//  RCTContextMenuManager.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import Foundation

@objc(RCTContextMenuViewManager)
class RCTContextMenuViewManager: RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
    return true;
  };
  
  override func view() -> UIView! {
    if #available(iOS 13, *) {
      return RCTContextMenuView(bridge: self.bridge);
      
    } else {
      return RCTView();
    };
  };
};
