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
    
    guard let animator = animator else { return };
    self.isContextMenuVisible = true;
    
    self.isUserInteractionEnabled = false;
    self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = false;
    
    self.onMenuWillShow.callAsFunction([:]);
    
    if self.shouldPreventLongPressGestureFromPropagating {
      self.closestParentReactTouchHandler?.cancel();
    };
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    let transitionEntranceDelay = self.auxiliaryPreviewConfig?
      .transitionEntranceDelay ?? .AFTER_PREVIEW;
    
    let shouldUseAlternateWayToShowAuxPreview =
      transitionEntranceDelay != .AFTER_PREVIEW;
    
    // A - show context menu auxiliary preview via new way
    // i.e. immediately show aux. preview but with a slight delay
    if shouldUseAlternateWayToShowAuxPreview {
      
      // the animator does not have a `percentComplete` - so this is just a guess
      // on how long the context menu entrance animation is
      //
      // Note: will break if slow animations enabled
      let delay = transitionEntranceDelay.seconds;
      
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
        self?.attachContextMenuAuxiliaryPreviewIfAny(nil);
      };
    };
    
    animator.addCompletion { [unowned self] in
    
      self.isUserInteractionEnabled = true;
      self.menuAuxiliaryPreviewView?.isUserInteractionEnabled = true;
      
      self.onMenuDidShow.callAsFunction([:]);
      
      // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
      // B - show context menu auxiliary preview via old way
      // i.e. wait for context menu preview to become visible before showing
      // the aux. preview.
      if !shouldUseAlternateWayToShowAuxPreview {
        self.attachContextMenuAuxiliaryPreviewIfAny(animator);
      };
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
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    // hide preview auxiliary view
    self.detachContextMenuAuxiliaryPreviewIfAny(animator);

    self.onMenuWillHide.callAsFunction([:]);
    
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
    
    // MARK: Experimental - "Auxiliary Context Menu Preview"-Related
    // hide preview auxiliary view
    self.detachContextMenuAuxiliaryPreviewIfAny(animator);
    
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
    
    return self.makeTargetedPreview();
  };
  #else
  /// deprecated in iOS 16
  public func contextMenuInteraction(
    _ : UIContextMenuInteraction,
    previewForHighlightingMenuWithConfiguration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
  
    return self.makeTargetedPreview();
  };
  #endif
  
  
  #if swift(>=5.7)
  public func contextMenuInteraction(
      _ interaction: UIContextMenuInteraction,
      configuration: UIContextMenuConfiguration,
      dismissalPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
  #else
  /// deprecated in iOS 16
  public func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForDismissingMenuWithConfiguration
    configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
    
    return self.makeTargetedPreview();
  };
  #endif
};
