//
//  RNIContextMenuViewController.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit;

class RNIContextMenuViewController: UIViewController {
  
  weak var parentVC: UIViewController?;
  
  var contextMenuView: RNIContextMenu? {
    self.view as? RNIContextMenu
  };
  
  // MARK: - Init
  // ------------
  
  init(contextMenuView: RNIContextMenu) {
    super.init(nibName: nil, bundle: nil);
    self.view = contextMenuView;
  };
  
  // loaded from a storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
  };
  
  // MARK: - Lifecycle
  // -----------------
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    guard let navVC = self.navigationController,
          let parentVC = self.parentVC
    else { return };
    
    // if parent VC still exist in the stack, then it hasn't been popped yet
    let isPopping = !navVC.viewControllers.contains(parentVC);
    
    print("viewDidDisappear...");
    
    if isPopping,
       let contextMenuView = self.contextMenuView {
      
      contextMenuView.detachFromParentVC();
      contextMenuView.notifyViewControllerDidPop(sender: self);
      
      print("pop...");
    };
  }
};
