//
//  RNIContextMenuButtonModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 7/19/22.
//

import Foundation
import ExpoModulesCore
import ReactNativeIosUtilities


public class RNIContextMenuButtonModule: Module {
  
  public func definition() -> ModuleDefinition {
    Name("RNIContextMenuButton");
    
    AsyncFunction("dismissMenu") { (reactTag: Int, promise: Promise) in
      DispatchQueue.main.async {
        guard let bridge = RNIHelpers.bridge else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get bridge instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
      
        let contextMenuButton = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuButton.self,
          bridge: bridge
        );
        
        guard let contextMenuButton = contextMenuButton else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        contextMenuButton.dismissMenu();
        promise.resolve();
      };
    };
    
    AsyncFunction("provideDeferredElements") {
      (reactTag: Int, args: Dictionary<String, Any>, promise: Promise) in
      
      DispatchQueue.main.async {
        guard let bridge = RNIHelpers.bridge else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get bridge instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        guard let deferredID = args["deferredID"] as? String,
              let menuItems = args["menuItems"] as? Array<Any>
        else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not parse arguments",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
      
        let contextMenuButton = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuButton.self,
          bridge: bridge
        );
        
        guard let contextMenuButton = contextMenuButton else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        contextMenuButton.provideDeferredElements(
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
        
        promise.resolve();
      };
    };
    
    AsyncFunction("notifyOnComponentWillUnmount") {
      (reactTag: Int, isManuallyTriggered: Bool, promise: Promise) in
      
      DispatchQueue.main.async {
        guard let bridge = RNIHelpers.bridge else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get bridge instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
      
        let contextMenuButton = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuButton.self,
          bridge: bridge
        );
        
        guard let contextMenuButton = contextMenuButton else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        contextMenuButton.notifyOnJSComponentWillUnmount();
        promise.resolve();
      };
    };

    View(RNIContextMenuButton.self) {
      Events("onMenuWillShow");
      Events("onMenuWillHide");
      Events("onMenuWillCancel");
      Events("onMenuDidShow");
      Events("onMenuDidHide");
      Events("onMenuDidCancel");
      Events("onPressMenuItem");
      Events("onRequestDeferredElement");
    
      Prop("menuConfig") {
        $0.menuConfigRaw = $1;
      };
      
      Prop("isMenuPrimaryAction") {
        $0.isMenuPrimaryAction = $1;
      };
      
      Prop("isContextMenuEnabled") {
        $0.isContextMenuEnabled = $1;
      };
      
      Prop("internalCleanupMode") {
        $0.internalCleanupModeRaw = $1;
      };
    };
  };
};
