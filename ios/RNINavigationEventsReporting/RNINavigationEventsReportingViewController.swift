//
//  RNINavigationEventsReportingViewController.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit;


/// When added as a child VC, it will listen to the parent VC + navigation controller  for navigation events
/// and report them to it's delegate and root view.
class RNINavigationEventsReportingViewController: UIViewController {
  
  weak var parentVC: UIViewController?;
  weak var delegate: RNINavigationEventsNotifiable?;
  
  // MARK: - Init
  // ------------
  
  init() {
    super.init(nibName: nil, bundle: nil);
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
    
    // if parent VC still exist in the stack,
    // then it hasn't been popped yet...
    let isParentVCPopped = {
      !navVC.viewControllers.contains(parentVC)
    };
    
    guard isParentVCPopped()
    else { return };

    let notifyDelegate = {
      self.delegate?.notifyViewControllerDidPop(sender: self);
    };
    
    if animated,
       let transitionCoordinator = parentVC.transitionCoordinator {
      
      transitionCoordinator.animate(alongsideTransition: nil){ _ in
        guard isParentVCPopped() else { return };
        notifyDelegate();
      };
      
    } else {
      notifyDelegate();
    };
  };
};
