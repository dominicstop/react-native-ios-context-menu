//
//  RNIWrapperView.swift
//  IosNavigatorExample
//
//  Created by Dominic Go on 2/1/21.
//

import UIKit

@objc protocol RNIWrapperViewDelegate: AnyObject {
  @objc optional func onJSComponentWillUnmount(sender: RNIWrapperView, isManuallyTriggered: Bool);
};

/// Holds react views that have been detached, and are no longer managed by RN.
internal class RNIWrapperView: UIView {
  
  var bridge: RCTBridge!;
  var reactContent: UIView?;
  
  weak var delegate: RNIWrapperViewDelegate?;
  
  /// Whether or not `cleanup` was triggered.
  private(set) var didTriggerCleanup = false;
  
  /// This property determines whether `cleanup` should be called when
  /// `shouldNotifyComponentWillUnmount` is called. Defaults to: `true`.
  ///
  /// When `shouldNotifyComponentWillUnmount` prop is true, the JS component
  /// will notify it's corresponding native view that it'll be unmounted (i.e.
  /// via calling the `shouldNotifyComponentWillUnmount` method).
  ///
  /// * When a react view is "detached" (i.e. when `removeFromSuperView` is called),
  ///   the react view is on it's own (the view will leak since it won't be removed
  ///   when the corresponding view comp. un-mounts).
  ///
  /// * To get around this, the js comp. notifies the native view that it's
  ///   going to be unmount in `componentWillUnmount` react lifecycle.
  ///
  /// * This also fixes the issue where the js comp. has already been unmounted,
  ///   but it's corresponding native view is still being used.
  ///
  var autoCleanupOnJSUnmount = true;
  
  /// Determines whether `cleanup` is called when this view is removed from the
  /// view hierarchy (i.e. when the window ref. becomes nil).
  var autoCleanupOnWindowNil = false;
  
  /// Determines whether `layoutSubviews` will automatically trigger
  /// `notifyForBoundsChange`. Defaults to `true`.
  ///
  /// * If the layout size is determined from the react/js side, set this to `false`.
  /// * Otherwise if the layout size is determined from the native side (e.g. via
  ///   the view controller, etc.) then set this to `true`.
  var autoSetSizeOnLayout = true;
  
  /// Set this property to `true` before moving this view somewhere else (i.e.
  /// before calling `removeFromSuperView`).
  ///
  /// Setting this property to `true` will prevent triggering `cleanup` for the
  /// first time when removing this view from it's `superview`.
  ///
  /// After you've finished moving this view, set this back to `false`.
  var willChangeSuperview = false;
  
  private var didChangeSuperview = false;
  private var touchHandler: RCTTouchHandler!;
  
  // MARK: - RN Exported Props
  // ------------------------
  
  /// When this prop is set to `true`, the JS component will trigger
  /// `shouldNotifyComponentWillUnmount` during `componentWillUnmount`.
  @objc var shouldNotifyComponentWillUnmount: Bool = false;
  
  // MARK: - Init/Lifecycle
  // ---------------------
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    
    self.bridge = bridge;
    self.touchHandler = RCTTouchHandler(bridge: self.bridge);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    if self.autoSetSizeOnLayout {
      self.notifyForBoundsChange(self.bounds);
    };
  };
  
  override func didMoveToWindow() {
    
    /// Prevent `cleanup` during the first move (i.e. when the view is detached
    /// for the 1st time).
    /// * if `willChangeSuperview` is true, don't allow cleanup until
    ///   `didChangeSuperview` is also true.
    ///
    /// * Otherwise, if `willChangeSuperview` is false, allow cleanup.
    let triggerCleanup = self.willChangeSuperview ? self.didChangeSuperview : true;
    
    if self.window == nil, self.autoCleanupOnWindowNil, triggerCleanup {
      self.cleanup();
    };
    
    if self.window == nil, self.willChangeSuperview {
      // * The view has been moved to another parent
      // * the next time this view is removed, it will trigger cleanup
      self.didChangeSuperview = true;
    };
  };
  
  // MARK: - React Lifecycle
  // ----------------------
  
  override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    super.insertSubview(subview, at: atIndex);
    
    self.reactContent = subview;
    self.touchHandler.attach(to: subview);
  };
  
  // MARK: - Internal Functions
  // -------------------------
  
  func notifyForBoundsChange(_ newBounds: CGRect){
    guard let bridge = self.bridge,
          let reactContent = self.reactContent
    else { return };
    
    //bridge.uiManager.setSize(newBounds.size, for: reactContent);
    bridge.uiManager.setSize(newBounds.size, for: self);
  };
  
  func cleanup(){
    guard !self.didTriggerCleanup else { return };
    self.didTriggerCleanup = true;
    
    self.touchHandler.detach(from: self.reactContent);
    
    RNIUtilities.recursivelyRemoveFromViewRegistry(
      bridge: self.bridge,
      reactView: self
    );
  };
  
  // MARK: - Commands For Module
  // --------------------------
  
  /// Called by `RNIWrapperViewModule.notifyComponentWillUnmount`
  func onJSComponentWillUnmount(isManuallyTriggered: Bool){    
    if self.autoCleanupOnJSUnmount {
      self.cleanup();
    };
    
    self.delegate?.onJSComponentWillUnmount?(
      sender: self,
      isManuallyTriggered: isManuallyTriggered
    );
  };
};
