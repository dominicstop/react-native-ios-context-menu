//
//  RCTMenuPreviewConfig.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


struct PreviewConfig {
    
  enum PreviewType: String {
    case DEFAULT;
    case CUSTOM;
  };
  
  // ----------------
  // MARK: Properties
  // ----------------
  
  var previewType: PreviewType = .DEFAULT;
    
  var isResizeAnimated = true;
  
  var borderRadius   : CGFloat = 10;
  var backgroundColor: UIColor = .red;
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
    
    if let borderRadius = dictionary["borderRadius"] as? CGFloat {
      self.borderRadius = borderRadius;
    };
    
    if let isResizeAnimated = dictionary["isResizeAnimated"] as? Bool {
      self.isResizeAnimated = isResizeAnimated;
    };
    
    //RCTConvert.uiColor(0000000000);
  };
};
