//
//  RNIImageItem.swift
//  IosNavigatorExample
//
//  Created by Dominic Go on 1/29/21.
//

import Foundation
import UIKit


internal class RNIImageItem {
  
  static private var imageCache: [String: UIImage] = [:];
  
  // MARK: - Properties - Config
  // ---------------------------
  
  let type: RNIImageType;
  let imageValue: Any?;
  
  var defaultSize: CGSize;
  
  // MARK: Properties - Config - `imageOptions`-Related
  // --------------------------------------------------

  let tint: UIColor?;
  let renderingMode: UIImage.RenderingMode;
  
  // MARK: Properties - Misc
  // -----------------------
  
  let imageConfig: RNIImageConfig;
  var loadedImage: UIImage?;
  
  // MARK: Properties - Computed
  // ---------------------------

  var baseImage: UIImage? {
    switch self.imageConfig {
      case let .IMAGE_ASSET(assetName):
        return UIImage(named: assetName);
        
      case let .IMAGE_SYSTEM(imageConfig):
        guard #available(iOS 13.0, *) else { return nil };
        return imageConfig.image;
        
      case let .IMAGE_REQUIRE(uri, loadingConfig):
        if loadingConfig.shouldCache,
           let cachedImage = Self.imageCache[uri] {
          
          return cachedImage;
        };
        
        guard let image = self.loadedImage ?? RCTConvert.uiImage(self.imageValue)
        else { return nil };
        
        if loadingConfig.shouldCache {
          // cache - globally
          Self.imageCache[uri] = image;
        };
        
        return image;
      
      case .IMAGE_EMPTY:
        return UIImage();
        
      case let .IMAGE_RECT(imageConfig):
        return imageConfig.makeImage();
        
      case let .IMAGE_GRADIENT(imageConfig):
        return imageConfig.makeImage();
        
      case let .IMAGE_REMOTE_URL(imageConfig):
        return imageConfig.image;
    };
  };
  
  var image: UIImage? {
    let image = self.baseImage;
    
    if #available(iOS 13.0, *), let tint = self.tint {
      return image?.withTintColor(tint, renderingMode: self.renderingMode);
      
    } else if image?.renderingMode != self.renderingMode {
      return image?.withRenderingMode(self.renderingMode);
      
    } else {
      return image;
    };
  };
  
  var dictionary: [String: Any] {
    var dict: [String: Any] = [
      "type": self.type
    ];
    
    if let imageValue = self.imageValue {
      dict["imageValue"] = imageValue;
    };
    
    return dict;
  };
  
  // MARK: - Init
  // -----------
  
  init?(
    type: RNIImageType,
    imageValue: Any?,
    imageOptions: NSDictionary?,
    imageLoadingConfig: NSDictionary? = nil,
    defaultImageSize: CGSize = CGSize(width: 100, height: 100)
  ){
    
    self.type = type;
    self.imageValue = imageValue;
    self.defaultSize = defaultImageSize;
    
    guard let imageConfig: RNIImageConfig = {
      switch type {
        case .IMAGE_ASSET:
          guard let string = imageValue as? String
          else { return nil };
        
          return .IMAGE_ASSET(assetName: string);
          
        case .IMAGE_SYSTEM:
          guard #available(iOS 13.0, *),
                let rawConfig   = imageValue as? NSDictionary,
                let imageConfig = RNIImageSystemMaker(dict: rawConfig)
          else { return nil };
        
          return .IMAGE_SYSTEM(config: imageConfig);
          
        case .IMAGE_REQUIRE:
          guard let rawConfig = imageValue as? NSDictionary,
                let uri = rawConfig["uri"] as? String
          else { return nil };
          
          let imageLoadingConfig =
            RNIImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
        
          return .IMAGE_REQUIRE(
            uri: uri,
            loadingConfig: imageLoadingConfig
          );
        
        case .IMAGE_EMPTY:
        return .IMAGE_EMPTY;
          
        case .IMAGE_RECT:
          guard let rawConfig = imageValue as? NSDictionary,
                let imageConfig = RNIImageMaker(dict: rawConfig)
          else { return nil };
        
          return .IMAGE_RECT(config: imageConfig);
          
        case .IMAGE_GRADIENT:
          guard let rawConfig = imageValue as? NSDictionary,
                var imageConfig = RNIImageGradientMaker(dict: rawConfig)
          else { return nil };
        
          imageConfig.setSizeIfNotSet(defaultImageSize);
          return .IMAGE_GRADIENT(config: imageConfig);
          
        case .IMAGE_REMOTE_URL:
          guard let rawConfig = imageValue as? NSDictionary,
                let imageConfig = RNIImageRemoteURLMaker(
                  dict: rawConfig,
                  imageLoadingConfig: imageLoadingConfig
                )
          else { return nil };
          
          return .IMAGE_REMOTE_URL(config: imageConfig);
      };
    }() else { return nil };
    
    self.imageConfig = imageConfig;
    
    self.tint = {
      guard let value = imageOptions?["tint"],
            let color = UIColor.parseColor(value: value)
      else { return nil };
      
      return color;
    }();
    
    self.renderingMode = {
      guard let string = imageOptions?["renderingMode"] as? String,
            let mode   = UIImage.RenderingMode(string: string)
      else { return .automatic };
      
      return mode;
    }();
    
    self.preloadImage();
  };
  
  convenience init?(dict: NSDictionary){
    guard let typeString = dict["type"] as? String,
          let type       = RNIImageType(rawValue: typeString)
    else { return nil };
    
    self.init(
      type: type,
      imageValue: dict["imageValue"],
      imageOptions: dict["imageOptions"] as? NSDictionary,
      imageLoadingConfig: dict["imageLoadingConfig"] as? NSDictionary
    );
  };
  
  // MARK: - Functions
  // -----------------
  
  func preloadImage(){
    switch self.imageConfig {
      case let .IMAGE_REQUIRE(_, loadingConfig):
        guard !loadingConfig.shouldLazyLoad else { return };
        self.loadedImage = RCTConvert.uiImage(self.imageValue);
        
      default: return;
    };
  };
};
