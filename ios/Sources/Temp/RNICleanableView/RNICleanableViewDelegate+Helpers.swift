//
//  RNICleanableViewDelegate+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import React
import DGSwiftUtilities


public extension RNICleanableViewDelegate {

  var associatedCleanableViewItem: RNICleanableViewItem? {
    get {
      RNICleanableViewRegistry.shared.getEntry(forKey: self.viewCleanupKey);
    }
  };
  
  var viewsToCleanup: Array<WeakRef<UIView>>? {
    self.associatedCleanableViewItem?.viewsToCleanup;
  };
  
  func cleanupOrphanedViews(){
    guard let cleanableViewItem = self.associatedCleanableViewItem,
          let viewsToCleanup = self.viewsToCleanup
    else { return };
    
    let purged = viewsToCleanup.compactMap {
      $0.ref;
    };
    
    let filtered = purged.filter {
      let isActive = $0.superview != nil && $0.window != nil;
      let isDelegate = $0 === cleanableViewItem.delegate
      
      return !isActive && !isDelegate;
    };
    
    var cleanableViewItems: [RNICleanableViewItem] = [];
    var viewsToClean: [UIView] = [];
    
    filtered.forEach {
      if let reactTag = $0.reactTag?.intValue,
         let match = RNICleanableViewRegistryShared.getEntry(forKey: reactTag) {
         
        cleanableViewItems.append(match);
        
      } else {
        viewsToClean.append($0);
      };
    };
    
    cleanableViewItems.forEach {
      try? RNICleanableViewRegistryShared.notifyCleanup(
        forKey: $0.key,
        sender: .cleanableViewDelegate(self),
        shouldForceCleanup: true
      );
    };
    
    try? RNICleanableViewRegistryShared._cleanup(views: viewsToClean)
  };
};
