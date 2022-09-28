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
  
  // MARK: - Properties - Serialized
  // -------------------------------
  
  let urlString: String;
  
  // MARK: - Properties - Derived/Parsed
  // -----------------------------------
  
  let url: URL;
  let imageLoadingConfig: RNIImageLoadingConfig;
  
  /// Reminder: Use weak self to prevent retain cycle + memory leak
  var onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)?;
  
  // MARK: - Properties
  // ------------------
  
  var isLoading = false;
  
  /// loaded image
  private var _image: UIImage?;
  
  // MARK: - Properties - Computed
  // -----------------------------
  
  private var cachedImage: UIImage? {
    guard self.imageLoadingConfig.shouldCache ?? false,
          let cachedImage = Self.imageCache[self.urlString]
    else { return nil };
    
    return cachedImage;
  };
  
  // shdaow variable for `_image`
  var image: UIImage? {
    set {
      self._image = newValue;
    }
    get {
      if let cachedImage = self.cachedImage {
        // A - Image was cahced, Use cached image
        return cachedImage;
        
      } else if let image = self._image {
        // B Image already loaded, use loaded image
        return image;
      };
      
      // C - Image not loaded yet...
      // trigger image loading so its loaded next time
      self.loadImage();
      return nil;
    }
  };
  
  var synthesizedURLRequest: URLRequest? {
    URLRequest(url: self.url);
  };
  
  // MARK: - Init
  // ------------
  
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
  
  // MARK: Functions
  // ---------------
  
  func loadImage(){
    guard !self.isLoading,
          let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else { return };
    
    self.isLoading = true;
    
    imageLoader.loadImage(with: urlRequest){ [weak self] error, image in
      self?.isLoading = false;

      guard let image = image else { return };
      
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return };
        
        strongSelf._image = image;
        strongSelf.onImageDidLoadBlock?(strongSelf);
        
        if strongSelf.imageLoadingConfig.shouldCache ?? false {
          Self.imageCache[strongSelf.urlString] = image;
        };
      };
    };
  };
};
