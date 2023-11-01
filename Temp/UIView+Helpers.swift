//
//  UIView+Helpers.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/2/23.
//

import UIKit

// TODO: Move to `DGSwiftUtilities`
extension UIView {
  
  var recursivelyGetAllSubviews: [UIView] {
    var views: [UIView] = [];
    
    for subview in self.subviews {
      views.append(subview);
      views += subview.recursivelyGetAllSubviews;
    };
    
    return views;
  };
  
  var recursivelyGetAllGestureRecognizersFromSubviews: [UIGestureRecognizer] {
    self.recursivelyGetAllSubviews.reduce(into: []){
      $0 += $1.gestureRecognizers ?? []
    };
  };
  
  var recursivelyGetAllGestureRecognizers: [UIGestureRecognizer] {
    (self.gestureRecognizers ?? []) +
      self.recursivelyGetAllGestureRecognizersFromSubviews
  };
  
  func recursivelyFindParentView(where predicate: (UIView) -> Bool) -> UIView? {
    var currentView = self;
    
    while true {
      guard let superview = self.superview else { return nil };
      currentView = superview;
      
      guard predicate(currentView) else { continue };
      return currentView;
    };
  };
  
  func recursivelyFindParentView<T>(whereType type: T.Type) -> T? {
    let match = self.recursivelyFindParentView(where: {
      $0 is T;
    })
    
    guard let match = match else { return nil };
    return match as? T;
  };
  
  func recursivelyFindSubview(where predicate: (UIView) -> Bool) -> UIView? {
    for subview in self.subviews {
      if predicate(subview) {
        return subview;
      };
      
      if let match = subview.recursivelyFindSubview(where: predicate) {
        return match;
      };
    };
    
    return nil;
  };
  
  func recursivelyFindSubview<T>(whereType type: T.Type) -> T? {
    let match = self.recursivelyFindSubview(where: {
      $0 is T;
    })
    
    guard let match = match else { return nil };
    return match as? T;
  };
};
