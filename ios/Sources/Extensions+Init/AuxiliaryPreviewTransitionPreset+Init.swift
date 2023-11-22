//
//  AuxiliaryPreviewTransitionPreset+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview

extension AuxiliaryPreviewTransitionPreset {

  private enum Mode: String {
    case none, fade, slide, zoom, zoomAndSlide, custom;
  };
  
  public init?(dict: Dictionary<String, Any>){
    guard let modeString = dict["mode"] as? String,
          let mode = Self.Mode(rawValue: modeString)
    else { return nil };
    
    switch mode {
      case .none:
        self = .none;
        
      case .fade:
        self = .fade;
        
      case .slide:
        let slideOffset = dict["slideOffset"] as? NSNumber ?? 0;
        self = .slide(slideOffset: slideOffset.doubleValue);
        
      case .zoom:
        let zoomOffset = dict["zoomOffset"] as? NSNumber ?? 0;
        self = .zoom(zoomOffset: zoomOffset.doubleValue);
        
      case .zoomAndSlide:
        let slideOffset = dict["slideOffset"] as? NSNumber ?? 0;
        let zoomOffset = dict["zoomOffset"] as? NSNumber ?? 0;
        
        self = .zoomAndSlide(
          slideOffset: slideOffset.doubleValue,
          zoomOffset: zoomOffset.doubleValue
        );
        
      case .custom:
        let keyframeStart: AuxiliaryPreviewTransitionKeyframeConfig? = {
          guard let keyframeStart = dict["keyframeStart"] as? Dictionary<String, Any>
          else { return nil };
          
          return .init(dict: keyframeStart);
        }();
        
        guard let keyframeStart = keyframeStart else { return nil };
        
        let keyframeEnd: AuxiliaryPreviewTransitionKeyframeConfig? = {
          guard let keyframeEnd = dict["keyframeEnd"] as? Dictionary<String, Any>
          else { return nil };
          
          return .init(dict: keyframeEnd);
        }();
      
        self = .custom(
          keyframeStart: keyframeStart,
          keyframeEnd: keyframeEnd
        );
    };
  };
};
