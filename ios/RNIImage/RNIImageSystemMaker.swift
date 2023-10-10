//
//  RNIImageSystemMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/26/22.
//

import Foundation
import UIKit


internal struct RNIImageSystemMaker {
  let systemName: String;
  
  let pointSize: CGFloat?;
  let weight: String?;
  let scale: String?;
  
  let hierarchicalColor: UIColor?;
  let paletteColors: [UIColor]?;
  
  @available(iOS 13.0, *)
  var symbolConfigs: [UIImage.SymbolConfiguration] {
    var configs: [UIImage.SymbolConfiguration] = [];
    
    if let pointSize = self.pointSize {
      configs.append( .init(pointSize: pointSize) );
    };
    
    if let string = self.weight,
       let weight = UIImage.SymbolWeight(string: string) {
      
      configs.append( .init(weight: weight) );
    };
    
    if let string = self.scale,
       let scale = UIImage.SymbolScale(string: string) {
      
      configs.append( .init(scale: scale) );
    };
    
    #if swift(>=5.5)
    if #available(iOS 15.0, *),
       let color = self.hierarchicalColor {
      
      configs.append( .init(hierarchicalColor: color) );
    };
    
    if #available(iOS 15.0, *),
       let colors = self.paletteColors {
      
      configs.append( .init(paletteColors: colors) );
    };
    #endif
    
    return configs;
  };
  
  @available(iOS 13.0, *)
  var symbolConfig: UIImage.SymbolConfiguration? {
    var combinedConfig: UIImage.SymbolConfiguration?;
    
    for config in symbolConfigs {
      if let prevCombinedConfig = combinedConfig {
        combinedConfig = prevCombinedConfig.applying(config);
        
      } else {
        combinedConfig = config;
      };
    };
    
    return combinedConfig;
  };
  
  @available(iOS 13.0, *)
  var image: UIImage? {
    if let symbolConfig = symbolConfig {
      return UIImage(
        systemName: self.systemName,
        withConfiguration: symbolConfig
      );
    };
    
    return UIImage(systemName: self.systemName);
  };
  
  init?(dict: NSDictionary){
    guard let systemName = dict["systemName"] as? String
    else { return nil };
    
    self.systemName = systemName;
    
    self.pointSize = dict["pointSize"] as? CGFloat;
    self.weight    = dict["weight"   ] as? String;
    self.scale     = dict["scale"    ] as? String;

    self.hierarchicalColor = {
      guard let value = dict["hierarchicalColor"],
            let color = UIColor.parseColor(value: value)
      else { return nil };
      
      return color;
    }();
    
    self.paletteColors = {
      guard let items = dict["paletteColors"] as? Array<Any>
      else { return nil };
      
      return items.compactMap { UIColor.parseColor(value: $0) };
    }();
  };
};

