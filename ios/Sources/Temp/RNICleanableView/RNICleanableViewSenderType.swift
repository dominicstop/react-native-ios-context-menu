//
//  RNICleanableViewSenderType.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/10/24.
//

import UIKit
import ExpoModulesCore

public enum RNICleanableViewSenderType {
  case unspecified;
  case unsupported(Any);
  
  case view(UIView);
  case viewController(UIViewController);
  case cleanableViewDelegate(RNICleanableViewDelegate?);
  
  case reactModule(
    reactTag: Int?,
    commandArguments: Dictionary<String, Any>?
  );
};
