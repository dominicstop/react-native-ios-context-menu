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
  
  public init(
    key: Int,
    delegate: RNICleanableViewDelegate,
    viewsToCleanup: Array<WeakRef<UIView>>,
    shouldProceedCleanupWhenDelegateIsNil: Bool
  ) {
  
    self.key = key;
    self.delegate = delegate;
    self.viewsToCleanup = viewsToCleanup;
    self.shouldProceedCleanupWhenDelegateIsNil = shouldProceedCleanupWhenDelegateIsNil;
  };
};
