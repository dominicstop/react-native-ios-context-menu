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
      
    } else {
      return RCTView();
    };
  };
  
  @objc func dismissMenu(_ node: NSNumber) {
    DispatchQueue.main.async {
      guard #available(iOS 14, *),
            let view = self.bridge.uiManager.view(forReactTag: node),
            let contextMenuButton = view as? RCTContextMenuButton
      else { return };
      
      contextMenuButton.dissmissMenu();
    };
  };
};
