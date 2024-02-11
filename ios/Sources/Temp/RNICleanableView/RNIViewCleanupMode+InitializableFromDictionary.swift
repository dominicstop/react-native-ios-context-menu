//
//  RNIViewCleanupMode+InitializableFromDictionary.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/11/24.
//

import Foundation
import DGSwiftUtilities

extension RNIViewCleanupMode: InitializableFromDictionary {
  
  public init(fromDict dict: Dictionary<String, Any>) throws {
    let mode = try dict.getValueFromDictionary(
      forKey: "mode",
      type: String.self
    );
    
    switch mode {
      case "default":
        self = .default;
        
      case "disabled":
        self = .disabled;
        
      case "enabled":
        let triggersRaw = try dict.getValueFromDictionary(
          forKey: "triggers",
          type: Array<String>.self
        );
        
        let triggers = triggersRaw.compactMap {
          try? RNIViewCleanupTrigger(fromString: $0);
        };
        
        self = .enabled(triggers: triggers);
        
      default:
        // WIP TBA
        throw NSError();
    };
  };
};
