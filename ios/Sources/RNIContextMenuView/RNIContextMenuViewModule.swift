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
        do {
          let contextMenuView = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuView.self
          );
          
          try contextMenuView.dismissMenu();
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
          let contextMenuView = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuView.self
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
          
          try contextMenuView.provideDeferredElements(
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

    AsyncFunction("presentMenu") { (reactTag: Int, promise: Promise) in
      
      DispatchQueue.main.async {
        do {
          let contextMenuView = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuView.self
          );
          
          try contextMenuView.presentMenu();
          promise.resolve();
        
        } catch let error {
          promise.reject(error);
        };
      };
    };
    
    AsyncFunction("showAuxiliaryPreviewAsPopover") { (reactTag: Int, promise: Promise) in
      
      DispatchQueue.main.async {
        do {
          let contextMenuView = try RNIModuleHelpers.getView(
            withErrorType: RNIContextMenuError.self,
            forNode: reactTag,
            type: RNIContextMenuView.self
          );
          
          try contextMenuView.showAuxiliaryPreviewAsPopover();
          promise.resolve();
        
        } catch let error {
          promise.reject(error);
        };
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
      
      Prop("internalViewCleanupMode") {
        $0.internalViewCleanupModeRaw = $1;
      };
      
      Prop("isAuxiliaryPreviewEnabled") {
        $0.isAuxiliaryPreviewEnabled = $1;
      };
      
      Prop("auxiliaryPreviewConfig") {
        $0.auxiliaryPreviewConfigRaw = $1;
      };
      
      Prop("shouldPreventLongPressGestureFromPropagating") {
        $0.shouldPreventLongPressGestureFromPropagating = $1;
      };
    };
  };
};
