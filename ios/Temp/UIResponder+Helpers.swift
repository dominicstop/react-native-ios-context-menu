//
//  UIResponder+Helpers.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/25/24.
//

import Foundation


public extension UIResponder {
  
  func recursivelyFindNextResponder(
    where predicate: (_ currentResponder: UIResponder) -> Bool
  ) -> UIResponder? {
  
    var currentResponder = self;
    
    while true {
      if currentResponder !== self && predicate(currentResponder) {
        return currentResponder;
      };

      guard let nextResponder = currentResponder.next else { return nil };
      currentResponder = nextResponder;
    };
  };
  
  func recursivelyFindNextResponder<T>(withType type: T.Type) -> T? {
    let match = self.recursivelyFindNextResponder {
      $0 is T;
    };
    
    guard let match = match else { return nil };
    return match as? T;
  };
};
