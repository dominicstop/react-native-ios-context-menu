//
//  UIGestureRecognizer+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/2/23.
//

import UIKit

// TODO: Move to `DGSwiftUtilities`
extension UIGestureRecognizer {
  
  func cancelTouch(){
    self.isEnabled.toggle();
    self.isEnabled.toggle();
  };
};
