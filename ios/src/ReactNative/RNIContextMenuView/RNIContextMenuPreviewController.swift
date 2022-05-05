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
  
  var previewSize: CGSize? {
    self.previewWrapper?.reactContent?.frame.size;
  };
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.view = {
      let view = UIView();
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      view.backgroundColor = .clear;
      
      return view;
    }();
    
    if let previewView = self.previewWrapper?.reactContent {
      self.view.addSubview(previewView);
    };
  };
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews();

    switch self.previewConfig.previewSize {
      case .STRETCH:
        self.previewWrapper?
          .notifyForBoundsChange(size: self.view.bounds.size);
        
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
