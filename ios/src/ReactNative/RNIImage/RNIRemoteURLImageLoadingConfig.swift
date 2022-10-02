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
  
  let maxRetryAttempts: Int?;
  
  init(dict: NSDictionary) {
    self.shouldCache = dict["shouldCache"] as? Bool;
    self.shouldLazyLoad = dict["shouldLazyLoad"] as? Bool;
    self.maxRetryAttempts = dict["maxRetryAttempts"] as? Int;
  };
};
