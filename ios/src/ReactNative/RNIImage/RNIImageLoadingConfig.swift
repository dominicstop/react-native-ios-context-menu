//
//  RNIImageCacheAndLoadingConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation


internal struct RNIImageLoadingConfig {

  let shouldCache: Bool;
  let shouldLazyLoad: Bool;
  
  init(dict: NSDictionary) {
    self.shouldCache = dict["shouldCache"] as? Bool ?? false;
    self.shouldLazyLoad = dict["shouldLazyLoad"] as? Bool ?? true;
  };
};
