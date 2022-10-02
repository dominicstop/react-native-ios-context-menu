//
//  RNIImageRemoteURLMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation
import UIKit


internal class RNIImageRemoteURLMaker {
  
  // MARK: - Embedded Types
  // ----------------------
  
  /// Note: Unable to synthesize `Equatable` conformance because of `Error` associated value.
  enum State {
    case INITIAL, LOADING;
    
    case LOADED_ERROR (error: Error);
    
    case LOADED(image: UIImage);
    
    var isLoading: Bool {
      switch self {
        case .LOADING: return true;
        default: return false;
      };
    };
  };
  
  // MARK: - Class Members
  // ---------------------
  
  static var imageCache: [String: UIImage] = [:];
  
  // MARK: - Properties - Serialized
  // -------------------------------
  
  let urlString: String;
  
  // MARK: - Properties - Derived/Parsed
  // -----------------------------------
  
  let url: URL;
  let imageLoadingConfig: RNIRemoteURLImageLoadingConfig;
  
  /// Reminder: Use weak self to prevent retain cycle + memory leak
  var onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)?;
  
  // MARK: - Properties
  // ------------------
  
  lazy var imageLoader: RCTImageLoaderWithAttributionProtocol? = {
    RNIUtilities.sharedBridge?.module(forName: "ImageLoader") as?
      RCTImageLoaderWithAttributionProtocol;
  }();
  
  var state: State = .INITIAL;
  
  // MARK: - Properties - Computed
  // -----------------------------
  
  private var cachedImage: UIImage? {
    guard self.imageLoadingConfig.shouldCache ?? false,
          let cachedImage = Self.imageCache[self.urlString]
    else { return nil };
    
    return cachedImage;
  };
  
  var image: UIImage? {
    switch self.state {
      case .INITIAL:
        // image not loaded yet...
        // trigger image loading so its loaded the next time
        self.loadImage();
        return nil;
        
      case .LOADED(image: let image):
        return image;
        
      case .LOADED_ERROR:
        // image loading failed - retry loading so it's loaded next time
        self.loadImage();
        return nil;
        
      default:
        return nil;
    };
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
      RNIRemoteURLImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
    
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
    guard !self.state.isLoading,
          let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else { return; };
    
    self.state = .LOADING;
    
    imageLoader.loadImage(with: urlRequest){ [weak self] in
      guard let strongSelf = self else { return };
      
      if let error = $0 {
        strongSelf.state = .LOADED_ERROR(error: error);
        strongSelf.onImageDidLoadBlock?(strongSelf);
        
      } else if let image = $1 {
        DispatchQueue.main.async { [weak self] in
          guard let strongSelf = self else { return };
          
          strongSelf.state = .LOADED(image: image);
          strongSelf.onImageDidLoadBlock?(strongSelf);
          
          if strongSelf.imageLoadingConfig.shouldCache ?? false {
            Self.imageCache[strongSelf.urlString] = image;
          };
        };
      };
    };
  };
};
