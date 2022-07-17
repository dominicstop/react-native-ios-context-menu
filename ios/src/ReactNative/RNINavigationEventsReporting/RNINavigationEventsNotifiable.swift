//
//  RNIContextMenu.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit

// TODO: Rename
protocol RNINavigationEventsNotifiable: UIView {
  
  // remove - move
  func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController);
  
  // remove
  func attachToParentVC();
  
  // remove
  func detachFromParentVC();
  
};
