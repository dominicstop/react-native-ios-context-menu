//
//  RNIContextMenuError.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/18/23.
//

import ReactNativeIosUtilities

public typealias RNIContextMenuError =
  RNIError<RNIUtilitiesErrorMetadata, RNIDefaultErrorCode>;
  
public struct RNIContextMenuErrorMetadata: RNIErrorMetadata {
  public static var domain = "react-native-ios-context-menu";
  
  public static var parentType: String?;
};

