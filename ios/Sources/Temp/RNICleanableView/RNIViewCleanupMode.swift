//
//  RNIViewCleanupMode.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/11/24.
//

import Foundation
import DGSwiftUtilities

public enum RNIViewCleanupMode: EnumCaseStringRepresentable {
  // MARK: - Static Alias
  // --------------------

  public static let `default`: Self = .enabled(triggers: [
    .reactComponentWillUnmount,
    .instanceDeinit
  ]);
  
  // MARK: - Enum Members
  // --------------------
  
  case disabled;
  case enabled(triggers: [RNIViewCleanupTrigger]);
  
  // MARK: - Computed Properties
  // ---------------------------
  
  public var triggers: [RNIViewCleanupTrigger] {
    switch self {
      case let .enabled(triggers):
        return triggers;
        
      default:
        return [];
    };
  };
  
  // MARK: - EnumCaseStringRepresentable
  // -----------------------------------
  
  public var caseString: String {
    switch self {
      case .disabled:
        return "disabled";
        
      case .enabled:
        return "enabled";
    };
  };
};
