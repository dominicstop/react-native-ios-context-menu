//
//  RNIContextMenuViewContent.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

import UIKit
import DGSwiftUtilities
import ContextMenuAuxiliaryPreview
import react_native_ios_utilities


@objc(RNIContextMenuViewDelegate)
public final class RNIContextMenuViewContent: UIView, RNIContentView {
  
  public static var propKeyPathMap: Dictionary<String, PartialKeyPath<RNIContextMenuViewContent>> = [
    "menuConfig": \.menuConfig,
    "previewConfig": \.previewConfigProp,
    "shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle": \.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle,
    "isContextMenuEnabled": \.isContextMenuEnabled,
    "shouldPreventLongPressGestureFromPropagating": \.shouldPreventLongPressGestureFromPropagating,
    "isAuxiliaryPreviewEnabled": \.isAuxiliaryPreviewEnabled,
    "auxiliaryPreviewConfig": \.auxiliaryPreviewConfigProp,
  ];
  
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
  
  private(set) public var menuConfig: RNIMenuItem?;
  @objc public var menuConfigProp: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0,
            
            let menuConfig = RNIMenuItem(dictionary: newValue)
      else {
        self.menuConfig = nil;
        return;
      };
      
      // TODO: Impl
      // menuConfig.delegate = self;
      
      menuConfig.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle =
        self.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle;
      
      // TODO: Impl
      // self.updateContextMenuIfVisible(with: menuConfig);
      
      // cleanup `deferredElementCompletionMap`
      // TODO: Impl
      // self.cleanupOrphanedDeferredElements(currentMenuConfig: menuConfig);
      
      // update config
      self.menuConfig = menuConfig;
    }
  };
  
  private(set) public var previewConfig = RNIMenuPreviewConfig();
  @objc public var previewConfigProp: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue else { return };
      
      let previewConfig = RNIMenuPreviewConfig(dictionary: newValue);
      self.previewConfig = previewConfig;
      
      // TODO: Impl
      // update the vc's previewConfig
      // if let previewController = self.previewController {
      //   previewController.view.setNeedsLayout();
      // };
    }
  };
  
  @objc public var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  @objc public var isContextMenuEnabled = true;
  
  // TODO: Rename to: shouldCancelReactTouchesWhenContextMenuIsShown
  @objc public var shouldPreventLongPressGestureFromPropagating = true {
    willSet {
      let oldValue = self.shouldPreventLongPressGestureFromPropagating;
      
      // TODO: Impl
      // guard newValue != oldValue,
      //       let longPressGestureRecognizer = self.longPressGestureRecognizer
      // else { return };
      //
      // longPressGestureRecognizer.isEnabled = newValue;
    }
  };

  @objc public var isAuxiliaryPreviewEnabled = true {
    willSet {
      // TODO: Impl
      // self.contextMenuManager?.isAuxiliaryPreviewEnabled = newValue;
    }
  };
  
  private(set) public var auxiliaryPreviewConfig: AuxiliaryPreviewConfig!;
  @objc public var auxiliaryPreviewConfigProp: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0
      else {
        // TODO: Impl
        // self.setupInitAuxiliaryPreviewConfigIfNeeded();
        return;
      };
      
      let config: AuxiliaryPreviewConfig = {
        if let newConfig = AuxiliaryPreviewConfig(dict: newValue) {
          return newConfig;
        };
        
        let deprecatedConfig =
          RNIContextMenuAuxiliaryPreviewConfig(dictionary: newValue);
        
        return AuxiliaryPreviewConfig(config: deprecatedConfig);
      }();
      
      // TODO: Impl
      // self.contextMenuManager?.auxiliaryPreviewConfig = config;
      self.auxiliaryPreviewConfig = config;
    }
  };

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
