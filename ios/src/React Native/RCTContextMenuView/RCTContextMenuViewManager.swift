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
    if #available(iOS 13.0, *) {
      return RCTContextMenuView(bridge: self.bridge);
      
    } else {
      return RCTView();
    };
  };
  
  @objc func dismissMenu(_ node: NSNumber) {
    DispatchQueue.main.async {
      guard #available(iOS 13.0, *),
            let view = self.bridge.uiManager.view(forReactTag: node),
            let contextMenuView = view as? RCTContextMenuView
      else { return };
      
      contextMenuView.dissmissMenu();
    };
  };
};
