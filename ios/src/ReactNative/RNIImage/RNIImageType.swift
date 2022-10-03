//
//  RNIImageType.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/26/22.
//

import Foundation


enum RNIImageType: String {
  case IMAGE_ASSET;
  case IMAGE_SYSTEM;
  case IMAGE_REQUIRE;
  case IMAGE_EMPTY;
  case IMAGE_RECT;
  case IMAGE_GRADIENT;
  case IMAGE_REMOTE_URL;
};

enum RNIImageConfig {
  case IMAGE_ASSET(assetName: String);
  case IMAGE_SYSTEM(config: RNIImageSystemMaker);
  case IMAGE_REQUIRE(config: RNIImageRequireMaker);
  case IMAGE_EMPTY;
  case IMAGE_RECT(config: RNIImageMaker);
  case IMAGE_GRADIENT(config: RNIImageGradientMaker);
  case IMAGE_REMOTE_URL(config: RNIImageRemoteURLMaker);
};
