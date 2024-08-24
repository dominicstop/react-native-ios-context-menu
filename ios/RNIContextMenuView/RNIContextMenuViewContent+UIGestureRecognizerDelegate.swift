//
//  RNIContextMenuViewContent+UIGestureRecognizerDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/2/23.
//

import Foundation
import DGSwiftUtilities


extension RNIContextMenuViewContent: UIGestureRecognizerDelegate {
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    
    guard self.isContextMenuVisible,
          self.shouldPreventLongPressGestureFromPropagating,
          let longPressGestureRecognizer = self.longPressGestureRecognizer,
    
          gestureRecognizer === longPressGestureRecognizer,
          otherGestureRecognizer is UILongPressGestureRecognizer,
          otherGestureRecognizer !== longPressGestureRecognizer
    else {
      return true;
    };
    
    otherGestureRecognizer.cancelTouch();
    return false;
  };
};
