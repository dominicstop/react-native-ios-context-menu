//
//  RCTMenuImageType.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation


@available(iOS 13.0, *)
public struct RCTMenuIcon {
  enum IconType: String, CaseIterable, Encodable {
    case NONE;
    case URL;
    case SYSTEM;
    case ASSET;
  };
  
  var iconType : IconType = .NONE;
  var iconValue: String?;
  
  var iconSize: CGFloat?;
  
  var iconTint  : UIColor              = .black;
  var iconScale : UIImage.SymbolScale  = .default;
  var iconWeight: UIImage.SymbolWeight = .regular;
};

// ------------------------
// MARK: RCTMenuIcon - Init
// ------------------------

@available(iOS 13.0, *)
extension RCTMenuIcon {
  init(dictionary: NSDictionary){
    if let string   = dictionary["iconType"] as? String,
       let iconType = IconType(rawValue: string) {
      
      self.iconType = iconType;
    };
    
    if let string = dictionary["iconValue"] as? String {
      self.iconValue = string;
    };
    
    if let string = dictionary["iconTint"] as? String,
       let color  = UIColor(cssColor: string) {
      
      self.iconTint = color;
    };
  };
  
  init?(dictionary: NSDictionary?){
    guard let dictionary = dictionary else { return nil };
    self.init(dictionary: dictionary);
  };
  
  init(type: IconType, value: String){
    self.iconType  = type;
    self.iconValue = value;
  };
};

// -----------------------------------
// MARK: RCTMenuIcon - Private Methods
// -----------------------------------

@available(iOS 13.0, *)
fileprivate extension RCTMenuIcon {
  
};

// ---------------------------------------
// MARK: RCTMenuIcon - Computed Properties
// ---------------------------------------

@available(iOS 13.0, *)
extension RCTMenuIcon {
  
  /// get `UIImage` based on the `IconType` config
  var image: UIImage? {
    switch self.iconType {
      case .NONE: return nil;
      case .URL : return nil; // to be implemented
      
      case .SYSTEM:
        guard let iconValue = self.iconValue else { return nil };
        return UIImage(systemName: iconValue)?
          .withTintColor(self.iconTint)
          .withRenderingMode(.alwaysOriginal);
        
      case .ASSET:
        guard let iconValue = self.iconValue else { return nil };
        return UIImage(named: iconValue);
    };
  };
  
  var dictionary: [AnyHashable: Any] {
    var dictionary: [AnyHashable: Any] = [
      "iconType": self.iconType,
    ];
    
    if let iconValue = self.iconValue {
      dictionary["iconValue"] = iconValue;
    };
    
    return dictionary;
  };
};
