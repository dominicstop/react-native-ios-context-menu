//
//  AnimationConfig+Init.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 11/22/23.
//

import Foundation
import ReactNativeIosUtilities
import DGSwiftUtilities

extension AnimationConfig {
  
  private enum Mode: String {
    case animator;
    case presetCurve;
    case presetSpring;
    case bezierCurve;
    case springDamping;
    case springPhysics;
    case springGesture;
  };
  
  init?(dict: Dictionary<String, Any>) {
    guard let modeString = dict["mode"] as? String,
          let mode = Self.Mode(rawValue: modeString)
    else { return nil };
    
    switch mode {
      case .animator:
        // Not supported
        return nil;
        
      case .presetCurve:
        guard let duration = dict["duration"] as? NSNumber,
              let curveString = dict["curve"] as? String,
              let curve = UIView.AnimationCurve(string: curveString)
        else { return nil };
        
        self = .presetCurve(
          duration: duration.doubleValue,
          curve: curve
        );
        
      case .presetSpring:
        guard let duration = dict["duration"] as? NSNumber,
              let dampingRatio = dict["curve"] as? NSNumber
        else { return nil };
        
        self = .presetSpring(
          duration: duration.doubleValue,
          dampingRatio: dampingRatio.doubleValue
        );
        
      case .bezierCurve:
        guard let duration = dict["duration"] as? NSNumber else { return nil };
        
        let controlPoint1: CGPoint? = {
          guard let dict = dict["controlPoint1"] as? Dictionary<String, Any>
          else { return nil };
          
          return .init(dict: dict);
        }();
        
        let controlPoint2: CGPoint? = {
          guard let dict = dict["controlPoint2"] as? Dictionary<String, Any>
          else { return nil };
          
          return .init(dict: dict);
        }();
        
        guard let controlPoint1 = controlPoint1,
              let controlPoint2 = controlPoint2
        else { return nil };
        
        self = .bezierCurve(
          duration: duration.doubleValue,
          controlPoint1: controlPoint1,
          controlPoint2: controlPoint2
        );
        
      case .springDamping:
        guard let duration = dict["duration"] as? NSNumber,
              let dampingRatio = dict["dampingRatio"] as? NSNumber
        else { return nil };
        
        let initialVelocity: CGVector? = {
          guard let dict = dict["initialVelocity"] as? Dictionary<String, Any> else { return nil };
          return .init(dict: dict);
        }();
        
        let maxVelocity = dict["maxVelocity"] as? NSNumber;
      
        self = .springDamping(
          duration: duration.doubleValue,
          dampingRatio: dampingRatio.doubleValue,
          initialVelocity: initialVelocity,
          maxVelocity: maxVelocity?.doubleValue as? CGFloat
        );
        
      case .springPhysics:
        guard let duration = dict["duration"] as? NSNumber,
              let mass = dict["mass"] as? NSNumber,
              let stiffness = dict["stiffness"] as? NSNumber,
              let damping = dict["damping"] as? NSNumber
        else { return nil };
        
        let initialVelocity: CGVector? = {
          guard let dict = dict["initialVelocity"] as? Dictionary<String, Any> else { return nil };
          return .init(dict: dict);
        }();
        
        let maxVelocity = dict["maxVelocity"] as? NSNumber;
        
        self = .springPhysics(
          duration: duration.doubleValue,
          mass: mass.doubleValue,
          stiffness: stiffness.doubleValue,
          damping: damping.doubleValue,
          initialVelocity: initialVelocity,
          maxVelocity: maxVelocity?.doubleValue as? CGFloat
        );
        
      case .springGesture:
        guard let duration = dict["duration"] as? NSNumber,
              let dampingRatio = dict["dampingRatio"] as? NSNumber,
              let maxGestureVelocity = dict["maxGestureVelocity"] as? NSNumber
        else { return nil };
        
        self = .springGesture(
          duration: duration.doubleValue,
          dampingRatio: dampingRatio.doubleValue,
          maxGestureVelocity: maxGestureVelocity.doubleValue
        );
    };
  };
};
