//
//  RNIContextMenuButtonModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 7/19/22.
//

import Foundation
import ExpoModulesCore
import ReactNativeIosUtilities


@available(iOS 14, *)
public class RNIContextMenuButtonModule: Module {
  
  public func definition() -> ModuleDefinition {
    Name("RNIContextMenuButton");
    
    Function("dismissMenu") { (reactTag: Int) in
      guard let bridge = RNIHelpers.bridge else { return };
    
      let contextMenuView = RNIHelpers.getView(
        forNode: reactTag as NSNumber,
        type: RNIContextMenuButton.self,
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
        type: RNIContextMenuButton.self,
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
        type: RNIContextMenuButton.self,
        bridge: bridge
      );
      
      guard let contextMenuView = contextMenuView else { return };
      contextMenuView.notifyOnJSComponentWillUnmount();
    };

    View(RNIContextMenuButton.self) {
      Events("onReactTagDidSet");
      Events("onMenuWillShow");
      Events("onMenuWillHide");
      Events("onMenuWillCancel");
      Events("onMenuDidShow");
      Events("onMenuDidHide");
      Events("onMenuDidCancel");
      Events("onPressMenuItem");
      Events("onRequestDeferredElement");
    
      Prop("menuConfig") { (view: RNIContextMenuButton, prop: Dictionary<String, Any>) in
        view.menuConfigRaw = prop;
      };
      
      Prop("isMenuPrimaryAction") { (view: RNIContextMenuButton, prop: Bool) in
        view.isMenuPrimaryAction = prop;
      };
      
      Prop("enableContextMenu") { (view: RNIContextMenuButton, prop: Bool) in
        view.enableContextMenu = prop;
      };
      
      Prop("internalCleanupMode") { (view: RNIContextMenuButton, prop: String) in
        view.internalCleanupModeRaw = prop;
      };
    };
  };
};
