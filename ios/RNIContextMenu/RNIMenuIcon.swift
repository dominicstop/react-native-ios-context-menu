//
//  RNIMenuImageType.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//

import Foundation
import react_native_ios_utilities


public class RNIMenuIcon {
  
  // MARK: - Nested Types
  // --------------------
  
  public enum IconType: String, CaseIterable, Encodable {
    case NONE;
    case URL;
    case SYSTEM;
    case ASSET;
    case REQUIRE;
  };
  
  /// Convert  legacy `IconConfig` dictionary  to `RNIImageItem`
  public static func convertLegacyIconConfigToImageItemConfig(
    dict: Dictionary<String, Any>
  ) -> RNIImageItem? {
    
    guard let string = dict["iconType"] as? String,
          let iconType = IconType(rawValue: string)
    else { return nil };
    
    let iconValue = dict["iconValue"];
    
    switch iconType {
      case .NONE: fallthrough;
      case .URL : return RNIImageItem(
        type: .IMAGE_EMPTY,
        imageValue: nil,
        imageOptions: nil
      );
      
      case .SYSTEM:
        guard let systemName = iconValue as? String
        else { return nil };
        
        var imageSystemConfig: [String: Any] = [
          "systemName": systemName
        ];
        
        if let iconSize = dict["iconSize"] {
          imageSystemConfig["pointSize"] = iconSize;
        };
        
        if let iconScale = dict["iconScale"] {
          imageSystemConfig["scale"] = iconScale;
        };
        
        if let iconWeight = dict["iconWeight"] {
          imageSystemConfig["weight"] = iconWeight;
        };
        
        var imageOptionsConfig: [String: Any] = [:];
        
        if let iconTint = dict["iconTint"] {
          imageOptionsConfig["tint"] = iconTint;
          imageOptionsConfig["renderingMode"] = "alwaysOriginal";
        };
        
        return RNIImageItem(
          type: .IMAGE_SYSTEM,
          imageValue: imageSystemConfig,
          imageOptions: imageOptionsConfig as Dictionary<String, Any>
        );
        
      case .ASSET: return RNIImageItem(
        type: .IMAGE_ASSET,
        imageValue: iconValue,
        imageOptions: nil
      );
        
      case .REQUIRE: return RNIImageItem(
        type: .IMAGE_REQUIRE,
        imageValue: iconValue,
        imageOptions: nil
      );
    };
  };
};
