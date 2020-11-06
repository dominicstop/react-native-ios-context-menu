//
//  RCTContextMenuButtonManager.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/28/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@objc(RCTContextMenuButtonManager)
class RCTContextMenuButtonManager: RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
    return true;
  };
  
  override func view() -> UIView! {
    if #available(iOS 14, *) {
      return RCTContextMenuButton(bridge: self.bridge);
      
    } else if #available(iOS 13, *) {
      return RCTContextMenuView(bridge: self.bridge);
      
    } else {
      return RCTView();
    };
  };
};
