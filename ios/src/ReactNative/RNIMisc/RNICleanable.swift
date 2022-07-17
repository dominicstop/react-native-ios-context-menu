//
//  RNICleanable.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 7/17/22.
//

import Foundation

/// types that conform to this protocol means that `cleanup` can be invoked during the end of it's lifecycle.
protocol RNICleanable {
  func cleanup();
};
