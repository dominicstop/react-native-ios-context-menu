//
//  AuxiliaryPreviewTransitionKeyframeConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview
import DGSwiftUtilities

extension AuxiliaryPreviewTransitionKeyframeConfig {
  
  public init(dict: Dictionary<String, Any>){
  
    let opacity: CGFloat? = {
      guard let value = dict["opacity"] as? NSNumber else { return nil };
      return value.doubleValue;
    }();
    
    let transform: Transform3D? = {
      guard let transformDict = dict["transform"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: transformDict);
    }();
    
    let auxiliaryPreviewPreferredWidth: AuxiliaryPreviewSizeValue? = {
      guard let dict = dict["auxiliaryPreviewPreferredWidth"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
    
    let auxiliaryPreviewPreferredHeight: AuxiliaryPreviewSizeValue? = {
      guard let dict = dict["auxiliaryPreviewPreferredHeight"] as? Dictionary<String, Any>
      else { return nil };
      
      return .init(dict: dict);
    }();
    
    self.init(
      opacity: opacity,
      transform: transform,
      auxiliaryPreviewPreferredWidth: auxiliaryPreviewPreferredWidth,
      auxiliaryPreviewPreferredHeight: auxiliaryPreviewPreferredHeight
    );
  };
};
