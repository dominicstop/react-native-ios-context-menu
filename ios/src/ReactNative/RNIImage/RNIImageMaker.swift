//
//  RNIImageMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/26/22.
//

import Foundation
import UIKit


internal struct RNIImageMaker {

  let size        : CGSize;
  let fillColor   : UIColor;
  let borderRadius: CGFloat;
  
  init(
    size: CGSize,
    fillColor: UIColor,
    borderRadius: CGFloat
  ) {
    self.size = size;
    self.fillColor = fillColor;
    self.borderRadius = borderRadius;
  };
  
  init?(dict: NSDictionary) {
    guard let width  = dict["width" ] as? CGFloat,
          let height = dict["height"] as? CGFloat
    else { return nil };
    
    self.size = CGSize(width: width, height: height);
    
    guard let fillColorValue = dict["fillColor" ],
          let fillColor      = UIColor.parseColor(value: fillColorValue)
    else { return nil };
    
    self.fillColor = fillColor;
    
    self.borderRadius = dict["borderRadius"] as? CGFloat ?? 0;
  };

  func makeImage() -> UIImage {
    return UIGraphicsImageRenderer(size: self.size).image { context in
      let rect = CGRect(origin: .zero, size: self.size);
      
      let clipPath = UIBezierPath(
        roundedRect : rect,
        cornerRadius: self.borderRadius
      );
      
      clipPath.addClip();
      self.fillColor.setFill();
      
      context.fill(rect);
    };
  };
};
