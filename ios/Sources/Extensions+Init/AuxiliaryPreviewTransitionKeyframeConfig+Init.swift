//
//  AuxiliaryPreviewTransitionKeyframeConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview

extension AuxiliaryPreviewTransitionKeyframeConfig {
  
  public init(dict: Dictionary<String, Any>){
    self.opacity = {
      guard let value = dict["opacity"] as? NSNumber else { return nil };
      return value.doubleValue;
    }();
    
    self.transform = {
      guard let transformDict = dict["transform"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: transformDict);
    }();
    
    self.auxiliaryPreviewPreferredWidth = {
      guard let dict = dict["auxiliaryPreviewPreferredWidth"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
    
    self.auxiliaryPreviewPreferredHeight = {
      guard let dict = dict["auxiliaryPreviewPreferredHeight"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
  };
};
