//
//  RCTContextMenuManager.swift
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

import Foundation

@objc(RCTContextMenuManager)
class RCTContextMenuManager: RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
    return true;
  };
  
  override func view() -> UIView! {
    let view = RCTContextMenuView(bridge: self.bridge);    
    return view;
  };
};
