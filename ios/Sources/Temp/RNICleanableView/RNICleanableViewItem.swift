//
//  RNICleanableViewItem.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import DGSwiftUtilities


public class RNICleanableViewItem {
  public var key: Int;

  public weak var delegate: RNICleanableViewDelegate?;
  public var viewsToCleanup: Array<WeakRef<UIView>>;
  
  public var shouldProceedCleanupWhenDelegateIsNil: Bool;
  public var viewCleanupMode: RNIViewCleanupMode = .default;
  
  public init(
    key: Int,
    delegate: RNICleanableViewDelegate,
    viewsToCleanup: Array<WeakRef<UIView>>,
    shouldProceedCleanupWhenDelegateIsNil: Bool,
    viewCleanupMode: RNIViewCleanupMode
  ) {
  
    self.key = key;
    self.delegate = delegate;
    self.viewsToCleanup = viewsToCleanup;
    self.shouldProceedCleanupWhenDelegateIsNil = shouldProceedCleanupWhenDelegateIsNil;
    self.viewCleanupMode = viewCleanupMode;
  };
};
