//
//  RNIContextMenuView+RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import ReactNativeIosUtilities



extension RNIContextMenuView: RNICleanableViewDelegate {
  
  public func notifyOnViewCleanupRequest(
    sender: RNICleanableViewSenderType,
    item: RNICleanableViewItem
  ) -> Bool {
  
    let isViewInactive = self.superview == nil || self.window == nil;
    guard isViewInactive else { return false };
    
    let shouldTriggerCleanup =
         !self.viewCleanupMode.isDisabled
      && !self._didTriggerCleanup;
    
    guard shouldTriggerCleanup else { return false };
    return true;
  };
  
  public func notifyOnViewCleanupWillBegin(){
    self.contextMenuInteraction?.dismissMenu();
    self.contextMenuInteraction = nil;
    
    if let viewController = self.viewController {
      self.detachFromParentVCIfAny();
      
      viewController.view = nil;
      self.viewController = nil
    };
  };
  
  public func notifyOnViewCleanupCompletion() {
    self._didTriggerCleanup = true;
    
    // remove deferred handlers
    self._deferredElementCompletionMap.removeAll();
    
    self.menuCustomPreviewView = nil;
    self.previewController = nil;
    self.menuAuxiliaryPreviewView = nil;
    self.detachedViews = [];
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
};
