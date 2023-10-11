//
//  RNIContextMenuViewModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/16/21.
//

import Foundation
import ExpoModulesCore
import ReactNativeIosUtilities

public class RNIContextMenuViewModule: Module {
  
  public func definition() -> ModuleDefinition {
    Name("RNIContextMenuView");
    
    Function("dismissMenu") { (reactTag: Int) in
      guard let bridge = RNIHelpers.bridge else { return };
    
      let contextMenuView = RNIHelpers.getView(
        forNode: reactTag as NSNumber,
        type: RNIContextMenuView.self,
        bridge: bridge
      );
      
      guard let contextMenuView = contextMenuView else { return };
      contextMenuView.dismissMenu();
    };
    
    Function("provideDeferredElements") {
      (reactTag: Int, args: Dictionary<String, Any>) in
      
      guard let bridge = RNIHelpers.bridge,
            let deferredID = args["deferredID"] as? String,
            let menuItems = args["menuItems"] as? Array<Any>
      else { return };
    
      let contextMenuView = RNIHelpers.getView(
        forNode: reactTag as NSNumber,
        type: RNIContextMenuView.self,
        bridge: bridge
      );
      
      guard let contextMenuView = contextMenuView else { return };
      
      contextMenuView.provideDeferredElements(
        id: deferredID,
        menuElements: menuItems.compactMap {
          guard let dictItem = $0 as? Dictionary<String, Any> else { return nil };
          
          return (
            RNIMenuItem(dictionary: dictItem) ??
            RNIMenuActionItem(dictionary: dictItem) ??
            RNIDeferredMenuElement(dictionary: dictItem)
          );
        }
      );
    };
    
    Function("notifyOnComponentWillUnmount") { (reactTag: Int) in
      guard let bridge = RNIHelpers.bridge else { return };
    
      let contextMenuView = RNIHelpers.getView(
        forNode: reactTag as NSNumber,
        type: RNIContextMenuView.self,
        bridge: bridge
      );
      
      guard let contextMenuView = contextMenuView else { return };
      contextMenuView.notifyOnJSComponentWillUnmount();
    };

    View(RNIDummyView.self) {
      Events("onReactTagDidSet");
    
      Prop("shouldCleanupOnComponentWillUnmount") { (view: RNIDummyView, prop: Bool) in
        view.shouldCleanupOnComponentWillUnmount = prop;
      };
    };
  };
};
