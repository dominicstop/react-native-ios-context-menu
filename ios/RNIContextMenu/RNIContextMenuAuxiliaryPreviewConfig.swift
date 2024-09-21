//
//  RNIContextMenuAuxiliaryPreviewConfig.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 2/9/22.
//

import Foundation
import UIKit


// MARK: Deprecated
public struct RNIContextMenuAuxiliaryPreviewConfig {
  
  // MARK: - Nested Types
  // --------------------
  
  public enum AnchorPosition: String {
    case top, bottom, automatic;
  };
  
  public enum HorizontalAlignment: String {
    case stretchScreen, stretchPreview;
    case previewLeading, previewTrailing, previewCenter;
  };
  
  public enum TransitionType {
    case none, fade;
    
    case slide(slideOffset: CGFloat);
    case zoom(zoomOffset: CGFloat);
    case zoomAndSlide(slideOffset: CGFloat, zoomOffset: CGFloat);
  };
  
  public struct TransitionConfig {
    
    public var transition: TransitionType;
    
    // MARK: UIView.Animate Config
    
    public var duration: CGFloat;
    public var delay: CGFloat;
    public var options: UIView.AnimationOptions;
    
    public init(dictionary: Dictionary<String, Any>){
      
      self.transition = {
        guard let string = dictionary["transition"] as? String
        else { return .fade };
        
        let getSlideOffset = {
          return dictionary["slideOffset"] as? CGFloat ?? 50;
        };
        
        let getZoomOffset = {
          return dictionary["zoomOffset"] as? CGFloat ?? 0.3;
        };
        
        switch string {
          case "none":
            return .none;
            
          case "fade":
            return .fade;
            
          case "slide":
            return .slide(slideOffset: getSlideOffset());
            
          case "zoom":
            return .zoom(zoomOffset: getZoomOffset());
            
          case "zoomAndSlide":
            return .zoomAndSlide(
              slideOffset: getSlideOffset(),
              zoomOffset: getZoomOffset()
            );
            
          default:
            return .fade;
        };
      }();
      
      self.duration = dictionary["duration"] as? CGFloat ?? 0.3;
      
      self.delay = dictionary["delay"] as? CGFloat ?? 0;
      
      self.options = {
        guard let rawItems = dictionary["options"] as? Array<Any>
        else { return [] };
        
        // workaround for: "Generic parameter 'ElementOfResult'
        // could not be inferred" when using `compactMap`
        var options: UIView.AnimationOptions = [];
        
        for rawItem in rawItems {
          if let string = rawItem as? String,
             let option = UIView.AnimationOptions(string: string) {
            
            options.insert(option);
          };
        };
        
        return options;
      }();
    };
    
    public init(){
      self.transition = .fade;
      self.duration = 0.3;
      self.delay = 0;
      self.options = [];
    };
  };
  
  public enum TransitionEntranceDelay: Equatable {
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
    
    public var seconds: CGFloat {
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
  
  public var height: CGFloat?;
  public var width: CGFloat?;

  public var anchorPosition: AnchorPosition;
  public var alignmentHorizontal: HorizontalAlignment;
  
  public var marginPreview: CGFloat;
  public var marginAuxiliaryPreview: CGFloat;

  public var transitionConfigEntrance: TransitionConfig;
  public var transitionEntranceDelay: TransitionEntranceDelay;
  
  // MARK: - Init
  // ------------
  
  public init(dictionary: Dictionary<String, Any>){
    self.height = dictionary["height"] as? CGFloat;
    self.width  = dictionary["width" ] as? CGFloat;
    
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
      guard let dict = dictionary["transitionConfigEntrance"] as? Dictionary<String, Any>
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
