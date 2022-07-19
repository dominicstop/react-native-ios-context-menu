//
//  RNIContextMenuButtonModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 7/19/22.
//

import Foundation


@objc(RNIContextMenuButtonModule)
internal class RNIContextMenuButtonModule: NSObject {
  
  @objc var bridge: RCTBridge!;
  
  @objc static func requiresMainQueueSetup() -> Bool {
    // run init in bg thread
    return false;
  };
  
  @available(iOS 14, *)
  func getContextMenuButton(_ node: NSNumber) -> RNIContextMenuButton? {
    return RNIUtilities.getView(
      forNode: node,
      type   : RNIContextMenuButton.self,
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
      // get `RNIContextMenuButton` instance that matches node/reactTag
      guard #available(iOS 14, *),
            let contextMenuButton = self.getContextMenuButton(node) else {
              
        reject(nil, "Unable to get the corresponding 'RNIContextMenuButton' for node: \(node)", nil);
        return;
      };
      
      contextMenuButton.dismissMenu();
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
      // get `RNIContextMenuButton` instance that matches node/reactTag
      guard #available(iOS 14, *),
            let contextMenuButton = self.getContextMenuButton(node) else {
              
        reject(nil, "Unable to get the corresponding 'RNIContextMenuButton' for node: \(node)", nil);
        return;
      };
      
      contextMenuButton.provideDeferredElements(
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
};
