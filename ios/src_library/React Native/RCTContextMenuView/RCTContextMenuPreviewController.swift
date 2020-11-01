//
//  RCTContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;

class RCTContextMenuPreviewController: UIViewController {
  
  var reactView: UIView?;
  var boundsDidChangeBlock: ((CGRect) -> Void)?;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    // setup vc's view
    self.view = {
      let view = UIView();
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
      return view;
    }();
    
    if let reactView = self.reactView {
      self.view.addSubview(reactView);
      boundsDidChangeBlock?(self.view.bounds);
    };
  };
  
  override func viewDidLayoutSubviews(){
    super.viewDidLayoutSubviews();
    boundsDidChangeBlock?(self.view.bounds);
  };
};
