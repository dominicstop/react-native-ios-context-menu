//
//  AuxiliaryPreviewSizeValue+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview

extension AuxiliaryPreviewSizeValue {

  private enum Mode: String {
    case constant;
    case percentRelativeToWindow;
    case percentRelativeToPreview;
    case multipleValues;
  }

  public init?(dict: Dictionary<String, Any>) {
    guard let modeString = dict["mode"] as? String,
          let mode = Mode(rawValue: modeString)
    else { return nil };
    
    switch mode {
      case .constant:
        guard let value = dict["mode"] as? NSNumber else { return nil };
        self = .constant(value.doubleValue);
        
      case .percentRelativeToWindow:
        guard let percent = dict["percent"] as? NSNumber else { return nil };
        self = .percentRelativeToWindow(percent.doubleValue);
        
      case .percentRelativeToPreview:
        guard let percent = dict["percent"] as? NSNumber else { return nil };
        self = .percentRelativeToPreview(percent.doubleValue);
        
      case .multipleValues:
        guard let valuesRaw = dict["values"] as? Array<Any> else { return nil };
        
        let values: [Self] = valuesRaw.compactMap {
          guard let dict = $0 as? Dictionary<String, Any> else { return nil };
          return Self.init(dict: dict);
        };
        
        self = .multipleValues(values);
    };
  };
};
