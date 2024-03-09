//
//  RNIContextMenuView+UIContextMenuInteractionDelegate+.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/10/23.
//

import UIKit
import ExpoModulesCore


@available(iOS 13, *)
extension RNIContextMenuView: UIContextMenuInteractionDelegate {
  
  // create context menu
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint
  ) -> UIContextMenuConfiguration? {
    
    guard self.isContextMenuEnabled else { return nil };
  
    self.onMenuWillCreate.callAsFunction([:]);
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
    
    if self.shouldPreventLongPressGestureFromPropagating {
      self.isUserInteractionEnabled = false;
      self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = false;
      
      self.closestParentReactTouchHandler?.cancel();
      
      DispatchQueue.main.async {
        self.isUserInteractionEnabled = true;
        self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = true;
      };
    };
    
    self.onMenuWillShow.callAsFunction([:]);
    self.setAuxiliaryPreviewConfigSizeIfNeeded();
    
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      willDisplayMenuFor: configuration,
      animator: animator
    );
    
    animator.addCompletion { [unowned self] in
      self.onMenuDidShow.callAsFunction([:]);
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
    
    self.onMenuWillHide.callAsFunction([:]);
    
    self.contextMenuManager?.notifyOnContextMenuInteraction(
      interaction,
      willEndFor: configuration,
      animator: animator
    );
    
    if !self.didPressMenuItem {
      // nothing was selected...
      self.onMenuWillCancel.callAsFunction([:]);
    };
    
    animator?.addCompletion { [unowned self] in
      self.onMenuDidHide.callAsFunction([:]);
      
      if !self.didPressMenuItem {
        // nothing was selected...
        self.onMenuDidCancel.callAsFunction([:]);
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
        self.onMenuWillHide.callAsFunction([:]);
        
        animator.addCompletion { [unowned self] in
          self.onPressMenuPreview.callAsFunction([:]);
          self.onMenuDidHide.callAsFunction([:]);
        };
      
      case .dismiss: fallthrough;
      @unknown default:
        self.onMenuWillHide.callAsFunction([:]);
        self.onPressMenuPreview.callAsFunction([:]);
        
        animator.addCompletion { [unowned self] in
          self.onMenuDidHide.callAsFunction([:]);
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
