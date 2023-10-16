//
//  RNIContextMenuButton+UIContextMenuInteractionDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/11/23.
//

import UIKit;
import ExpoModulesCore;
import ReactNativeIosUtilities;

@available(iOS 14, *)
extension RNIContextMenuButton {
  
  // context menu display begins
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willDisplayMenuFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {

    self.isContextMenuVisible = true;
    self.onMenuWillShow.callAsFunction([:]);
    
    animator?.addCompletion { [unowned self] in
      self.onMenuDidShow.callAsFunction([:]);
    };
  };
  
  // context menu display ends
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willEndFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    
    guard self.isContextMenuVisible else { return };
    
    self.onMenuWillHide.callAsFunction([:]);
    if !self.didPressMenuItem {
      self.onMenuWillCancel.callAsFunction([:]);
    };
    
    animator?.addCompletion { [unowned self] in
      if !self.didPressMenuItem {
        self.onMenuDidCancel.callAsFunction([:]);
      };
      
      self.onMenuDidHide.callAsFunction([:]);
      self.didPressMenuItem = false;
    };
    
    self.isContextMenuVisible = false;
  };
};
