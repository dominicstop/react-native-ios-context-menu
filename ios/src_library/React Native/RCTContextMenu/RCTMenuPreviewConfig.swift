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

  enum PreviewSize {
    
    case inherit;
    case stretch;
    case custom(size: CGFloat);
    
    init?(fromString string: String) {
      switch string {
        case "inherit": self = .inherit;
        case "stretch": self = .stretch;

        default: return nil;
      };
    };
    
    init?(fromAny value: Any) {
      if let string      = value as? String,
         let previewSize = PreviewSize(fromString: string) {
        
        self = previewSize;
        
      } else if let size = value as? CGFloat {
        self = .custom(size: size);
        
      } else {
        return nil;
      };
    };
  };
  
  // ----------------
  // MARK: Properties
  // ----------------
  
  var previewType: PreviewType = .DEFAULT;
  
  var previewHeight: PreviewSize = .inherit;
  var previewWidth : PreviewSize = .inherit;
  
  var previewBorderRadius: CGFloat = 10;
  
  var backgroundColor: UIColor = .red;
  
};

// --------------------------
// MARK: PreviewConfig - Init
// --------------------------

extension PreviewConfig {
  
  init(dictionary: NSDictionary){
    if let previewTypeString = dictionary["previewType"] as? String,
       let previewType       = PreviewType(rawValue: previewTypeString) {
      
      self.previewType = previewType;
    };
    
    if let previewHeight = dictionary["previewHeight"],
       let previewSize   = PreviewSize(fromAny: previewHeight) {
      
      self.previewHeight = previewSize;
    };
    
    if let previewWidth = dictionary["previewWidth"],
       let previewSize  = PreviewSize(fromAny: previewWidth) {
      
      self.previewWidth = previewSize;
    };
    
    //RCTConvert.uiColor(0000000000);
  };
};
