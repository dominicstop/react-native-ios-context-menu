//
//  RNIContextMenu.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/1/22.
//

import UIKit

protocol RNINavigationEventsNotifiable: UIView {
  
  func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController);
  
};
