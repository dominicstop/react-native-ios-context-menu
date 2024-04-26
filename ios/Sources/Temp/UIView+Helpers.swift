//
//  UIView+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 4/26/24.
//

import UIKit

// MARK: TODO - Move to `SwiftUtilities`
public extension UIView {

  var recursivelyGetAllParentResponders: [UIResponder] {
    var parentResponders: [UIResponder] = [self];
    
    while let currentParentResponder = parentResponders.last,
          let nextParentResponder = currentParentResponder.next {
      
      parentResponders.append(nextParentResponder);
    };
    
    return parentResponders;
  };
};
