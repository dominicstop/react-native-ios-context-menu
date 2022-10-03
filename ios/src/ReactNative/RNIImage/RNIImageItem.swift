//
//  RNIImageItem.swift
//  IosNavigatorExample
//
//  Created by Dominic Go on 1/29/21.
//

import Foundation
import UIKit


internal class RNIImageItem {
  
  // MARK: - Properties - Config
  // ---------------------------
  
  let type: RNIImageType;
  let imageValue: Any?;
  let imageOptions: RNIImageOptions;
  
  var defaultSize: CGSize;
  
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
        
      case let .IMAGE_REQUIRE(imageConfig):
        return imageConfig.image;
      
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
  
  var imageWithTint: UIImage? {
    guard var image = self.baseImage else { return nil };
    guard let tint = self.imageOptions.tint else { return image };
    
    let isTintTransparent = tint.rgba.a < 1;
    
    if isTintTransparent {
      let overlay = RNIImageMaker(size: image.size, fillColor: tint, borderRadius: 0);
      let overlayImage = overlay.makeImage();
      
      return UIGraphicsImageRenderer(size: image.size).image { context in
        let rect = CGRect(origin: .zero, size: image.size);

        image.draw(in: rect);
        overlayImage.draw(in: rect);
      };
    };
    
    if image.renderingMode != self.imageOptions.renderingMode {
      image = image.withRenderingMode(self.imageOptions.renderingMode)
    };
    
    if #available(iOS 13.0, *) {
      image = image.withTintColor(
        tint,
        renderingMode: self.imageOptions.renderingMode
      );
    };
    
    return image;
  };
  
  var imageWithRoundedEdges: UIImage? {
    guard let image = self.imageWithTint
    else { return nil };
    
    guard let cornerRadius = self.imageOptions.cornerRadius
    else { return image };
    
    return UIGraphicsImageRenderer(size: image.size).image { context in
      let rect = CGRect(origin: .zero, size: image.size);
      
      let clipPath = UIBezierPath(
        roundedRect : rect,
        cornerRadius: cornerRadius
      );
      
      clipPath.addClip();
      image.draw(in: rect);
    };
  };
  
  var image: UIImage? {
    self.imageWithRoundedEdges
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
          guard let rawConfig   = imageValue as? NSDictionary,
                let imageConfig = RNIImageRequireMaker(
                  dict: rawConfig,
                  imageLoadingConfig: imageLoadingConfig
                )
          else { return nil };
          
          return .IMAGE_REQUIRE(config: imageConfig);
        
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
    self.imageOptions = RNIImageOptions(dict: imageOptions ?? [:]);
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
};
