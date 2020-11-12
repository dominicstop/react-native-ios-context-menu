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
  
  @objc func dismissMenu(_ node: NSNumber) {
    DispatchQueue.main.async {
      guard let view =  self.bridge.uiManager.view(forReactTag: node)
      else { return };
      
      if #available(iOS 14, *),
         let contextMenuButton = view as? RCTContextMenuButton {

        contextMenuButton.dissmissMenu();
        
      } else if #available(iOS 13, *),
                let contextMenuView = view as? RCTContextMenuView {
        
        contextMenuView.dissmissMenu();
      };
    };
  };
};
