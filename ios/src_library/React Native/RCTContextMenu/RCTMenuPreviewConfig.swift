//
//  RCTMenuPreviewConfig.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


struct PreviewConfig {
  
  // -----------------------
  // MARK: Type Declarations
  // -----------------------
  
  enum PreviewType: String {
    case DEFAULT;
    case CUSTOM;
  };

  enum PreviewSize: String {
    case INHERIT;
    case STRETCH;
  };
  
  // ----------------
  // MARK: Properties
  // ----------------
  
  var previewType: PreviewType = .DEFAULT;
  var previewSize: PreviewSize = .INHERIT;

  var isResizeAnimated = true;
  
  var borderRadius   : CGFloat = 10;
  var backgroundColor: UIColor = .clear;
  
};

// --------------------------
// MARK: PreviewConfig - Init
// --------------------------

extension PreviewConfig {
  
  init(dictionary: NSDictionary){
    if let string      = dictionary["previewType"] as? String,
       let previewType = PreviewType(rawValue: string) {
      
      self.previewType = previewType;
    };
    
    if let string      = dictionary["previewSize"] as? String,
       let previewSize = PreviewSize(rawValue: string) {
      
      self.previewSize = previewSize;
    };

    if let borderRadius = dictionary["borderRadius"] as? CGFloat {
      self.borderRadius = borderRadius;
    };
    
    if let isResizeAnimated = dictionary["isResizeAnimated"] as? Bool {
      self.isResizeAnimated = isResizeAnimated;
    };
    
    //RCTConvert.uiColor(0000000000);
  };
};
