//
//  RNIViewCleanupMode+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/11/24.
//

import Foundation



public extension RNIViewCleanupMode {
  
  func shouldAttachToParentController(
    forView view: UIView?,
    associatedViewController viewController: UIViewController?,
    currentWindow window: UIWindow?
  ) -> Bool {
  
    guard case let .enabled(triggers) = self else { return false };
    
    let didMoveToNilWindow = window == nil;
    let isViewAttachedToViewController = viewController?.view === view;
    
    let isViewControllerAttachedToParent =
      isViewAttachedToViewController && viewController?.parent != nil;
    
    /// A. Not attached to a parent VC yet
    /// B. Moving to a non-nil window
    /// C. View cleanup trigger `.viewControllerLifecycle` enabled
    ///
    /// the VC attached to this view is possibly being attached as a child
    /// view controller to a view controller managed by
    /// `UINavigationController`...
    ///
    return (
         !isViewControllerAttachedToParent
      && !didMoveToNilWindow
      && triggers.contains(.viewControllerLifecycle)
    );
  };
  
  func shouldTriggerCleanupForDidMoveToWindow(
    forView view: UIView?,
    associatedViewController viewController: UIViewController?,
    currentWindow window: UIWindow?
  ) -> Bool {
  
    guard case let .enabled(triggers) = self else { return false };
    let hasWindow = window != nil;
    let hasSuperview = view?.superview != nil;
    
    let isViewActive = hasWindow && hasSuperview;

    let shouldAttachToParentController = self.shouldAttachToParentController(
      forView: view,
      associatedViewController: viewController,
      currentWindow: window
    );
    
    /// A. view: nil window + no superview
    /// B. Not being attached to a parent VC
    /// D. Cleanup mode is set to: `didMoveToWindowNil`
    ///
    /// Moving to nil window and not attached to parent vc, possible end of
    /// lifecycle for this view...
    ///
    return (
         !isViewActive
      && !shouldAttachToParentController
      && triggers.contains(.didMoveToNilWindow)
    );
  };
};
