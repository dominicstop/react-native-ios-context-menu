//
//  RNIContextMenuButtonContent+UIContextMenuInteractionDelegate+.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/10/23.
//

import UIKit
import React
import react_native_ios_utilities


@available(iOS 13, *)
extension RNIContextMenuButtonContent: UIContextMenuInteractionDelegate {
  
  // create context menu
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint
  ) -> UIContextMenuConfiguration? {
    
    guard self.isContextMenuEnabled else { return nil };
    
    self.dispatchEvent(
      for: .onMenuWillCreate,
      withPayload: [:]
    );
  
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      configurationForMenuAtLocation: location
    );
    
    // Note: Xcode beta + running on device (iPhone XR + iOS 15.1) causes
    // crashes when the context menu is being created
    return UIContextMenuConfiguration(
      identifier     : nil,
      previewProvider: nil,
      actionProvider : { [unowned self] _ in
        self.createMenu();
      }
    );
  };
  
  // context menu display begins
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willDisplayMenuFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    
    self.isContextMenuVisible = true;
    guard let animator = animator else { return };
    
    if self.shouldPreventLongPressGestureFromPropagating,
       let parentReactView = self.parentReactView as? RCTView
    {
      self.isUserInteractionEnabled = false;
      self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = false;
      
      parentReactView.closestParentReactTouchHandler?.cancel();
      
      DispatchQueue.main.async {
        self.isUserInteractionEnabled = true;
        self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = true;
      };
    };
    
    self.dispatchEvent(
      for: .onMenuWillShow,
      withPayload: [:]
    );
    
    self.setAuxiliaryPreviewConfigSizeIfNeeded();
    
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      willDisplayMenuFor: configuration,
      animator: animator
    );
    
    animator.addCompletion { [unowned self] in
      self.dispatchEvent(
        for: .onMenuDidShow,
        withPayload: [:]
      );
    };
  };
  
  // context menu display ends
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willEndFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {
    
    defer {
      // reset flag
      self.isContextMenuVisible = false;
      
      self.isUserInteractionEnabled = true;
      self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = true;
    };
    
    guard self.isContextMenuVisible else { return };
    
    self.dispatchEvent(
      for: .onMenuWillHide,
      withPayload: [:]
    );
    
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      willEndFor: configuration,
      animator: animator
    );
    
    if !self.didPressMenuItem {
      // nothing was selected...
      self.dispatchEvent(
        for: .onMenuWillCancel,
        withPayload: [:]
      );
    };
    
    animator?.addCompletion { [unowned self] in
      self.dispatchEvent(
        for: .onMenuDidHide,
        withPayload: [:]
      );
      
      if !self.didPressMenuItem {
        // nothing was selected...
        self.dispatchEvent(
          for: .onMenuDidCancel,
          withPayload: [:]
        );
      };
      
      // reset flag
      self.didPressMenuItem = false;
    };
  };
};
