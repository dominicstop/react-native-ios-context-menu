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

  // context menu highlight preview - controls the shape of the
  // open/close transition (e.g. preserves rounded corners during the morph).
  //
  // NOTE: never call super in these overrides - UIButton declares them
  // (which is what makes `override` compile), but does not implement them,
  // so calling super crashes with an unrecognized selector. Returning nil
  // tells UIKit to create the default targeted preview instead.
  #if swift(>=5.7)
  @available(iOS 16.0, *)
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configuration: UIContextMenuConfiguration,
    highlightPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {

    guard self.previewConfig.borderRadius != nil,
          self.window != nil
    else { return nil };

    return self.menuTargetedPreview;
  };
  #else
  /// deprecated in iOS 16
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {

    guard self.previewConfig.borderRadius != nil,
          self.window != nil
    else { return nil };

    return self.menuTargetedPreview;
  };
  #endif

  // NOTE: unlike the highlight method (where nil means "use the default
  // preview"), returning nil here makes the menu fade out in place instead
  // of morphing back into the button. Always return a preview targeting
  // the button, unless it left the window.
  #if swift(>=5.7)
  @available(iOS 16.0, *)
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configuration: UIContextMenuConfiguration,
    dismissalPreviewForItemWithIdentifier identifier: NSCopying
  ) -> UITargetedPreview? {

    guard self.window != nil else { return nil };

    guard self.previewConfig.borderRadius != nil else {
      return .init(view: self);
    };

    return self.menuTargetedPreview;
  };
  #else
  /// deprecated in iOS 16
  public override func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {

    guard self.window != nil else { return nil };

    guard self.previewConfig.borderRadius != nil else {
      return .init(view: self);
    };

    return self.menuTargetedPreview;
  };
  #endif
};
