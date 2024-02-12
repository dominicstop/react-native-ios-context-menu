//
//  RNIContextMenuButton+RNICleanableViewDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/12/24.
//

import UIKit
import ReactNativeIosUtilities

extension RNIContextMenuButton: RNICleanableViewDelegate {
  
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
    if #available(iOS 14.0, *) {
      self.button?.contextMenuInteraction?.dismissMenu();
    };
    
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
        
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
};
