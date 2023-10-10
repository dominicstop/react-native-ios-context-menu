//
//  RNIUtilitiesModule.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation


@objc(RNIUtilitiesModule)
internal class RNIUtilitiesModule: NSObject {
  
  @objc var bridge: RCTBridge! {
    willSet {
      RNIUtilities.sharedBridge = newValue;
    }
  };
  
  @objc static func requiresMainQueueSetup() -> Bool {
    // run init in bg thread
    return false;
  };
  
  @objc func initialize(_ params: NSDictionary){
    // no-op
  };
};
