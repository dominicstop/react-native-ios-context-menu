//
//  RNIImageCacheAndLoadingConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation


protocol RNIImageLoadingConfigurable {
  var shouldCache: Bool? { get };
  var shouldLazyLoad: Bool? { get };
};

// TODO: Per file defaults via extension
internal struct RNIImageLoadingConfig: RNIImageLoadingConfigurable {

  let shouldCache: Bool?;
  let shouldLazyLoad: Bool?;
  
  init(dict: NSDictionary) {
    self.shouldCache = dict["shouldCache"] as? Bool;
    self.shouldLazyLoad = dict["shouldLazyLoad"] as? Bool;
  };
};
