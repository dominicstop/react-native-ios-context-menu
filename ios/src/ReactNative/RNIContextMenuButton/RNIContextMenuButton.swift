//
//  RNIContextMenuButton.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/28/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit;


@available(iOS 14, *)
class RNIContextMenuButton: UIButton {
  
  // MARK: - Properties
  // ------------------
  
  weak var bridge: RCTBridge!;
  
  var isContextMenuVisible = false;
  var didPressMenuItem     = false;
  
  weak var contextMenuViewController: RNINavigationEventsReportingViewController?;
  
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
  // MARK: Properties - Feature Flags
  private var shouldEnableCleanup = false;
  
  
  // MARK: - RN Exported Event Props
  // -------------------------------
  
  @objc var onMenuWillShow  : RCTBubblingEventBlock?;
  @objc var onMenuWillHide  : RCTBubblingEventBlock?;
  @objc var onMenuWillCancel: RCTBubblingEventBlock?;
  
  @objc var onMenuDidShow  : RCTBubblingEventBlock?;
  @objc var onMenuDidHide  : RCTBubblingEventBlock?;
  @objc var onMenuDidCancel: RCTBubblingEventBlock?;
  
  @objc var onPressMenuItem: RCTBubblingEventBlock?;

  // MARK: - RN Exported Props
  // -------------------------
    
  @objc var menuConfig: NSDictionary? {
    didSet {
      guard
        let menuConfig     = self.menuConfig, menuConfig.count > 0,
        let rootMenuConfig = RNIMenuItem(dictionary: menuConfig)
      else { return };
      
      #if DEBUG
      print("RNIContextMenuButton"
        + " - menuConfig didSet"
        + " - RNIMenuItem init"
      );
      #endif
     
      let rootMenu = rootMenuConfig.createMenu(
        actionItemHandler: { (dict, action) in
          self.didPressMenuItem = true;
          self.onPressMenuItem?(dict);
          
        }, deferredElementHandler: { (deferredID, completion) in
          // TODO
        }
      );
      
      if self.isContextMenuVisible,
         let interaction: UIContextMenuInteraction = self.contextMenuInteraction {
        
        // context menu is open, update the menu items
        interaction.updateVisibleMenu {(menu: UIMenu) in
          return rootMenu;
        };
        
      } else {
        // set menu property
        self.menu = rootMenu;
      };
    }
  };
  
  @objc var isMenuPrimaryAction: Bool = false {
    didSet {
      guard self.isMenuPrimaryAction != oldValue else { return };
      self.showsMenuAsPrimaryAction = self.isMenuPrimaryAction;
    }
  };
  
  @objc var enableContextMenu: Bool = true {
    didSet {
      guard self.enableContextMenu != oldValue else { return };
      self.isContextMenuInteractionEnabled = self.isMenuPrimaryAction;
    }
  };
  
  // MARK: - Init
  // ------------
  
  init(bridge: RCTBridge) {
    super.init(frame: CGRect());
    self.bridge = bridge;
    
    self.setupAddContextMenuInteraction();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  public override func didMoveToWindow() {
    if self.window == nil,
       !self.didAttachToParentVC {
      
      // not using UINavigationController... manual cleanup
      self.cleanup();
      
    } else if !self.didAttachToParentVC {
      
      // setup - might be using UINavigationController, attach as child vc
      self.attachToParentVC();
    };
  };
};

// MARK: - Private Functions
// -------------------------

@available(iOS 14, *)
private extension RNIContextMenuButton {
  
  /// Add a context menu interaction to button
  func setupAddContextMenuInteraction(){
    self.isEnabled = true;
    self.isUserInteractionEnabled = true;
    
    let gesture = UIGestureRecognizer();
    gesture.cancelsTouchesInView = true;
    gesture.delegate = self;
    
    self.addAction( UIAction(title: ""){ action in
      print("menuActionTriggered");
      // TODO: wip
    }, for: .menuActionTriggered);
  };
};
  
// MARK: - Functions For Manager
// -----------------------------

@available(iOS 14, *)
extension RNIContextMenuButton {
  @objc func dissmissMenu(){
    self.contextMenuInteraction?.dismissMenu();
  };
};

// MARK: - UIContextMenuInteractionDelegate
// ----------------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton {
  
  // context menu display begins
  override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    super.contextMenuInteraction(interaction, willDisplayMenuFor: configuration, animator: animator);
    
    #if DEBUG
    print("RNIContextMenuButton, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will show"
    );
    #endif

    self.isContextMenuVisible = true;
    
    self.onMenuWillShow?([:]);
    animator?.addCompletion {
      self.onMenuDidShow?([:]);
    };
  };
  
  // context menu display ends
  override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    super.contextMenuInteraction(interaction, willEndFor: configuration, animator: animator);
    
    #if DEBUG
    print("RNIContextMenuButton, UIContextMenuInteractionDelegate"
      + " - contextMenuInteraction: will hide"
    );
    #endif
    
    guard self.isContextMenuVisible else { return };
    
    self.onMenuWillHide?([:]);
    if !self.didPressMenuItem {
      self.onMenuWillCancel?([:]);
    };
    
    animator?.addCompletion {
      if !self.didPressMenuItem {
        self.onMenuDidCancel?([:]);
      };
      
      self.onMenuDidHide?([:]);
      self.didPressMenuItem = false;
    };
    
    self.isContextMenuVisible = false;
  };
};

// MARK: - UIGestureRecognizerDelegate
// -----------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return true;
  };
};

// MARK: - RNINavigationEventsNotifiable
// ----------------------

@available(iOS 14, *)
extension RNIContextMenuButton: RNINavigationEventsNotifiable {
  
  func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController) {
    // trigger cleanup
    self.cleanup();
    self.detachFromParentVC();
  };
  
  func attachToParentVC(){
    guard !self.didAttachToParentVC,
          // find the nearest parent view controller
          let parentVC = RNIUtilities
            .getParent(responder: self, type: UIViewController.self)
    else { return };
    
    self.didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.parentVC = parentVC;
    
    self.contextMenuViewController = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
  };
  
  func detachFromParentVC(){
    guard !self.didAttachToParentVC,
          let childVC = self.contextMenuViewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
  };
};

// MARK: - RNICleanable
// --------------------

@available(iOS 14, *)
extension RNIContextMenuButton: RNICleanable {
  
  func cleanup(){
    guard self.shouldEnableCleanup,
          !self.didTriggerCleanup
    else { return };
    
    self.didTriggerCleanup = true;
    
    self.contextMenuInteraction?.dismissMenu();
    
    // remove this view from registry
    RNIUtilities.recursivelyRemoveFromViewRegistry(
      bridge   : self.bridge,
      reactView: self
    );
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
};
