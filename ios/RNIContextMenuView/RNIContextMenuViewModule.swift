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
      
        let contextMenuView = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuView.self,
          bridge: bridge
        );
        
        guard let contextMenuView = contextMenuView else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        contextMenuView.dismissMenu();
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
      
        let contextMenuView = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuView.self,
          bridge: bridge
        );
        
        guard let contextMenuView = contextMenuView else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
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
        
        promise.resolve();
      };
    };
    
    AsyncFunction("notifyOnComponentWillUnmount") {
      (reactTag: Int, promise: Promise) in
      
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
      
        let contextMenuView = RNIHelpers.getView(
          forNode: reactTag as NSNumber,
          type: RNIContextMenuView.self,
          bridge: bridge
        );
        
        guard let contextMenuView = contextMenuView else {
          let error = RNIError(
            domain: "react-native-ios-context-menu",
            description: "Could not get view instance",
            extraDebugInfo: "reactTag: \(reactTag)"
          );
          
          promise.reject(error);
          return;
        };
        
        contextMenuView.notifyOnJSComponentWillUnmount();
        promise.resolve();
      };
    };

    View(RNIContextMenuView.self) {
      Events("onMenuWillShow");
      Events("onMenuWillHide");
      Events("onMenuWillCancel");
      Events("onMenuDidShow");
      Events("onMenuDidHide");
      Events("onMenuDidCancel");
      Events("onPressMenuItem");
      Events("onPressMenuPreview");
      Events("onMenuWillCreate");
      Events("onRequestDeferredElement");
      Events("onMenuAuxiliaryPreviewWillShow");
      Events("onMenuAuxiliaryPreviewDidShow");
      
      Prop("menuConfig") {
        $0.menuConfigRaw = $1;
      };
      
      Prop("previewConfig") {
        $0.previewConfigRaw = $1;
      };
      
      Prop("shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle") {
        $0.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = $1;
      };
      
      Prop("internalCleanupMode") {
        $0.internalCleanupModeRaw = $1;
      };
      
      Prop("isAuxiliaryPreviewEnabled") {
        $0.isAuxiliaryPreviewEnabled = $1;
      };
      
      Prop("auxiliaryPreviewConfig") {
        $0.auxiliaryPreviewConfigRaw = $1;
      };
      
    };
  };
};
