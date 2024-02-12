//
//  DeinitializationObserverable+Default.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/12/24.
//

import Foundation
import DGSwiftUtilities


fileprivate struct AssociatedKeys {
  static var DeinitializationObserver: Void?;
};

public extension DeinitializationObserverable {

  var deinitObserver: DeinitializationObserver {
    get {
      let rawObject = withUnsafePointer(to: AssociatedKeys.DeinitializationObserver) {
        return objc_getAssociatedObject(self, $0);
      };
    
      if let rawObject = rawObject,
         let observer = rawObject as? DeinitializationObserver {
        
        return observer
      };
      
      let newObserver = DeinitializationObserver();
      self.deinitObserver = newObserver;
      
      return newObserver;
    }
    set {
      objc_setAssociatedObject(
        self,
        &AssociatedKeys.DeinitializationObserver,
        newValue,
        /// strong retain, so that the attached obj is deinit as the same time
        /// as the parent object
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      );
    }
  };
};
