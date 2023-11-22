//
//  RNIMenuPreviewConfig.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


@available(iOS 13.0, *)
public struct RNIMenuPreviewConfig {
  
  // MARK: - Nested Types
  // --------------------
  
  public enum PreviewType: String {
    case DEFAULT;
    case CUSTOM;
  };

  public enum PreviewSize: String {
    case INHERIT;
    case STRETCH;
  };
  
  // MARK: - Properties
  // ------------------
  
  public var previewType: PreviewType = .DEFAULT;
  public var previewSize: PreviewSize = .INHERIT;
  
  public var isResizeAnimated = true;
  
  public var borderRadius   : CGFloat?;
  public var targetViewNode : NSNumber?;
  public var backgroundColor: UIColor = .clear;
  
  public var preferredCommitStyle: UIContextMenuInteractionCommitStyle = .dismiss;
};

// MARK: - Init
// ------------

@available(iOS 13.0, *)
extension RNIMenuPreviewConfig {
  
  public init(dictionary: Dictionary<String, Any>){
    self.borderRadius   = dictionary["borderRadius"  ] as? CGFloat;
    self.targetViewNode = dictionary["targetViewNode"] as? NSNumber;
    
    if let string      = dictionary["previewType"] as? String,
       let previewType = PreviewType(rawValue: string) {
      
      self.previewType = previewType;
    };
    
    if let string      = dictionary["previewSize"] as? String,
       let previewSize = PreviewSize(rawValue: string) {
      
      self.previewSize = previewSize;
    };
    
    if let isResizeAnimated = dictionary["isResizeAnimated"] as? Bool {
      self.isResizeAnimated = isResizeAnimated;
    };
    
    if let string  = dictionary["backgroundColor"] as? String,
       let bgColor = UIColor(cssColor: string) {
      
      self.backgroundColor = bgColor;
    };
    
    if let string = dictionary["preferredCommitStyle"] as? String,
       let preferredCommitStyle = UIContextMenuInteractionCommitStyle(string: string) {
      
      self.preferredCommitStyle = preferredCommitStyle;
    };
  };
  
  public init?(dictionary: Dictionary<String, Any>?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};
