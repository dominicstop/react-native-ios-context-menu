//
//  RNIRemoteURLImageLoadingConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 10/2/22.
//

import Foundation

/// Maps to: `ImageRemoteURLLoadingConfig`
internal struct RNIRemoteURLImageLoadingConfig: RNIImageLoadingConfigurable {
  let shouldCache: Bool?;
  let shouldLazyLoad: Bool?;
  
  init(dict: NSDictionary) {
    self.shouldCache = dict["shouldCache"] as? Bool;
    self.shouldLazyLoad = dict["shouldLazyLoad"] as? Bool;
  };
};
