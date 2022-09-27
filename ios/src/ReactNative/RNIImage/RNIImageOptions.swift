//
//  RNIImageOptions.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/28/22.
//

import Foundation


struct RNIImageOptions {
  let tint: UIColor?;
  let renderingMode: UIImage.RenderingMode;
  let cornerRadius: CGFloat?;
  
  init(dict: NSDictionary){
    self.tint = {
      guard let value = dict["tint"],
            let color = UIColor.parseColor(value: value)
      else { return nil };
      
      return color;
    }();
    
    self.renderingMode = {
      guard let string = dict["renderingMode"] as? String,
            let mode   = UIImage.RenderingMode(string: string)
      else { return .automatic };
      
      return mode;
    }();
    
    self.cornerRadius = dict["cornerRadius"] as? CGFloat;
  };
};
