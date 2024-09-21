//
//  RNIContextMenuViewContent+UIContextMenuInteractionDelegate+.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/10/23.
//

import UIKit
import React
import react_native_ios_utilities


@available(iOS 13, *)
extension RNIContextMenuViewContent: UIContextMenuInteractionDelegate {
  
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
    
    self.setDetachedViewsIfNeeded();
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      configurationForMenuAtLocation: location
    );
    
    // Note: Xcode beta + running on device (iPhone XR + iOS 15.1) causes
    // crashes when the context menu is being created
    return UIContextMenuConfiguration(
      identifier     : nil,
      previewProvider: self.createMenuPreview,
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
      self.menuAuxiliaryPreviewParent?.isUserInteractionEnabled = false;
      
      parentReactView.closestParentReactTouchHandler?.cancel();
      
      DispatchQueue.main.async {
        self.isUserInteractionEnabled = true;
        self.menuAuxiliaryPreviewParent?.isUserInteractionEnabled = true;
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
      self.menuAuxiliaryPreviewParent?.isUserInteractionEnabled = true;
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
  
  // context menu preview tapped
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionCommitAnimating
  ) {
    
    let preferredCommitStyle = self.previewConfig.preferredCommitStyle;
    
    self.isContextMenuVisible = false;
    animator.preferredCommitStyle = preferredCommitStyle;
    
    switch preferredCommitStyle {
      case .pop:
        self.dispatchEvent(
          for: .onMenuWillHide,
          withPayload: [:]
        );
        
        animator.addCompletion { [unowned self] in
          self.dispatchEvent(
            for: .onPressMenuPreview,
            withPayload: [:]
          );
          
          self.dispatchEvent(
            for: .onMenuDidHide,
            withPayload: [:]
          );
        };
      
      case .dismiss: fallthrough;
      @unknown default:
        self.dispatchEvent(
          for: .onMenuWillHide,
          withPayload: [:]
        );
        
        self.dispatchEvent(
          for: .onPressMenuPreview,
          withPayload: [:]
        );
        
        animator.addCompletion { [unowned self] in
          self.dispatchEvent(
            for: .onMenuDidHide,
            withPayload: [:]
          );
        };
    };
  };

  #if swift(>=5.7)
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configuration: UIContextMenuConfiguration,
    highlightPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {
    
    return self.menuTargetedPreview;
  };
  #else
  /// deprecated in iOS 16
  public func contextMenuInteraction(
    _ : UIContextMenuInteraction,
    previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
  
    return self.menuTargetedPreview;
  };
  #endif
  
  
  #if swift(>=5.7)
  public func contextMenuInteraction(
      _ interaction: UIContextMenuInteraction,
      configuration: UIContextMenuConfiguration,
      dismissalPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {
    
    return self.menuTargetedPreview;
  };
  #else
  /// deprecated in iOS 16
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForDismissingMenuWithConfiguration
    configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
    
    return self.menuTargetedPreview;
  };
  #endif
};
