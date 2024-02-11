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

  public static var debugShouldLogCleanup = false;
  public static var debugShouldLogRegister = false;

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
    
    #if DEBUG
    if Self.debugShouldLogRegister {
      print(
        "RNICleanableViewRegistry.register",
        "\n - delegate.viewCleanupKey:", entry.viewCleanupKey,
        "\n - delegate type:", type(of: entry),
        "\n - initialViewsToCleanup.count", initialViewsToCleanup.count,
        "\n - shouldIncludeDelegateInViewsToCleanup", shouldIncludeDelegateInViewsToCleanup,
        "\n - shouldProceedCleanupWhenDelegateIsNil", shouldProceedCleanupWhenDelegateIsNil,
        "\n"
      );
    };
    #endif
    
    self.registry[entry.viewCleanupKey] = .init(
      key: entry.viewCleanupKey,
      delegate: entry,
      viewsToCleanup: initialViewsToCleanup,
      shouldProceedCleanupWhenDelegateIsNil: shouldProceedCleanupWhenDelegateIsNil,
      viewCleanupMode: entry.viewCleanupMode
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
    sender: RNICleanableViewSenderType,
    shouldForceCleanup: Bool,
    cleanupTrigger: RNIViewCleanupTrigger?
  ) throws {
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
    
    if shouldForceCleanup {
      shouldCleanup = true;
    };
    
    guard shouldCleanup else { return };
    
    var viewsToCleanup: [UIView] = [];
    var cleanableViewItems: [RNICleanableViewItem] = [];
    
    for weakView in match.viewsToCleanup {
      guard let view = weakView.ref else { continue };
      
      let isDuplicate = viewsToCleanup.contains {
        view.tag == $0.tag;
      };
      
      guard !isDuplicate else { continue };
      
      if let cleanableView = view as? RNICleanableViewDelegate,
         let cleanableViewItem = cleanableView.associatedCleanableViewItem,
         cleanableView !== match.delegate {
         
         cleanableViewItems.append(cleanableViewItem);
      
      } else if let reactView = view as? RCTView,
                let reactTag = reactView.reactTag,
                let entry = self.getEntry(forKey: reactTag.intValue),
                entry.delegate !== match.delegate  {
                
        cleanableViewItems.append(entry);
      
      } else {
        viewsToCleanup.append(view);
      };
    };
    
    match.delegate?.notifyOnViewCleanupWillBegin();
    try self._cleanup(views: viewsToCleanup);
    
    match.delegate?.notifyOnViewCleanupCompletion();
    self.registry.removeValue(forKey: match.key);
    
    var failedToCleanupItems: [RNICleanableViewItem] = [];
    cleanableViewItems.forEach {
      do {
        try self.notifyCleanup(
          forKey: $0.key,
          sender: sender,
          shouldForceCleanup: shouldForceCleanup,
          cleanupTrigger: cleanupTrigger
        );
        
      } catch {
        failedToCleanupItems.append($0);
      };
    };
    
    cleanableViewItems.forEach {
      #if DEBUG
      if Self.debugShouldLogCleanup {
        let _className = ($0.delegate as? NSObject)?.className ?? "N/A";
        let _viewReactTag = ($0.delegate as? RCTView)?.reactTag?.intValue ?? -1;
        
        print(
          "RNICleanableViewRegistry.notifyCleanup",
          "\n - Failed to cleanup items...",
          "\n - key:", $0.key,
          "\n - delegate, type:", type(of: $0.delegate),
          "\n - delegate, className:", _className,
          "\n - delegate, reactTag:", _viewReactTag,
          "\n - shouldProceedCleanupWhenDelegateIsNil:", $0.shouldProceedCleanupWhenDelegateIsNil,
          "\n - viewsToCleanup.count", $0.viewsToCleanup.count,
          "\n"
        );
      };
      #endif
      
      // re-add failed items
      self.registry[$0.key] = $0;
    };
    
    #if DEBUG
    if Self.debugShouldLogCleanup {
      let _className = (match.delegate as? NSObject)?.className ?? "N/A";
      let _triggers = match.viewCleanupMode.triggers.map { $0.rawValue; };
      
      print(
        "RNICleanableViewRegistry.notifyCleanup",
        "\n - forKey:", key,
        "\n - cleanupTrigger:", cleanupTrigger?.rawValue ?? "N/A",
        "\n - match.viewsToCleanup.count:", match.viewsToCleanup.count,
        "\n - match.shouldProceedCleanupWhenDelegateIsNil:", match.shouldProceedCleanupWhenDelegateIsNil,
        "\n - match.delegate.className:", _className,
        "\n - match.viewCleanupMode.triggers:", _triggers,
        "\n - viewsToCleanup.count:", viewsToCleanup.count,
        "\n - cleanableViewItems.count:", cleanableViewItems.count,
        "\n"
      );
    };
    #endif
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
  
  func _cleanup(views viewsToCleanup: [UIView]) throws {
    guard let bridge = self._bridge else {
      // TODO: WIP - Replace
      throw NSError();
    };
    
    viewsToCleanup.forEach {
      RNIHelpers.recursivelyRemoveFromViewRegistry(
        forReactView: $0,
        usingReactBridge: bridge
      );
    };
    
    #if DEBUG
    if Self.debugShouldLogCleanup {
      print(
        "RNICleanableViewRegistry._cleanup",
        "\n - viewsToCleanup.count:", viewsToCleanup.count,
        "\n"
      );
      
      viewsToCleanup.enumerated().forEach {
        print(
          "RNICleanableViewRegistry._cleanup",
          "\n - item: \($0.offset) of \(viewsToCleanup.count - 1)",
          "\n - reactTag:", $0.element.reactTag?.intValue ?? -1,
          "\n - className:", $0.element.className,
          "\n"
        );
      };
    };
    #endif
  };
};
