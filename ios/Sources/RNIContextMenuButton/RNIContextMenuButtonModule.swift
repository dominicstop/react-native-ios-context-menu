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
    
    AsyncFunction("presentMenu") { (reactTag: Int, promise: Promise) in
      DispatchQueue.main.async {
        do {
          let contextMenuButton = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuButton.self
          );
          
          try contextMenuButton.presentMenu();
          promise.resolve();
        
        } catch let error {
          promise.reject(error);
        };
      };
    };
    
    AsyncFunction("dismissMenu") { (reactTag: Int, promise: Promise) in
      DispatchQueue.main.async {
        do {
          let contextMenuButton = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuButton.self
          );
          
          try contextMenuButton.dismissMenu();
          promise.resolve();
        
        } catch let error {
          promise.reject(error);
        };
      };
    };
    
    AsyncFunction("provideDeferredElements") {
      (reactTag: Int, args: Dictionary<String, Any>, promise: Promise) in
      
      DispatchQueue.main.async {
        do {
          let contextMenuButton = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuButton.self
          );
          
          var debugValues: Dictionary<String, Any> = ["reactTag": reactTag];
          debugValues.merge(args) { (_, new) in new };
          
          guard let deferredID = args["deferredID"] as? String,
                let menuItems = args["menuItems"] as? Array<Any>
          else {
            throw RNIContextMenuError(
              errorCode: .unableToParseArguments,
              extraDebugValues: debugValues
            );
          };
          
          try contextMenuButton.provideDeferredElements(
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
        
        } catch let error {
          promise.reject(error);
        };
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
      
      Prop("internalViewCleanupMode") {
        $0.internalViewCleanupModeRaw = $1;
      };
    };
  };
};
