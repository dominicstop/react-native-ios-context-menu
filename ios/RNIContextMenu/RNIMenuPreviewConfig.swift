//
//  RNIMenuPreviewConfig.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/8/20.
//

import Foundation
import DGSwiftUtilities
import react_native_ios_utilities


@available(iOS 13.0, *)
public struct RNIMenuPreviewConfig {
  
  // MARK: - Nested Types
  // --------------------
  
  public enum PreviewType: String, InitializableFromString {
    case DEFAULT;
    case CUSTOM;
  };

  public enum PreviewSize: String, InitializableFromString {
    case INHERIT;
    case STRETCH;
  };
  
  // MARK: - Properties
  // ------------------
  
  public var previewType: PreviewType = .DEFAULT;
  public var previewSize: PreviewSize = .INHERIT;
  
  public var isResizeAnimated = true;
  public var viewIdentifier : RNINativeViewIdentifier?;
  
  public var borderRadius: CGFloat?;
  public var backgroundColor: UIColor = .clear;
  
  public var preferredCommitStyle: UIContextMenuInteractionCommitStyle = .dismiss;
};

// MARK: - Init
// ------------

@available(iOS 13.0, *)
extension RNIMenuPreviewConfig: InitializableFromDictionary {
  
  public init(fromDict dict: Dictionary<String, Any>) throws {
    self.borderRadius = try? dict.getValueFromDictionary(
      forKey: "borderRadius",
      type: CGFloat.self
    );
    
    self.viewIdentifier = {
      // deprecated
      let targetViewNode = try? dict.getValueFromDictionary(
        forKey: "targetViewNode",
        type: Int.self
      );
      
      if let targetViewNode = targetViewNode {
        return .reactTag(targetViewNode);
      };
      
      let viewIdentifierRaw = try? dict.getValueFromDictionary(
        forKey: "viewIdentifier",
        type: Dictionary<String, Any>.self
      );
      
      guard let viewIdentifierRaw = viewIdentifierRaw else {
        return nil;
      };
      
      return try? .init(fromDict: viewIdentifierRaw);
    }();
    
    if let previewType = try? dict.getValueFromDictionary(
      forKey: "previewType",
      type: PreviewType.self
    ) {
      self.previewType = previewType;
    };
    
    if let previewSize = try? dict.getValueFromDictionary(
      forKey: "previewSize",
      type: PreviewSize.self
    ) {
      self.previewSize = previewSize;
    };
    
    if let isResizeAnimated = try? dict.getValueFromDictionary(
      forKey: "isResizeAnimated",
      type: Bool.self
    ) {
      self.isResizeAnimated = isResizeAnimated;
    };
    
    if let colorString = try? dict.getValueFromDictionary(
         forKey: "backgroundColor",
         type: String.self
       ),
       let bgColor = UIColor(cssColor: colorString)
    {
      self.backgroundColor = bgColor;
    };
    
    if let preferredCommitStyle = try? dict.getValueFromDictionary(
      forKey: "preferredCommitStyle",
      type: UIContextMenuInteractionCommitStyle.self
    ) {
      self.preferredCommitStyle = preferredCommitStyle;
    };
  };
};
