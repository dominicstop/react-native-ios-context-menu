//
//  RNIContextMenuViewModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/16/21.
//

import Foundation


@objc(RNIContextMenuViewModule)
internal class RNIContextMenuViewModule: NSObject {
  
  @objc var bridge: RCTBridge!;
  
  @objc static func requiresMainQueueSetup() -> Bool {
    // run init in bg thread
    return false;
  };
  
  @available(iOS 13, *)
  func getContextMenuView(_ node: NSNumber) -> RNIContextMenuView? {
    return RNIUtilities.getView(
      forNode: node,
      type   : RNIContextMenuView.self,
      bridge : self.bridge
    );
  };
  
  // MARK: - Module Commands: Navigator
  // ---------------------------------
  
  @objc func dismissMenu(
    _ node: NSNumber,
    // promise blocks ------------------------
    resolve: @escaping RCTPromiseResolveBlock,
    reject : @escaping RCTPromiseRejectBlock
  ){
    DispatchQueue.main.async {
      // get `RNIContextMenuView` instance that matches node/reactTag
      guard #available(iOS 13, *),
            let contextMenuView = self.getContextMenuView(node) else {
              
        reject(nil, "Unable to get the corresponding 'RNIContextMenuView' for node: \(node)", nil);
        return;
      };
      
      contextMenuView.dismissMenu();
      resolve(nil);
    };
  };
};
