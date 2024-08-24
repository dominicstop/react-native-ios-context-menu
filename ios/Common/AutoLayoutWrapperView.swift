//
//  AutoLayoutWrapperView.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/19/23.
//

import UIKit
import ReactNativeIosUtilities

class AutoLayoutWrapperView: UIView {

  public override var frame: CGRect {
    willSet {
      self.updateSizeOfSubviews(newSize: newValue.size);
    }
  };

  override func addSubview(_ view: UIView) {
    if let detachedView = view as? RNIDetachedView {
      try? detachedView.updateBounds(newSize: self.bounds.size);
    };
    
    super.addSubview(view);
  }
  
  override func layoutSubviews() {
    super.layoutSubviews();
    self.updateSizeOfSubviews();
  };
  
  override func updateConstraints() {
    super.updateConstraints();
    self.updateSizeOfSubviews();
  };
  
  func updateSizeOfSubviews(newSize: CGSize? = nil){
    self.subviews.forEach {
      guard let detachedView = $0 as? RNIDetachedView else { return };
      try? detachedView.updateBounds(newSize: newSize ?? self.bounds.size);
    };
  };
};
