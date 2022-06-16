//
//  RNIContextMenuAuxiliaryPreviewConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/9/22.
//

import Foundation


struct RNIContextMenuAuxiliaryPreviewConfig {
  
  // MARK: - Nested Types
  // --------------------
  
  enum AnchorPosition: String {
    case top, bottom, automatic;
  };
  
  enum HorizontalAlignment: String {
    case stretchScreen, stretchPreview, previewLeading,
         previewTrailing, previewCenter;
  };
  
  enum TransitionType: String {
    case none, fade, slide, zoom;
  };
  
  struct TransitionConfig {
    
    var transition: TransitionType;
    var duration: CGFloat;
    
    init(dictionary: NSDictionary){
      
      self.transition = {
        guard let string = dictionary["transition"] as? String,
              let value = TransitionType(rawValue: string)
        else { return .fade };
        
        return value;
      }();
      
      self.duration = dictionary["duration"] as? CGFloat ?? 50;
    };
    
    init(){
      self.transition = .fade;
      self.duration = 0.3;
    };
  };
  
  enum TransitionEntranceDelay: Equatable {
    case seconds(CGFloat);
    
    case RECOMMENDED;
    case AFTER_PREVIEW;
    
    init?(string: String){
      switch string {
        case "RECOMMENDED"  : self = .RECOMMENDED;
        case "AFTER_PREVIEW": self = .AFTER_PREVIEW;
          
        default: return nil;
      };
    };
    
    var seconds: CGFloat {
      switch self {
        case .seconds(let seconds):
          return seconds;
          
        case .AFTER_PREVIEW: return 0;
        case .RECOMMENDED  : return 0.25;
      };
    };
  };
  
  // MARK: - Properties
  // ------------------
  
  var height: CGFloat?;

  var anchorPosition: AnchorPosition;
  var alignmentHorizontal: HorizontalAlignment;
  
  var marginPreview: CGFloat;
  var marginAuxiliaryPreview: CGFloat;

  var transitionConfigEntrance: TransitionConfig;
  var transitionEntranceDelay: TransitionEntranceDelay;
  
  // MARK: - Init
  // ------------
  
  init(dictionary: NSDictionary){
    self.height = dictionary["height"] as? CGFloat;
    
    self.anchorPosition = {
      guard let string = dictionary["anchorPosition"] as? String,
            let value = AnchorPosition(rawValue: string)
      else { return .automatic };
      
      return value;
    }();
    
    self.alignmentHorizontal = {
      guard let string = dictionary["alignmentHorizontal"] as? String,
            let value = HorizontalAlignment(rawValue: string)
      else { return .stretchPreview };
      
      return value;
    }();
    
    self.marginPreview =
      dictionary["marginPreview"] as? CGFloat ?? 10;
    
    self.marginAuxiliaryPreview =
      dictionary["marginAuxiliaryPreview"] as? CGFloat ?? 10;
    
    self.transitionConfigEntrance = {
      guard let dict = dictionary["transitionConfigEntrance"] as? NSDictionary
      else { return TransitionConfig() };
      
      return TransitionConfig(dictionary: dict);
    }();
    
    self.transitionEntranceDelay = {
      guard let rawValue = dictionary["transitionEntranceDelay"]
      else { return .AFTER_PREVIEW };
      
      if let string = rawValue as? String,
         let value = TransitionEntranceDelay(string: string) {
        
        return value;
        
      } else if let number = rawValue as? CGFloat {
        return .seconds(number);
      };
      
      return .AFTER_PREVIEW;
    }();
  };
};
