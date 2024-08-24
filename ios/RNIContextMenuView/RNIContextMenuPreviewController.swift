//
//  RNIContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//

import UIKit;
import react_native_ios_utilities


@available(iOS 13.0, *)
class RNIContextMenuPreviewController: UIViewController {

  // MARK: - Properties
  // ------------------

  public weak var contextMenuView: RNIContextMenuViewContent?;
  
  // MARK: - Computed Properties
  // ---------------------------
  
  var previewConfig: RNIMenuPreviewConfig? {
    self.contextMenuView?.previewConfig;
  };
  
  // TODO: WIP - To be impl.
  weak var menuCustomPreviewView: /* RNIDetachedView */ UIView? {
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
        
        // TODO: WIP - To be impl.
        // try? menuCustomPreviewView.updateBounds(newSize: self.view.bounds.size);
        
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
