//
//  RNIContextMenuViewContent.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

import UIKit
import react_native_ios_utilities
import DGSwiftUtilities

@objc(RNIContextMenuViewDelegate)
public final class RNIContextMenuViewContent: UIView, RNIContentView {
  
  public static var propKeyPathMap: Dictionary<String, PartialKeyPath<RNIContextMenuViewContent>> {
    // TBA
    return [:]
  };
  
  public enum Events: String, CaseIterable {
    case onDidSetViewID;
  }
  
  // MARK: Properties
  // ----------------
  
  var _didSetup = false;
  
  // MARK: - Properties - RNIContentViewDelegate
  // -------------------------------------------
  
  public weak var parentReactView: RNIContentViewParentDelegate?;
  
  // MARK: Properties - Props
  // ------------------------
  
  public var reactProps: NSDictionary = [:];

  // MARK: Init
  // ----------
  
  public override init(frame: CGRect) {
    super.init(frame: frame);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  }
  
  // MARK: Functions
  // ---------------
  
  public override func didMoveToWindow() {
    guard self.window != nil,
          let parentReactView = self.parentReactView
    else { return };
    
    print(
      "RNIContextMenuViewDelegate.didMoveToWindow",
      "\n - reactProps:", self.reactProps.description,
      "\n"
    );
    
    self._setupContent();
    return;
  };
  
  func _setupContent(){
    guard !self._didSetup else { return };
    self._didSetup = true;
  };
};

// MARK: - RNIContextMenuViewDelegate+RNIContentViewDelegate
// --------------------------------------------------

extension RNIContextMenuViewContent: RNIContentViewDelegate {

  public typealias KeyPathRoot = RNIContextMenuViewContent;

  // MARK: Paper + Fabric
  // --------------------
  
  public func notifyOnInit(sender: RNIContentViewParentDelegate) {
    print(
      "RNIContextMenuViewDelegate.notifyOnInit",
      "\n - reactProps:", self.reactProps.description,
      "\n"
    );
    return;
  };
    
  public func notifyOnMountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    #if !RCT_NEW_ARCH_ENABLED
    superBlock();
    #endif
    
    // Note: Window might not be available yet
    self.addSubview(childComponentView);
  };
  
  public func notifyOnUnmountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    #if !RCT_NEW_ARCH_ENABLED
    superBlock();
    #endif
    
  }
  
  public func notifyDidSetProps(sender: RNIContentViewParentDelegate) {
    // no-op
  };
  
  public func notifyOnUpdateLayoutMetrics(
    sender: RNIContentViewParentDelegate,
    oldLayoutMetrics: RNILayoutMetrics,
    newLayoutMetrics: RNILayoutMetrics
  ) {
    // no-op
  };
  
  public func notifyOnViewCommandRequest(
    sender: RNIContentViewParentDelegate,
    forCommandName commandName: String,
    withCommandArguments commandArguments: NSDictionary,
    resolve resolveBlock: (NSDictionary) -> Void,
    reject rejectBlock: (String) -> Void
  ) {
    // no-op
  };
  
  // MARK: - Fabric Only
  // -------------------

  #if RCT_NEW_ARCH_ENABLED
  public func notifyOnUpdateProps(
    sender: RNIContentViewParentDelegate,
    oldProps: NSDictionary,
    newProps: NSDictionary
  ) {
    // no-op
  };
  
  public func notifyOnUpdateState(
    sender: RNIContentViewParentDelegate,
    oldState: NSDictionary?,
    newState: NSDictionary
  ) {
    // no-op
  };
  
  public func notifyOnFinalizeUpdates(
    sender: RNIContentViewParentDelegate,
    updateMaskRaw: Int,
    updateMask: RNIComponentViewUpdateMask
  ) {
    // no-op
  };
  
  public func notifyOnPrepareForReuse(sender: RNIContentViewParentDelegate) {
    self._didSetup = false;
  };
  
  public func shouldRecycleContentDelegate(
    sender: RNIContentViewParentDelegate
  ) -> Bool {
    return false;
  };
  #else
  
  // MARK: - Paper Only
  // ------------------
  
  #endif
};
