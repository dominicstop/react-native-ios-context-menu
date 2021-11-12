//
//  RCTMenuProtocols.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/24/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


class RNIMenuElement: Hashable, Encodable {
  static func == (lhs: RNIMenuElement, rhs: RNIMenuElement) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs);
  };
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self).hashValue)
  };
};
