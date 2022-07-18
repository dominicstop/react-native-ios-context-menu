//
//  RNIWrapperView.swift
//  IosNavigatorExample
//
//  Created by Dominic Go on 2/1/21.
//

import UIKit


/// Holds react views that have been detached, and are no longer managed by RN.
internal class RNIWrapperView: UIView {
  
  // MARK: - Properties
  // ------------------
  
  var bridge: RCTBridge!;
  var reactContent: UIView?;
  
  weak var delegate: RNIWrapperViewEventsNotifiable?;
  
  var touchHandlers: Dictionary<NSNumber, RCTTouchHandler> = [:];
  
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
  
  // MARK: - RN Exported Props
  // -------------------------
  
  /// When this prop is set to `true`, the JS component will trigger
  /// `shouldNotifyComponentWillUnmount` during `componentWillUnmount`.
  @objc var shouldNotifyComponentWillUnmount: Bool = false;
    
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
  @objc var shouldAutoCleanupOnJSUnmount = false;
      
  /// Determines whether `cleanup` is called when this view is removed from the
  /// view hierarchy (i.e. when the window ref. becomes nil).
  @objc var shouldAutoCleanupOnWindowNil = false;
  
  /// Determines whether `layoutSubviews` will automatically trigger
  /// `notifyForBoundsChange`. Defaults to `true`.
  ///
  /// * If the layout size is determined from the react/js side, set this to `false`.
  ///
  /// * Otherwise if the layout size is determined from the native side (e.g. via
  ///   the view controller, etc.) then set this to `true`.
  @objc var shouldAutoSetSizeOnLayout = false;
    
  /// If you are planning on removing the parent view (i.e. this view instance) from the view hierarchy via
  /// calling `removeFromSuperview`, and you still want it to receive touch events , then set this
  /// property to `true`.
  @objc var shouldCreateTouchHandlerForParentView = false;
  
  /// If you are planning on removing the subviews from the view hierarchy (i.e. using "dummy view" mode),
  ///  and you still want them to receive touch event, then set this property to `true`.
  @objc var shouldCreateTouchHandlerForSubviews = false;
  
  // MARK: - Init/Lifecycle
  // ---------------------
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    self.bridge = bridge;
    
    if self.shouldCreateTouchHandlerForParentView {
      self.touchHandlers[self.reactTag] = {
        let handler = RCTTouchHandler(bridge: self.bridge)!;
        handler.attach(to: self);
        
        return handler;
      }();
    };
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
    
    if self.shouldCreateTouchHandlerForSubviews {
      self.touchHandlers[subview.reactTag] = {
        let handler = RCTTouchHandler(bridge: self.bridge);
        handler?.attach(to: subview);
        
        return handler;
      }();
    };
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
          self.subviews.count > 0
    else { return };
    
    for subview in subviews {
      bridge.uiManager.setSize(size, for: subview);
    };
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
    
    let viewsToCleanup = self.subviews + [self];
 
    for view in viewsToCleanup  {
      if let touchHandler = self.touchHandlers[view.reactTag] {
        touchHandler.detach(from: view);
      };
      
      RNIUtilities.recursivelyRemoveFromViewRegistry(
        bridge: self.bridge,
        reactView: view
      );
    };
    
    self.touchHandlers.removeAll();
  };
};
