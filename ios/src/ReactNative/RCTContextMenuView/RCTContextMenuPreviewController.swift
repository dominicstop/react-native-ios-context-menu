//
//  RCTContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 13.0, *)
class RCTContextMenuPreviewController: UIViewController {
  
  var previewConfig = PreviewConfig();
  
  var reactView: UIView?;
  var boundsDidChangeBlock: ((CGRect) -> Void)?;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.view = {
      let view = UIView();
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      view.backgroundColor = .clear;
      
      return view;
    }();
    
    if let reactView = self.reactView {
      self.view.addSubview(reactView);
    };
  };
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews();

    switch self.previewConfig.previewSize {
      case .STRETCH:
        self.boundsDidChangeBlock?(self.view.bounds);
        self.preferredContentSize = CGSize(width: 0, height: 0);
        
      case .INHERIT:
        guard let previewSize = self.getPreviewSize() else { return };
        
        if self.previewConfig.isResizeAnimated {
          UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.preferredContentSize = previewSize;
          };
          
        } else {
          self.preferredContentSize = previewSize;
        };
    };
  };
  
  /// get the menu preview size
  private func getPreviewSize() -> CGSize? {
    guard let frame = self.reactView?.subviews.first?.frame else { return nil };
    return CGSize(width: frame.size.width, height: frame.size.height);
  };
};
