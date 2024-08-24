//
//  RNIContextMenuError.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 10/18/23.
//

import react_native_ios_utilities
import DGSwiftUtilities

public typealias RNIContextMenuError =
  RNIError<RNIUtilitiesErrorMetadata>;
  
public struct RNIContextMenuErrorMetadata: ErrorMetadata {
  public static var domain: String? = "react-native-ios-context-menu";
  
  public static var parentType: String?;
};

