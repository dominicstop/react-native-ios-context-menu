//
//  RNIContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 13.0, *)
class RNIContextMenuPreviewController: UIViewController {
  
  var previewConfig = PreviewConfig();
  
  weak var previewWrapper: RNIWrapperView?;
  
  /// Shorthand to get the "preview view" that we want to display in the context menu preview.
  ///
  /// Note: This is the view that we received from JS side via `RNIWrapperView`.
  /// The wrapper view  is set o "dummy view mode".
  var reactPreviewView: UIView? {
    self.previewWrapper?.reactViews.first
  };
  
  /// Shorthand for the preview view's size/dimensions.
  var previewSize: CGSize? {
    self.reactPreviewView?.frame.size;
  };
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.view = {
      let view = UIView();
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      view.backgroundColor = .clear;
      
      return view;
    }();
    
    if let previewView = self.reactPreviewView {
      self.view.addSubview(previewView);
    };
  };
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews();

    switch self.previewConfig.previewSize {
      case .STRETCH:
        guard let previewWrapper = self.previewWrapper else { return };
        
        previewWrapper.notifyForBoundsChange(size: self.view.bounds.size);
        self.preferredContentSize = CGSize(width: 0, height: 0);
        
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
