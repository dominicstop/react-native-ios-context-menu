//
//  AuxiliaryPreviewTransitionAnimationConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview
import DGSwiftUtilities


extension AuxiliaryPreviewTransitionAnimationConfig {
  
  init?(dict: Dictionary<String, Any>){
    let delay: TimeInterval = {
      guard let value = dict["delay"] as? NSNumber else { return 0 };
      return value.doubleValue;
    }();
    
    let animatorConfig: AnimationConfig? = {
      guard let dict = dict["animatorConfig"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
    
    let transitionPreset: AuxiliaryPreviewTransitionPreset? = {
      guard let dict = dict["transitionPreset"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
    
    guard let animatorConfig = animatorConfig,
          let transitionPreset = transitionPreset
    else { return nil };
    
    self.init(
      delay: delay,
      animatorConfig: animatorConfig,
      transitionPreset: transitionPreset
    );
  };
};
