//
//  RCTMenuProtocols.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/24/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


class RCTMenuElement: Hashable, Encodable {
  static func == (lhs: RCTMenuElement, rhs: RCTMenuElement) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs);
  };
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self).hashValue)
  };
};
