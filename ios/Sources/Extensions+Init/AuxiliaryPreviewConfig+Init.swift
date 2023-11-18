//
//  AuxiliaryPreviewConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/18/23.
//

import Foundation
import ContextMenuAuxiliaryPreview
import DGSwiftUtilities

extension AuxiliaryPreviewConfig {
  
  /// For backwards compatibility
  /// Init. using deprecated config `RNIContextMenuAuxiliaryPreviewConfig`
  public init(config: RNIContextMenuAuxiliaryPreviewConfig){
    let verticalAnchorPosition: VerticalAnchorPositionMode = {
      switch config.anchorPosition {
        case .top:
          return .top;
          
        case .bottom:
          return .bottom;
          
        case .automatic:
          return .automatic;
      };
    }();
    
    let horizontalAlignment: HorizontalAlignmentPosition = {
      switch config.alignmentHorizontal {
        case .stretchScreen:
          return .stretch;
          
        case .stretchPreview:
          return .stretchTarget;
          
        case .previewLeading:
          return .targetLeading;
          
        case .previewTrailing:
          return .targetTrailing;
          
        case .previewCenter:
          return .targetCenter;
      };
    }();
    
    let transitionConfigEntrance: AuxiliaryPreviewEntranceTransitionConfig = {
      
      let transitionPreset: AuxiliaryPreviewTransitionPreset = {
        switch config.transitionConfigEntrance.transition {
          case .none:
            return .none;
          
          case .fade:
            return .fade;
            
          case let .slide(slideOffset):
            return .slide(slideOffset: slideOffset);
          
          case let .zoom(zoomOffset):
            return .zoom(zoomOffset: zoomOffset);
          
          case let .zoomAndSlide(slideOffset, zoomOffset):
            return .zoomAndSlide(
              slideOffset: slideOffset,
              zoomOffset: zoomOffset
            );
        };
      }();
      
      let animationCurve: UIView.AnimationCurve = {
        let transitionOptions = config.transitionConfigEntrance.options;
        
        if transitionOptions.contains(.curveEaseIn){
          return .easeIn;
        };
        
        if transitionOptions.contains(.curveEaseOut){
          return .easeOut;
        };
        
        if transitionOptions.contains(.curveEaseInOut){
          return .easeInOut;
        };
        
        return .linear;
      }();
      
      let animatorConfig: AnimationConfig = .presetCurve(
        duration: config.transitionConfigEntrance.duration,
        curve: animationCurve
      );
      
      var entranceTransitionConfig = AuxiliaryPreviewTransitionAnimationConfig(
        delay: 0,
        animatorConfig: animatorConfig,
        transitionPreset: transitionPreset
      );
    
      switch config.transitionEntranceDelay {
        case .AFTER_PREVIEW:
          return .afterMenuEntranceTransition(entranceTransitionConfig);
          
        case .RECOMMENDED:
          entranceTransitionConfig.delay = config.transitionEntranceDelay.seconds;
          return .customDelay(entranceTransitionConfig);
        
        case let .seconds(seconds):
          entranceTransitionConfig.delay = seconds;
          return .customDelay(entranceTransitionConfig);
      };
    }();
    
    self.init(
      verticalAnchorPosition: verticalAnchorPosition,
      horizontalAlignment: horizontalAlignment,
      marginInner: config.marginPreview,
      marginOuter: config.marginAuxiliaryPreview,
      transitionConfigEntrance: transitionConfigEntrance,
      transitionExitPreset: .zoomAndSlide(
        slideOffset: 50,
        zoomOffset: 0.7
      )
    );
  };
};
