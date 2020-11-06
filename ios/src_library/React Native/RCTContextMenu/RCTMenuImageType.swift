//
//  RCTMenuImageType.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


public enum ImageType: String, CaseIterable, Encodable {
  case NONE   = "NONE";
  case URL    = "URL";
  case SYSTEM = "SYSTEM";
  
  static func withLabel(_ label: String) -> ImageType? {
    return self.allCases.first{ $0.rawValue == label };
  };
};
