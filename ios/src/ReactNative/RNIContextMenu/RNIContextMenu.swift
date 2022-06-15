//
//  RNIContextMenu.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit

// TODO: Rename
protocol RNIContextMenu: UIView {
  
  func notifyViewControllerDidPop(sender: RNIContextMenuViewController);
  
  func attachToParentVC();
  
  func detachFromParentVC();
  
};
