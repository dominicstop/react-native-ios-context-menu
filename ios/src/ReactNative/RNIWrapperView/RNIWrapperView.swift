//
//  RNIWrapperView.swift
//  IosNavigatorExample
//
//  Created by Dominic Go on 2/1/21.
//

import UIKit


// TODO: Re-Write
/// Holds react views that have been detached, and are no longer managed by RN.
internal class RNIWrapperView: UIView {
  
  // MARK: - Properties
  // ------------------
  
  var bridge: RCTBridge!;
  var reactContent: UIView?;
  
  weak var delegate: RNIWrapperViewEventsNotifiable?;
  
  private var touchHandler: RCTTouchHandler!;
  
  // MARK: - Properties - Flags
  // ------------------
  
  /// Whether or not `cleanup` was triggered.
  private(set) var didTriggerCleanup = false;
  
  /// Set this property to `true` before moving this view somewhere else (i.e.
  /// before calling `removeFromSuperView`).
  ///
  /// Setting this property to `true` will prevent triggering `cleanup` when removing this view
  /// from it's  parent view...
  ///
  /// After you've finished moving this view, set this back to `false`.
  var isMovingToParent = false;
  
  // MARK: - Properties - Config-Related
  // ------------------
    
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
  var shouldAutoCleanupOnJSUnmount = true;
      
  /// Determines whether `cleanup` is called when this view is removed from the
  /// view hierarchy (i.e. when the window ref. becomes nil).
  var shouldAutoCleanupOnWindowNil = false;
  
  /// Determines whether `layoutSubviews` will automatically trigger
  /// `notifyForBoundsChange`. Defaults to `true`.
  ///
  /// * If the layout size is determined from the react/js side, set this to `false`.
  ///
  /// * Otherwise if the layout size is determined from the native side (e.g. via
  ///   the view controller, etc.) then set this to `true`.
  var shouldAutoSetSizeOnLayout = true;
  
  // MARK: - RN Exported Props
  // -------------------------
  
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
    
    if self.shouldAutoSetSizeOnLayout {
      self.notifyForBoundsChange(size: self.bounds.size);
    };
  };
  
  override func didMoveToWindow() {
    
    let isMovingToWindowNil = self.window == nil;
    
    let isViewOrphaned =
      self.superview == nil && self.reactContent?.superview == nil;
    
    /// A: Prevent `cleanup` when changing parent views
    /// B: Only trigger cleanup when moving to a `nil` window
    /// C: Only trigger cleanup if view is orphaned
    let shouldTriggerCleanup =
         !self.isMovingToParent
      && isMovingToWindowNil
      && isViewOrphaned;
    
    if shouldTriggerCleanup {
      self.cleanup();
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
  // --------------------------
  
  func notifyForBoundsChange(size: CGSize){
    guard let bridge = self.bridge else { return };
    
    bridge.uiManager.setSize(size, for: self);
    
    if let reactContent = self.reactContent {
      bridge.uiManager.setSize(size, for: reactContent);
    };
  };
  
  func notifyForBoundsChangeForWrapper(size: CGSize){
    guard let bridge = self.bridge else { return };
    bridge.uiManager.setSize(size, for: self);
  };
  
  func notifyForBoundsChangeForContent(size: CGSize){
    guard let bridge = self.bridge,
          let reactContent = self.reactContent
    else { return };
    
    bridge.uiManager.setSize(size, for: reactContent);
  };
  
  // MARK: - Commands For Module
  // --------------------------
  
  /// Called by `RNIWrapperViewModule.notifyComponentWillUnmount`
  func onJSComponentWillUnmount(isManuallyTriggered: Bool){
    self.delegate?.onJSComponentWillUnmount?(
      sender: self,
      isManuallyTriggered: isManuallyTriggered
    );
    
    if self.shouldAutoCleanupOnJSUnmount {
      self.cleanup();
    };
  };
};


// MARK: - RNICleanable
// --------------------

extension RNIWrapperView: RNICleanable {
  
  func cleanup(){
    guard !self.didTriggerCleanup else { return };
    self.didTriggerCleanup = true;
    
    self.touchHandler.detach(from: self.reactContent);
    
    RNIUtilities.recursivelyRemoveFromViewRegistry(
      bridge: self.bridge,
      reactView: self
    );
  };
};
