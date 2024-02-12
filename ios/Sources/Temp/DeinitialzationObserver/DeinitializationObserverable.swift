//
//  DeinitializationObserverable.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/12/24.
//

import Foundation


/// Protocol for any object that implements this logic
public protocol DeinitializationObserverable: AnyObject {
  
  var deinitObserver: DeinitializationObserver { get };
};
