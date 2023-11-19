//
//  AutoLayoutWrapperView.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/19/23.
//

import UIKit
import ReactNativeIosUtilities

class AutoLayoutWrapperView: UIView {
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    self.subviews.forEach {
      guard let detachedView = $0 as? RNIDetachedView else { return };
      detachedView.updateBounds(newSize: self.bounds.size);
    };
  };
  
  override func updateConstraints() {
    super.updateConstraints();
    
    self.subviews.forEach {
      guard let detachedView = $0 as? RNIDetachedView else { return };
      detachedView.updateBounds(newSize: self.bounds.size);
    };
  }
};
