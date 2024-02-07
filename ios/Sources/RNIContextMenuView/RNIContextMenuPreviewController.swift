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

  // MARK: - Properties
  // ------------------

  public weak var contextMenuView: RNIContextMenuView?;
  
  // MARK: - Computed Properties
  // ---------------------------
  
  var previewConfig: RNIMenuPreviewConfig? {
    self.contextMenuView?.previewConfig;
  };
  
  weak var menuCustomPreviewView: RNIDetachedView? {
    self.contextMenuView?.menuCustomPreviewView;
  };
    
  /// Shorthand for the preview view's size/dimensions.
  var previewSize: CGSize? {
    self.menuCustomPreviewView?.frame.size;
  };
  
  // MARK: - Functions - VC Lifecycle
  // --------------------------------
  
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
    
    guard let previewConfig = self.previewConfig else { return };

    switch previewConfig.previewSize {
      case .STRETCH:
        guard let menuCustomPreviewView = self.menuCustomPreviewView else { return };
        
        try? menuCustomPreviewView.updateBounds(newSize: self.view.bounds.size);
        self.preferredContentSize = .zero;
        
      case .INHERIT:
        guard let previewSize = self.previewSize else { return };
        
        if previewConfig.isResizeAnimated {
          UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.preferredContentSize = previewSize;
          };
          
        } else {
          self.preferredContentSize = previewSize;
        };
    };
  };
};
