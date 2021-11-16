//
//  RNIMenuImageType.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


@available(iOS 13.0, *)
class RNIMenuIcon {
  
  // MARK: - Nested Types
  // --------------------
  
  struct ImageLoader {
    static var sharedInstance: RCTImageLoader?;
  };
  
  enum IconType: String, CaseIterable, Encodable {
    case NONE;
    case URL;
    case SYSTEM;
    case ASSET;
    case REQUIRE;
  };
  
  // MARK: - Properties
  // ------------------
  
  var iconType: IconType;
  
  var iconValue: Any?;
  var iconSize : CGFloat?;
  var iconTint : UIColor?;
  
  var iconScale : UIImage.SymbolScale;
  var iconWeight: UIImage.SymbolWeight;
  
  private var loadedImage: UIImage?;
  
  // MARK: - Init
  // ------------
  
  init() {
    self.iconType = .NONE;
    self.iconScale = .default;
    self.iconWeight = .regular;
  };
  
  convenience init(type: IconType, value: String){
    self.init();
    
    self.iconType  = type;
    self.iconValue = value;
  };
  
  convenience init(dictionary: NSDictionary){
    self.init();
    
    if let string   = dictionary["iconType"] as? String,
       let iconType = IconType(rawValue: string) {
      
      self.iconType = iconType;
    };
    
    self.iconValue = dictionary["iconValue"];
    
    if let string = dictionary["iconTint"] as? String,
       let color  = UIColor(cssColor: string) {
      
      self.iconTint = color;
    };
    
    // preload `REQUIRE` image
    if self.iconType == .REQUIRE,
       let iconValue   = self.iconValue as? NSDictionary,
       let imageSource = RCTConvert.rctImageSource(iconValue),
       let imageLoader = ImageLoader.sharedInstance {
      
      DispatchQueue.global(qos: .utility).async {
        imageLoader.loadImage(with: imageSource.request) { error, image in
          self.loadedImage = image;
        };
      };
    };
  };
  
  convenience init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
};

// MARK: - Computed Properties
// ---------------------------

@available(iOS 13.0, *)
extension RNIMenuIcon {
  
  /// get `UIImage` based on the `IconType` config
  var image: UIImage? {
    switch self.iconType {
      case .NONE: return nil;
      case .URL : return nil; // to be implemented
      
      case .SYSTEM:
        guard let iconValue = self.iconValue as? String
        else { return nil };
        
        if let iconTint = self.iconTint {
          return UIImage(systemName: iconValue)?
            .withTintColor(iconTint)
            .withRenderingMode(.alwaysOriginal);
          
        } else {
          return UIImage(systemName: iconValue);
        };
        
      case .ASSET:
        guard let iconValue = self.iconValue as? String
        else { return nil };
        return UIImage(named: iconValue);
        
      case .REQUIRE:
        return self.loadedImage;
    };
  };
  
  var dictionary: [String: Any] {
    var dictionary: [String: Any] = [
      "iconType": self.iconType,
    ];
    
    if let iconValue = self.iconValue {
      dictionary["iconValue"] = iconValue;
    };
    
    return dictionary;
  };
};
