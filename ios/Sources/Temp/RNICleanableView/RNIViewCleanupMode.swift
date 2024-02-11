//
//  RNIViewCleanupMode.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/11/24.
//

import Foundation

public enum RNIViewCleanupMode {
  public static let `default`: Self = .enabled(triggers: [
    .reactComponentWillUnmount,
    .instanceDeinit
  ]);
  
  case disabled;
  case enabled(triggers: [RNIViewCleanupTrigger]);
};
