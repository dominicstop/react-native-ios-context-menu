//
//  RNIImageRemoteURLMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation
import UIKit


internal class RNIImageRemoteURLMaker {
  
  static var imageCache: [String: UIImage] = [:];
  
  lazy var imageLoader: RCTImageLoaderWithAttributionProtocol? = {
    RNIUtilities.sharedBridge?.module(forName: "ImageLoader") as?
      RCTImageLoaderWithAttributionProtocol;
  }();
  
  let urlString: String;
  
  let url: URL;
  let imageLoadingConfig: RNIImageLoadingConfig;
  
  var isLoading = false;
  
  private var cachedImage: UIImage? {
    guard self.imageLoadingConfig.shouldCache ?? false,
          let cachedImage = Self.imageCache[self.urlString]
    else { return nil };
    
    return cachedImage;
  };
  
  private var _image: UIImage?;
  var image: UIImage? {
    set {
      self._image = newValue;
    }
    get {
      if let cachedImage = self.cachedImage {
        return cachedImage;
      };
      
      // trigger image loading so its loaded next time
      self.loadImage();
      return self._image;
    }
  };
  
  /// Reminder: Use weak self to prevent retain cycle + memory leak
  var onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)?;
  
  var synthesizedURLRequest: URLRequest? {
    URLRequest(url: self.url);
  };
  
  init?(
    dict: NSDictionary,
    imageLoadingConfig: NSDictionary?,
    onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)? = nil
  ){
    guard let urlString = dict["url"] as? String,
          let url = URL(string: urlString)
    else { return nil };
    
    self.urlString = urlString;
    
    self.url = url;
    self.imageLoadingConfig =
      RNIImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
    
    self.onImageDidLoadBlock = onImageDidLoadBlock;
    
    let shouldLazyLoad = self.imageLoadingConfig.shouldLazyLoad ?? false;
    let hasCachedImage = self.cachedImage != nil;
    let shouldPreloadImage = !shouldLazyLoad && !hasCachedImage;
    
    if shouldPreloadImage {
      self.loadImage();
    };
  };
  
  func loadImage(){
    guard !self.isLoading,
          self._image == nil,
          let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else { return };
    
    self.isLoading = true;
    
    imageLoader.loadImage(with: urlRequest){ [weak self] error, image in
      self?.isLoading = false;

      guard let image = image else { return };
      
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return };
        
        print("DEBUG - image: \(image.debugDescription)");
        
        strongSelf._image = image;
        strongSelf.onImageDidLoadBlock?(strongSelf);
        
        if strongSelf.imageLoadingConfig.shouldCache ?? false {
          Self.imageCache[strongSelf.urlString] = image;
        };
      };
    };
  };
};
