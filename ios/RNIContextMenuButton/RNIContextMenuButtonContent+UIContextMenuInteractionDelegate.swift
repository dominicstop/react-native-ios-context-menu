//
//  RNIContextMenuButtonContent+UIContextMenuInteractionDelegate+.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/10/23.
//

import UIKit
import React
import react_native_ios_utilities


@available(iOS 13, *)
extension RNIContextMenuButtonContent {

  /// Walks up the view hierarchy to find the React touch handler gesture
  /// recognizer. Supports both old arch (`RCTTouchHandler`) and new arch
  /// / Fabric (`RCTSurfaceTouchHandler`) by matching the class name.
  private func findReactTouchHandler() -> UIGestureRecognizer? {
    // Try the old-arch helper first
    if let parentReactView = self.parentReactView as? RCTView,
       let handler = parentReactView.closestParentReactTouchHandler
    {
      return handler;
    };

    // Fallback: walk the view hierarchy and match by class name
    var currentView: UIView? = self;
    while let view = currentView {
      if let match = view.gestureRecognizers?.first(where: {
        let className = NSStringFromClass(type(of: $0));
        return className.contains("TouchHandler");
      }) {
        return match;
      };
      currentView = view.superview;
    };

    return nil;
  };

  // context menu display begins
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willDisplayMenuFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {

    self.isContextMenuVisible = true;

    // Disable the React touch handler for the entire lifetime of the
    // context menu. This prevents the dismiss tap from leaking through
    // to views behind the menu (e.g. selecting a row in a list).
    // The touch handler is re-enabled in `willEndFor`'s animator
    // completion, after the dismiss animation finishes.
    if let touchHandler = self.findReactTouchHandler() {
      touchHandler.isEnabled = false;
      self._disabledTouchHandler = touchHandler;
    };

    guard let animator = animator else { return };

    self.dispatchEvent(
      for: .onMenuWillShow,
      withPayload: [:]
    );

    animator.addCompletion { [unowned self] in
      self.dispatchEvent(
        for: .onMenuDidShow,
        withPayload: [:]
      );
    };
  };

  // context menu display ends
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    willEndFor configuration: UIContextMenuConfiguration,
    animator: UIContextMenuInteractionAnimating?
  ) {

    defer {
      // reset flag
      self.isContextMenuVisible = false;
      self.isUserInteractionEnabled = true;
    };

    guard self.isContextMenuVisible else { return };

    self.dispatchEvent(
      for: .onMenuWillHide,
      withPayload: [:]
    );

    if !self.didPressMenuItem {
      // nothing was selected...
      self.dispatchEvent(
        for: .onMenuWillCancel,
        withPayload: [:]
      );
    };

    animator?.addCompletion { [unowned self] in
      // Re-enable the React touch handler that was disabled in
      // `willDisplayMenuFor`
      self._disabledTouchHandler?.isEnabled = true;
      self._disabledTouchHandler = nil;

      self.dispatchEvent(
        for: .onMenuDidHide,
        withPayload: [:]
      );

      if !self.didPressMenuItem {
        // nothing was selected...
        self.dispatchEvent(
          for: .onMenuDidCancel,
          withPayload: [:]
        );
      };

      // reset flag
      self.didPressMenuItem = false;
    };
  };
};
