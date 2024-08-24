//
//  RNIMenuItem.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/23/20.
//

import UIKit;
import react_native_ios_utilities


@available(iOS 13.0, *)
public class RNIMenuItem: RNIMenuElement {
  
  // MARK: - Serialized Properties
  // -----------------------------
  
  public var menuTitle: String;
  public var menuSubtitle: String?;
  
  public var menuOptions: [String]?;
  public var menuPreferredElementSize: String?;
  
  public var icon: RNIImageItem?;
  public var menuItems: [RNIMenuElement]?;
  
  // MARK: - Properties
  // ------------------
  
  public var shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle = true;
  
  // MARK: - Init
  // ------------

  public override init?(dictionary: Dictionary<String, Any>){
    guard let menuTitle = dictionary["menuTitle"] as? String
    else { return nil };
    
    self.menuTitle = menuTitle;
    super.init(dictionary: dictionary);
    
    self.menuSubtitle = dictionary["menuSubtitle"] as? String;

    self.menuOptions = dictionary["menuOptions"] as? [String];
    self.menuPreferredElementSize = dictionary["menuPreferredElementSize"] as? String;
    
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
    
    if let menuElements = dictionary["menuItems"] as? NSArray {
      self.menuItems = menuElements.compactMap {
        guard let dictItem = $0 as? Dictionary<String, Any> else { return nil };
        
        let menuElement: RNIMenuElement? =
             RNIMenuItem(dictionary: dictItem)
          ?? RNIMenuActionItem(dictionary: dictItem)
          ?? RNIDeferredMenuElement(dictionary: dictItem);
        
        menuElement?.parent = self;
        return menuElement;
      };
    };
    
    self.setup();
  };
};

// MARK: - Computed Properties
// ---------------------------

@available(iOS 13.0, *)
extension RNIMenuItem {
  
  /// get `UIMenu.Options` from `menuOptions` strings
  public var synthesizedMenuOptions: UIMenu.Options {
    UIMenu.Options(
      self.menuOptions?.compactMap {
        UIMenu.Options(string: $0);
      } ?? []
    );
  };
  
  #if !targetEnvironment(macCatalyst)
  #if swift(>=5.7)
  @available(iOS 16.0, *)
  public var synthesizedPreferredMenuElementSize: UIMenu.ElementSize? {
    guard let menuPreferredElementSize = self.menuPreferredElementSize
    else { return nil };
    
    return UIMenu.ElementSize(string: menuPreferredElementSize);
  };
  #endif
  #endif
};

// MARK: - Functions
// -----------------

@available(iOS 13.0, *)
extension RNIMenuItem {
  public func createMenu(
    actionItemHandler      actionHandler  : @escaping RNIMenuActionItem.ActionItemHandler,
    deferredElementHandler deferredHandler: @escaping RNIDeferredMenuElement.RequestHandler
  ) -> UIMenu {
    
    let menuItems: [UIMenuElement]? = self.menuItems?.compactMap {
      $0.createMenuElement(
        actionItemHandler: actionHandler,
        deferredElementHandler: deferredHandler
      );
    };
    
    let menu: UIMenu = UIMenu(
      title: self.menuTitle,
      image: self.icon?.image,
      identifier: nil, 
      options: self.synthesizedMenuOptions,
      children: menuItems ?? []
    );
    
    #if swift(>=5.5)
    if #available(iOS 15.0, *),
       let subtitle = self.menuSubtitle {
      
      menu.subtitle = subtitle;
    };
    #endif
    
    #if !targetEnvironment(macCatalyst)
    #if swift(>=5.7)
    if #available(iOS 16.0, *),
       let preferredElementSize = self.synthesizedPreferredMenuElementSize {
      
      menu.preferredElementSize = preferredElementSize;
    };
    #endif
    #endif
    
    return menu;
  };
};

// MARK: - Private Functions
// -------------------------

@available(iOS 13, *)
extension RNIMenuItem {
  
  private func setup(){
    if case let .IMAGE_REMOTE_URL(imageConfig) = self.icon?.imageConfig {
      imageConfig.onImageDidLoadBlock = { [weak self] _,_ in
        guard let strongSelf = self else { return };
        strongSelf.notifyOnMenuElementUpdateRequest(for: strongSelf);
      };
    };
  };
};
