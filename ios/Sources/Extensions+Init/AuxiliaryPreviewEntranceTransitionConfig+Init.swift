//
//  AuxiliaryPreviewEntranceTransitionConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ContextMenuAuxiliaryPreview

extension AuxiliaryPreviewEntranceTransitionConfig {

  private enum Mode: String  {
    case syncedToMenuEntranceTransition;
    case customDelay;
    case afterMenuEntranceTransition;
  };
  
  public init?(dict: Dictionary<String, Any>){
    guard let modeString = dict["mode"] as? String,
          let mode = Self.Mode(rawValue: modeString)
    else { return nil };
    
    switch mode {
      case .syncedToMenuEntranceTransition:
        guard let shouldAnimateSize = dict["shouldAnimateSize"] as? Bool
        else { return nil };
        
        self = .syncedToMenuEntranceTransition(
          shouldAnimateSize: shouldAnimateSize
        );
        
      case .customDelay:
        guard let configRaw = dict["config"] as? Dictionary<String, Any>,
              let config = AuxiliaryPreviewTransitionAnimationConfig(dict: configRaw)
        else { return nil };
        
        self = .customDelay(config);
        
      case .afterMenuEntranceTransition:
        guard let configRaw = dict["config"] as? Dictionary<String, Any>,
              let config = AuxiliaryPreviewTransitionAnimationConfig(dict: configRaw)
        else { return nil };
        
        self = .afterMenuEntranceTransition(config);
    };
  };
};
