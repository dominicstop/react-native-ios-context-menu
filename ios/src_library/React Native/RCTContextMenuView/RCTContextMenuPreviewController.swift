//
//  RCTContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


class RCTContextMenuPreviewController: UIViewController {
  
  var isResizeAnimated = true;
  
  var reactView: UIView?;
  var boundsDidChangeBlock: ((CGRect) -> Void)?;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    if let reactView = self.reactView {
      self.view.addSubview(reactView);
      //boundsDidChangeBlock?(self.view.bounds);
    };
  };
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews();
    
    guard let reactView = self.view.subviews.first else { return };
    
    if self.isResizeAnimated {
      UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
        self.preferredContentSize = reactView.frame.size;
      };
      
    } else {
      self.preferredContentSize = reactView.frame.size;
    };
  };
};
