//
//  RNICleanableViewItem.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import DGSwiftUtilities


public struct RNICleanableViewItem {
  public var key: Int;

  public weak var delegate: RNICleanableViewDelegate?;
  public var viewsToCleanup: Array<WeakRef<UIView>>;
  
  public var shouldProceedCleanupWhenDelegateIsNil: Bool;
};
