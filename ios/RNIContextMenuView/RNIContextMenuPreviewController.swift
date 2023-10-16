//
//  RNIContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;
import ExpoModulesCore
import ReactNativeIosUtilities


@available(iOS 13.0, *)
class RNIContextMenuPreviewController: UIViewController {
  
  var previewConfig = PreviewConfig();
  
  weak var menuCustomPreviewView: RNIDetachedView?;
    
  /// Shorthand for the preview view's size/dimensions.
  var previewSize: CGSize? {
    self.menuCustomPreviewView?.frame.size;
  };
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.view = {
      let view = UIView();
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      view.backgroundColor = .clear;
      
      return view;
    }();
    
    if let previewView = self.menuCustomPreviewView {
      self.view.addSubview(previewView);
    };
  };
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews();

    switch self.previewConfig.previewSize {
      case .STRETCH:
        guard let menuCustomPreviewView = self.menuCustomPreviewView else { return };
        
        menuCustomPreviewView.updateBounds(newSize: self.view.bounds.size);
        self.preferredContentSize = .zero;
        
      case .INHERIT:
        guard let previewSize = self.previewSize else { return };
        
        if self.previewConfig.isResizeAnimated {
          UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.preferredContentSize = previewSize;
          };
          
        } else {
          self.preferredContentSize = previewSize;
        };
    };
  };
};
