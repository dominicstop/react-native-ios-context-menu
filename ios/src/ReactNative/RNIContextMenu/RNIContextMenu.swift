//
//  RNIContextMenu.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit

protocol RNIContextMenu: UIView {
  
  func notifyViewControllerDidPop(sender: RNIContextMenuViewController);
  
  func attachToParentVC();
  
  func detachFromParentVC();
  
};
