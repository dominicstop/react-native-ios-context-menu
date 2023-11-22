//
//  Angle+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import DGSwiftUtilities

extension Angle {

  private enum Mode: String {
    case zero, radians, degrees;
  };

  init?(dict: Dictionary<String, Any>){
    guard let modeString = dict["mode"] as? String,
          let mode = Self.Mode(rawValue: modeString)
    else { return nil };
    
    switch mode {
      case .zero:
        self = .zero;
        
      case .radians:
        let valueRaw = dict["value"] as? NSNumber ?? 0;
        let value = T(valueRaw.doubleValue);
        self = .radians(value);
        
      case .degrees:
        let valueRaw = dict["value"] as? NSNumber ?? 0;
        let value = T(valueRaw.doubleValue);
        self = .degrees(value);
    };
  };
};
