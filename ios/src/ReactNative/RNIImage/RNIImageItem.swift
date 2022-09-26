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
  
  // MARK: - Properties
  // -----------------
  
  let type: RNIImageType;
  
  // MARK: Properties - `imageOptions`-Related
  // -----------------------------------------

  let tint: UIColor?;
  let renderingMode: UIImage.RenderingMode;
  
  // MARK: Properties - Internal/Private
  // -----------------------------------
  
  var useImageCache: Bool?;
  var defaultSize = CGSize(width: 100, height: 100);
  
  private let imageValue: Any?;
  private var imageRequire: UIImage?;
  
  // MARK: Properties - Computed
  // ---------------------------
  
  var shouldUseImageCache: Bool {
    // use cache if image require if `useImageCache` is not set
    self.useImageCache ?? (self.type == .IMAGE_REQUIRE)
  };
  
  var baseImage: UIImage? {
    switch self.type {
      case .IMAGE_ASSET:
        guard let string = self.imageValue as? String,
              let image  = UIImage(named: string)
        else { return nil };
        
        return image;
        
      case .IMAGE_SYSTEM:
        guard #available(iOS 13.0, *),
              let dict        = self.imageValue as? NSDictionary,
              let imageConfig = RNIImageSystemMaker(dict: dict)
        else { return nil };
        
        return imageConfig.image;
        
      case .IMAGE_REQUIRE:
        guard let dict = self.imageValue as? NSDictionary,
              let uri  = dict["uri"] as? String
        else { return nil };
        
        if self.shouldUseImageCache,
           let cachedImage = Self.imageCache[uri] {
          
          return cachedImage;
        };
        
        // note: this will block the current thread
        let image = RCTConvert.uiImage(self.imageValue);
        
        if self.shouldUseImageCache, let image = image {
          Self.imageCache[uri] = image;
        };
        
        return image;
      
      case .IMAGE_EMPTY:
        return UIImage();
        
      case .IMAGE_RECT:
        guard let dict        = self.imageValue as? NSDictionary,
              let imageConfig = RNIImageMaker(dict: dict)
        else { return nil };
        
        return imageConfig.makeImage();
        
      case .IMAGE_GRADIENT:
        guard let dict        = self.imageValue as? NSDictionary,
              var imageConfig = RNIImageGradientMaker(dict: dict)
        else { return nil };
        
        imageConfig.setSizeIfNotSet(self.defaultSize);
        return imageConfig.makeImage();
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
  
  init?(type: RNIImageType, imageValue: Any?, imageOptions: NSDictionary?){
    self.type = type;
    self.imageValue = imageValue;
    
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
  };
  
  convenience init?(dict: NSDictionary){
    guard let typeString = dict["type"] as? String,
          let type       = RNIImageType(rawValue: typeString)
    else { return nil };
    
    self.init(
      type: type,
      imageValue: dict["imageValue"],
      imageOptions: dict["imageOptions"] as? NSDictionary
    );
  };
};
