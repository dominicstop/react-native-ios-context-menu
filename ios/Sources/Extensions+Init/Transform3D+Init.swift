//
//  Transform3D+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import DGSwiftUtilities

extension Transform3D {

  init(dict: Dictionary<String, Any>) {
    self.init(
      translateX: {
        guard let value = dict["translateX"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      translateY: {
        guard let value = dict["translateY"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      translateZ: {
        guard let value = dict["translateZ"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      scaleX: {
        guard let value = dict["scaleX"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      scaleY: {
        guard let value = dict["scaleY"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      rotateX: {
        guard let dict = dict["rotateX"] as? Dictionary<String, Any>
        else { return nil };
        
        return Angle(dict: dict);
      }(),
      
      rotateY: {
        guard let dict = dict["rotateY"] as? Dictionary<String, Any>
        else { return nil };
        
        return Angle(dict: dict);
      }(),
      
      rotateZ: {
        guard let dict = dict["rotateZ"] as? Dictionary<String, Any>
        else { return nil };
        
        return Angle(dict: dict);
      }(),
      
      perspective: {
        guard let value = dict["perspective"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      skewX: {
        guard let value = dict["skewX"] as? NSNumber else { return nil };
        return value.doubleValue;
      }(),
      
      skewY: {
        guard let value = dict["skewY"] as? NSNumber else { return nil };
        return value.doubleValue;
      }()
    );
  };
};
