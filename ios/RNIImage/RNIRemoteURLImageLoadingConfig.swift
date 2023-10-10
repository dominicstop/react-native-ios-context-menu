//
//  RNIRemoteURLImageLoadingConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 10/2/22.
//

import Foundation



/// Maps to: `ImageRemoteURLLoadingConfig`
internal struct RNIRemoteURLImageLoadingConfig: RNIImageLoadingConfigurable {
  
  // MARK: Embedded Types
  // --------------------
  
  /// Maps to: `ImageRemoteURLFallbackBehavior`
  enum FallbackBehavior: String {
    case afterFinalAttempt;
    case whileNotLoaded;
    case onLoadError;
  };
  
  // MARK: Properties
  // ----------------
  
  let shouldCache: Bool?;
  let shouldLazyLoad: Bool?;
  
  let maxRetryAttempts: Int?;
  let shouldImmediatelyRetryLoading: Bool?;
  let fallbackBehavior: FallbackBehavior?;
  
  // MARK: Init
  // ----------
  
  init(dict: NSDictionary) {
    self.shouldCache = dict["shouldCache"] as? Bool;
    self.shouldLazyLoad = dict["shouldLazyLoad"] as? Bool;
    
    self.maxRetryAttempts = dict["maxRetryAttempts"] as? Int;
    self.shouldImmediatelyRetryLoading = dict["shouldImmediatelyRetryLoading"] as? Bool;
    
    self.fallbackBehavior = {
      guard let string = dict["fallbackBehavior"] as? String
      else { return nil };
      
      return FallbackBehavior(rawValue: string);
    }();
  };
};
