//
//  RNICleanableViewRegistry.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import React
import ExpoModulesCore
import DGSwiftUtilities
import ReactNativeIosUtilities

public let RNICleanableViewRegistryShared = RNICleanableViewRegistry.shared;

public class RNICleanableViewRegistry {

  public static let shared: RNICleanableViewRegistry = .init();
  
  // MARK: - Properties
  // ------------------
  
  public var registry: Dictionary<Int, RNICleanableViewItem> = [:];
  
  weak var _bridge: RCTBridge?;
  
  // MARK: - Functions
  // -----------------
  
  init(){
    // no-op
  };
  
  public func register(
    forDelegate entry: RNICleanableViewDelegate,
    initialViewsToCleanup initialViewsToCleanupRaw: [UIView] = [],
    shouldIncludeDelegateInViewsToCleanup: Bool = true,
    shouldProceedCleanupWhenDelegateIsNil: Bool = true
  ){
    
    self._setBridgeIfNeeded(usingDelegate: entry);
    
    var initialViewsToCleanup = initialViewsToCleanupRaw.map {
      WeakRef(with: $0);
    };
    
    if shouldIncludeDelegateInViewsToCleanup,
       let reactView = entry as? RCTView {
       
      initialViewsToCleanup.append(
        .init(with: reactView)
      );
    };
    
  
    self.registry[entry.viewCleanupKey] = .init(
      key: entry.viewCleanupKey,
      viewsToCleanup: initialViewsToCleanup,
      shouldProceedCleanupWhenDelegateIsNil: shouldProceedCleanupWhenDelegateIsNil
    );
  };
  
  // TOOD: Mark as throws - Add error throwing
  func unregister(forDelegate delegate: RNICleanableViewDelegate){
    guard let match = self.getEntry(forKey: delegate.viewCleanupKey)
    else { return };
    
    self.registry.removeValue(forKey: match.key);
  };
  
  public func getEntry(forKey key: Int) -> RNICleanableViewItem? {
    return self.registry[key];
  };
  
  // TOOD: Mark as throws - Add error throwing
  public func notifyCleanup(
    forKey key: Int,
    sender: RNICleanableViewSenderType
  ){
    guard let match = self.getEntry(forKey: key) else { return };
    
    var shouldCleanup = false;
    
    if let delegate = match.delegate {
      shouldCleanup = delegate.notifyOnViewCleanupRequest(
        sender: sender,
        item: match
      );
    
    } else if match.shouldProceedCleanupWhenDelegateIsNil {
      shouldCleanup = true;
    };
    
    guard shouldCleanup else { return };
    self._cleanup(for: match);
  };
  
  // MARK: - Internal Functions
  // --------------------------
  
  func _setBridgeIfNeeded(usingDelegate delegate: RNICleanableViewDelegate){
    guard self._bridge == nil else { return };
    
    // var window: UIWindow?;
    
    switch delegate {
      case let expoView as ExpoView:
        self._bridge = expoView.appContext?.reactBridge;
       // window = expoView.window;
        
      case let reactView as RCTView:
        self._bridge = reactView.closestParentRootView?.bridge;
        // window = reactView.window;
        
      // case let view as UIView:
      //   window = view.window;
        
      default:
        break;
    };
    
    // bridge is still nil, continue getting the bridge via other means...
    guard self._bridge == nil else { return };
    self._bridge = RNIHelpers.bridge;
  };
  
  func _cleanup(for entry: RNICleanableViewItem){
    guard let bridge = entry.delegate?.bridge ?? self._bridge
    else { return };
    
    let viewsToCleanup = entry.viewsToCleanup.compactMap {
      $0.ref;
    };
    
    viewsToCleanup.forEach {
      RNIHelpers.recursivelyRemoveFromViewRegistry(
        forReactView: $0,
        usingReactBridge: bridge
      );
    };
  };
};
