//
//  RNIMenuActionItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//

import UIKit;
import react_native_ios_utilities


@available(iOS 13, *)
public class RNIMenuActionItem: RNIMenuElement {
  
  // MARK: - Serialized Properties
  // -----------------------------
  
  public var actionKey: String;
  public var actionTitle: String;
  
  public var actionSubtitle: String?;
  
  public var icon: RNIImageItem?;
  public var discoverabilityTitle: String?;
  
  public var menuState: String?;
  public var menuAttributes: [String]?;
  
  // MARK: - Properties
  // ------------------
  
  var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  // MARK: - Init
  // ------------

  override init?(dictionary: Dictionary<String, Any>){
    guard let actionKey   = dictionary["actionKey"  ] as? String,
          let actionTitle = dictionary["actionTitle"] as? String
    else { return nil };
    
    self.actionKey   = actionKey;
    self.actionTitle = actionTitle;
    
    super.init(dictionary: dictionary);
    
    if let subtitle = dictionary["actionSubtitle"] as? String {
      self.actionSubtitle = subtitle;
    };
    
    self.icon = {
      if let dict = dictionary["icon"] as? Dictionary<String, Any> {
        /// A. `ImageItemConfig` or legacy `IconConfig`
        return RNIImageItem(dict: dict) ??
          RNIMenuIcon.convertLegacyIconConfigToImageItemConfig(dict: dict);
        
      } else if let type  = dictionary["iconType" ] as? String,
                let value = dictionary["iconValue"] as? String {
        
        /// B. legacy `IconConfig`:  icon config shorthand/shortcut  (remove in the future)
        return RNIMenuIcon.convertLegacyIconConfigToImageItemConfig(dict: [
          "iconType" : type,
          "iconValue": value
        ]);
      
      } else if let type  = dictionary["imageType" ] as? String,
                let value = dictionary["imageValue"] as? String {
        /// C. legacy `IconConfig`:  old icon config  (remove in the future)
        return RNIMenuIcon.convertLegacyIconConfigToImageItemConfig(dict: [
          "iconType" : type,
          "iconValue": value
        ]);
        
      } else {
        return nil;
      };
    }();
    
    self.discoverabilityTitle = dictionary["discoverabilityTitle"] as? String;
    
    self.menuState      = dictionary["menuState"     ] as? String;
    self.menuAttributes = dictionary["menuAttributes"] as? [String];
    
    self.setup();
  };
};


// MARK: - Computed Properties
// ---------------------------

@available(iOS 13, *)
extension RNIMenuActionItem {
  
  var synthesizedMenuElementAttributes: UIMenuElement.Attributes {
    UIMenuElement.Attributes(
      self.menuAttributes?.compactMap {
        UIMenuElement.Attributes(string: $0);
      } ?? []
    );
  };
  
  var synthesizedMenuElementState: UIMenuElement.State {
    guard
      let menuState        = self.menuState,
      let menuElementState = UIMenuElement.State(string: menuState)
    else { return .off };
    
    return menuElementState;
  };
  
  var synthesizedIdentifier: UIAction.Identifier {
    UIAction.Identifier(self.actionKey);
  };
  
  var fallbackActionSubtitle: String? {
    self.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle
      ? self.discoverabilityTitle : nil;
  };
  
  var fallbackDiscoverabilityTitle: String? {
    let majorOSVersion = ProcessInfo().operatingSystemVersion.majorVersion;
    
    return majorOSVersion < 15
      ? self.actionSubtitle
      : nil;
  };
  
  /// Creates a dictionary containing all the raw values that was used to create this `RNIMenuActionItem`
  /// instance. The dictionary created will be suitable for sending it back to js/react (e.g. usually through an
  /// event or promise callback).
  var dictionaryFromRawValues: [String: Any] {
    var dictionary: [String: Any] = [
      "actionKey"  : self.actionKey  ,
      "actionTitle": self.actionTitle,
    ];
    
    if let icon = self.icon {
      dictionary["icon"] = icon.dictionary;
    };
    
    if let discoverabilityTitle = self.discoverabilityTitle {
      dictionary["discoverabilityTitle"] = discoverabilityTitle;
    };
    
    if let menuAttributes = self.menuAttributes {
      dictionary["menuAttributes"] = menuAttributes;
    };
    
    if let menuState = self.menuState {
      dictionary["menuState"] = menuState;
    };
    
    return dictionary;
  };
};

// MARK: - Functions
// -----------------

@available(iOS 13, *)
extension RNIMenuActionItem {
  
  public typealias ActionItemHandler = ([String: Any], UIAction) -> Void;
  
  public func createAction(handler: @escaping ActionItemHandler) -> UIAction {    
    let action = UIAction(
      title     : self.actionTitle,
      image     : self.icon?.image,
      identifier: self.synthesizedIdentifier,
      
      discoverabilityTitle:
           self.discoverabilityTitle
        ?? self.fallbackDiscoverabilityTitle,
      
      attributes: self.synthesizedMenuElementAttributes,
      state     : self.synthesizedMenuElementState,
      
      handler: {
        handler(self.dictionaryFromRawValues, $0)
      }
    );
    
    #if swift(>=5.5)
    if #available(iOS 15.0, *) {
      action.subtitle =
           self.actionSubtitle
        ?? self.fallbackActionSubtitle;
    };
    #endif
    
    return action;
  };
};

// MARK: - Private Functions
// -------------------------

@available(iOS 13, *)
extension RNIMenuActionItem {
  
  private func setup(){
    if case let .IMAGE_REMOTE_URL(imageConfig) = self.icon?.imageConfig {
      imageConfig.onImageDidLoadBlock = { [weak self] _,_ in
        guard let strongSelf = self else { return };
        strongSelf.notifyOnMenuElementUpdateRequest(for: strongSelf);
      };
    };
  };
};
