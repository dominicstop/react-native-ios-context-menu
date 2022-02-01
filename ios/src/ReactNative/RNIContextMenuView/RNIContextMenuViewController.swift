//
//  RNIContextMenuViewController.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 1/30/22.
//

import UIKit;

class RNIContextMenuViewController: UIViewController {
  
  weak var parentVC: UIViewController?;
  
  @available(iOS 13, *)
  var contextMenuView: RNIContextMenuView? {
    self.view as? RNIContextMenuView
  };
  
  // MARK: - Init
  // ------------
  
  @available(iOS 13, *)
  init(contextMenuView: RNIContextMenuView) {
    super.init(nibName: nil, bundle: nil);
    self.view = contextMenuView;
  };
  
  // loaded from a storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
  };
  
  // MARK: - Lifecycle
  // -----------------
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    guard let navVC = self.navigationController,
          let parentVC = self.parentVC
    else { return };
    
    // if parent VC still exist in the stack, then it hasn't been popped yet
    let isPopping = !navVC.viewControllers.contains(parentVC);
    
    print("viewDidDisappear...");
    
    if isPopping,
       #available(iOS 13, *),
       let contextMenuView = self.contextMenuView {
      
      contextMenuView.notifyViewControllerDidPop();
      
      print("pop...");
    };
  }
};
