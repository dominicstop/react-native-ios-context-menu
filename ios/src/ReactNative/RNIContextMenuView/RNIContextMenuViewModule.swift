//
//  RNIContextMenuViewModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/16/21.
//

import Foundation


@objc(RNIContextMenuViewModule)
internal class RNIContextMenuViewModule: NSObject {
  
  @objc var bridge: RCTBridge! {
    willSet {
      RNIUtilities.sharedBridge = newValue;
    }
  };
  
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
  
  @objc func provideDeferredElements(
    _ node: NSNumber,
    deferredID: String,
    menuItems: NSArray,
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
      
      contextMenuView.provideDeferredElements(
        id: deferredID,
        menuElements: menuItems.compactMap {
          guard let dictItem = $0 as? NSDictionary else { return nil };
          
          return (
            RNIMenuItem(dictionary: dictItem) ??
            RNIMenuActionItem(dictionary: dictItem) ??
            RNIDeferredMenuElement(dictionary: dictItem)
          );
        }
      );
      
      resolve(nil);
    };
  };
  
  @objc func notifyComponentWillUnmount(
    _ node: NSNumber,
    params: NSDictionary
  ){
    DispatchQueue.main.async {
      // get `RNIWrapperView` instance that matches node/reactTag
      guard #available(iOS 13, *),
            let contextMenuView = self.getContextMenuView(node) else {
        #if DEBUG
        print(
            "LOG - ViewManager, RNIWrapperViewModule: notifyComponentWillUnmount"
          + " - for node: \(node)"
          + " - no corresponding view found for node"
          + " - the view might have already been unmounted..."
        );
        #endif
        return;
      };
      
      contextMenuView.notifyOnJSComponentWillUnmount();
    };
  };
};
