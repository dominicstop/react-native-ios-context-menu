//
//  RNIContextMenuViewController.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit;


// TODO: Rename to
// * RNINavigationEventsReportingChildViewController
// * RNINavigationEventsChildViewController
// * Protocol: RNINavigationEventsNotifiable
// Move: - attach vc code here
// this is used to listen to view controller lifecycle events e.g. navigation
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
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated);
    
    guard let navVC = self.navigationController,
          let parentVC = self.parentVC
    else { return };
    
    // if parent VC still exist in the stack, then it hasn't been popped yet
    let isParentVCPopped = { !navVC.viewControllers.contains(parentVC) };
    
    guard isParentVCPopped(),
          let contextMenuView = self.contextMenuView
    else { return };

    let cleanup = {
      contextMenuView.detachFromParentVC();
      contextMenuView.notifyViewControllerDidPop(sender: self);
    };
    
    if animated,
       let transitionCoordinator = parentVC.transitionCoordinator {
      
      transitionCoordinator.animate(alongsideTransition: nil){ _ in
        guard isParentVCPopped() else { return };
        cleanup();
      };
      
    } else {
      cleanup();
    };
  };
};
