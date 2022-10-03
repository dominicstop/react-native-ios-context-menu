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
    
    // MARK: - Start State
    // -------------------
    
    case INITIAL;
    
    // MARK: - Intermediate State
    // --------------------------
    
    case LOADING;
    
    // loading was triggered again because it failed previously
    case RETRYING(prevError: Error);
    
    case LOADED_ERROR (error: Error? = nil);
    
    // MARK: - Final State
    // -------------------
    
    case LOADED(image: UIImage);
    
    // no more remaining retry attempts, don't trigger loading anymore
    case LOADED_ERROR_FINAL (error: Error? = nil);
    
    // MARK: - Computed Properties
    // ---------------------------
    
    var isLoading: Bool {
      switch self {
        case .LOADING : fallthrough;
        case .RETRYING: return true;
          
        default: return false;
      };
    };
    
    var error: Error? {
      switch self {
        case let .LOADED_ERROR(error): return error;
        default: return nil;
      };
    };
    
    var isErrorState: Bool {
      switch self {
        case .LOADED_ERROR: return true;
        default: return false;
      };
    };
    
    var isFinalState: Bool {
      switch self {
        case .LOADED            : fallthrough;
        case .LOADED_ERROR_FINAL: return true;
          
        default: return false;
      };
    };
  };
  
  typealias ImageDidLoadHandler = (
    _ isSuccess: Bool,
    _ sender: RNIImageRemoteURLMaker
  ) -> Void;
  
  // MARK: - Class Members
  // ---------------------
  
  static var imageCache: [String: UIImage] = [:];
  
  // MARK: - Properties - Serialized
  // -------------------------------
  
  let urlString: String;
  
  // MARK: - Properties - Derived/Parsed
  // -----------------------------------
  
  let url: URL?;
  let imageLoadingConfig: RNIRemoteURLImageLoadingConfig;
  
  let fallbackImageConfig: RNIImageItem?;
  
  // MARK: - Properties
  // ------------------
  
  lazy var imageLoader: RCTImageLoaderWithAttributionProtocol? = {
    RNIUtilities.sharedBridge?.module(forName: "ImageLoader") as?
      RCTImageLoaderWithAttributionProtocol;
  }();
  
  var state: State = .INITIAL;
  var loadingAttemptsCount = 0;
  
  /// Reminder: Use weak self to prevent retain cycle + memory leak
  var onImageDidLoadBlock: ImageDidLoadHandler?;
  
  // MARK: - Properties - Computed
  // -----------------------------
  
  private var cachedImage: UIImage? {
    guard self.imageLoadingConfig._shouldCache,
          let cachedImage = Self.imageCache[self.urlString]
    else { return nil };
    
    return cachedImage;
  };
  
  var shouldRetry: Bool {
    let maxRetryAttempts = self.imageLoadingConfig._maxRetryAttempts;
    
    // Note: negative max retry attempt means infinite retry
    return maxRetryAttempts < 0
      ? true
      : self.loadingAttemptsCount < maxRetryAttempts;
  };
  
  // Get image w/o triggering loading logic (i.e. no side effects)
  // This will also use the fallback image when appropriate
  var _image: UIImage? {
    let fallbackBehavior = self.imageLoadingConfig._fallbackBehavior;
    
    switch self.state {
      case .INITIAL: fallthrough;
      case .LOADING:
        // A - Use fallback image when the remote image hasn't been loaded yet
        switch fallbackBehavior {
          case .whileNotLoaded: return self.fallbackImage;
          default: return nil;
        };
        
      case .RETRYING    : fallthrough;
      case .LOADED_ERROR:
        // B - Use fallback image when the remote image hasn't been loaded yet
        //     due to an error
        switch fallbackBehavior {
          case .whileNotLoaded: fallthrough;
          case .onLoadError   : return self.fallbackImage;
          
          default: return nil;
        };
        
      case .LOADED_ERROR_FINAL:
        // C - Use fallback image when the remote image has failed to load, and
        //     no more "retry loading" attempts remaining
        switch fallbackBehavior {
          case .whileNotLoaded   : fallthrough;
          case .afterFinalAttempt: fallthrough;
          case .onLoadError      : return self.fallbackImage;
        };
        
      case .LOADED(image: let image):
        return image;
    };
  };
  
  // Get image + trigger loading logic when not yet loaded
  var image: UIImage? {
    switch self.state {
      case .INITIAL:
        // A - image not loaded yet...
        //     trigger image loading so it's loaded the next time
        self.loadImage();
        return self._image;
        
      case .LOADED_ERROR:
        // B - image loading failed...
        //     retry loading so it's loaded next time
        self.loadImage();
        fallthrough;
        
      default:
        return self._image;
    };
  };
  
  var synthesizedURLRequest: URLRequest? {
    guard let url = self.url else { return nil };
    return URLRequest(url: url);
  };
  
  var fallbackImage: UIImage? {
    self.fallbackImageConfig?.image
  };
  
  // MARK: - Init
  // ------------
  
  init?(
    dict: NSDictionary,
    imageLoadingConfig: NSDictionary?,
    onImageDidLoadBlock: ImageDidLoadHandler? = nil
  ){
    guard let urlString = dict["url"] as? String
    else { return nil };
    
    self.urlString = urlString;
    self.url = URL(string: urlString);
    
    self.fallbackImageConfig = {
      guard let rawConfig = dict["fallbackImage"] as? NSDictionary
      else { return nil };
      
      return RNIImageItem(dict: rawConfig);
    }();
    
    self.imageLoadingConfig =
      RNIRemoteURLImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
    
    self.onImageDidLoadBlock = onImageDidLoadBlock;
    
    if self.url != nil {
      self.setup();
      
    } else if self.fallbackImage != nil {
      // B - Failed to construct URL instance from string...
      //     Use fallback image.
      self.state = .LOADED_ERROR();
      
    } else {
      // C - Failed to construct URL instance from string and no fallback image
      //     is available
      return nil;
    };
  };
  
  // MARK: Functions
  // ---------------
  
  private func setup(){
    let cachedImage = self.cachedImage;
    
    let shouldLazyLoad = self.imageLoadingConfig.shouldLazyLoad ?? false;
    let shouldUseCache = self.imageLoadingConfig.shouldCache ?? false;
    
    /// Either:
    /// * A - no cache exists for the provided url string
    /// * B - image caching has been disabled
    let hasCachedImage = shouldUseCache && cachedImage != nil;
    
    let shouldPreloadImage = !shouldLazyLoad && !hasCachedImage;
    
    if shouldPreloadImage {
      // A - Load image in the bg, so it's potentially ready when the image is
      //     accessed later...
      self.loadImage();
      
    } else if hasCachedImage {
      // B - Use the cached image that matched with the provided url
      self.state = .LOADED(image: cachedImage!);
    };
  };
  
  func loadImage(){
    // still has retry attempts remaining, and not currently loading
    let shouldLoad =
      self.shouldRetry && !self.state.isFinalState;
    
    
    func log(_ string: String = ""){
      print("DEBUG - \(string) - loadingAttemptsCount: \(loadingAttemptsCount) - loadImage - URL: \(self.urlString) - state: \(self.state) - _image: \(self._image) - shouldRetry: \(self.shouldRetry)");
    };
    
    guard shouldLoad,
          let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else {
      log("guard fail");
      return;
    };
    
    log("1");
    
    let prevError = self.state.error;
    let hasPrevError = prevError != nil;
    
    self.state = hasPrevError
      // A - Retry loading the remote image
      ? .RETRYING(prevError: prevError!)
      // B - Loading the remote image for the 1st time
      : .LOADING;
    
    log("2");
    
    self.loadingAttemptsCount += 1;
    let prevImage = self._image;
    
    imageLoader.loadImage(with: urlRequest){ [weak self] in
      guard let strongSelf = self else { return };
      
      if let error = $0 {
        strongSelf.state = strongSelf.shouldRetry
          // A - Error Loading - Try again
          ? .LOADED_ERROR(error: error)
          // B - Error Loading - Final attempt
          : .LOADED_ERROR_FINAL(error: error);
        
        let nextImage = strongSelf._image;
        
        log("3");
        
        if !RNIUtilities.compareImages(prevImage, nextImage) {
          DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return };
            
            // failed to load image, but is currently using fallback image, so
            // notify that it's using the fallback image as a substitute
            strongSelf.onImageDidLoadBlock?(false, strongSelf);
            
            log("4");
          };
        };
        
        if strongSelf.imageLoadingConfig._shouldImmediatelyRetryLoading {
          strongSelf.loadImage();
        };
        
      } else if let image = $1 {
        DispatchQueue.main.async { [weak self] in
          guard let strongSelf = self else { return };
          
          strongSelf.state = .LOADED(image: image);
          strongSelf.onImageDidLoadBlock?(true, strongSelf);
          
          if strongSelf.imageLoadingConfig.shouldCache ?? false {
            Self.imageCache[strongSelf.urlString] = image;
          };
          
          log("5");
        };
      };
    };
  };
};

// MARK: - RNIRemoteURLImageLoadingConfig - Defaults
// -------------------------------------------------

fileprivate extension RNIRemoteURLImageLoadingConfig {
  var _shouldLazyLoad: Bool {
    self.shouldLazyLoad ?? false;
  };
  
  var _shouldCache: Bool {
    self.shouldCache ?? false;
  };
  
  var _maxRetryAttempts: Int {
    self.maxRetryAttempts ?? 3;
  };
  
  var _shouldImmediatelyRetryLoading: Bool {
    self.shouldImmediatelyRetryLoading ?? false;
  };
  
  var _fallbackBehavior: FallbackBehavior {
    self.fallbackBehavior ?? .onLoadError;
  };
};
