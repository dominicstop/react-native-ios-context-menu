//
//  RNIContextMenuView+UIGestureRecognizerDelegate.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/2/23.
//

import Foundation

extension RNIContextMenuView: UIGestureRecognizerDelegate {
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    
    guard let longPressGestureRecognizer = self.longPressGestureRecognizer,
    
          gestureRecognizer === longPressGestureRecognizer,
          otherGestureRecognizer !== longPressGestureRecognizer
    else {
      return true;
    };
    
    let cancelOtherGesture = {
      otherGestureRecognizer.isEnabled.toggle();
      otherGestureRecognizer.isEnabled.toggle();
    };
    
    cancelOtherGesture();
    return false;
  };
};
