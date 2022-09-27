//
//  RNIImageRemoteURLMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation


internal class RNIImageRemoteURLMaker {
  
  lazy var imageLoader: RCTImageLoaderWithAttributionProtocol? = {
    RNIUtilities.sharedBridge?.module(forName: "ImageLoader") as?
      RCTImageLoaderWithAttributionProtocol;
  }();
  
  let url: URL;
  let imageLoadingConfig: RNIImageLoadingConfig;
  
  private var _image: UIImage?;
  var image: UIImage? {
    set {
      self._image = newValue;
    }
    get {
      // trigger image loading
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
    
    self.url = url;
    self.imageLoadingConfig =
      RNIImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
    
    self.onImageDidLoadBlock = onImageDidLoadBlock;
    
    let shouldLazyLoad = self.imageLoadingConfig.shouldLazyLoad ?? false;
    
    if !shouldLazyLoad {
      self.loadImage();
    };
  };
  
  func loadImage(){
    guard self._image == nil,
          let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else { return };
    
    imageLoader.loadImage(with: urlRequest){ [weak self] error, image in
      guard let strongSelf = self else { return };
      
      print("DEBUG - image: \(image.debugDescription)");
      
      strongSelf._image = image;
      strongSelf.onImageDidLoadBlock?(strongSelf);
    };
  };
};
