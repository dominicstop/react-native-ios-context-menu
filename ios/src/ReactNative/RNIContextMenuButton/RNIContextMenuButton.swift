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
  
  private var deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
  
  weak var viewController: RNINavigationEventsReportingViewController?;
  
  // MARK: - Properties - Fags
  // -------------------------
  
  var isContextMenuVisible = false;
  var didPressMenuItem = false;
  
  private var didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  private var didAttachToParentVC = false;
  
  // MARK: - Properties - Feature Flags
  // ----------------------------------
  
  // MARK: - Properties - Feature Flags
  // ----------------------------------
  
  private var shouldEnableAttachToParentVC: Bool {
    self.cleanupMode == .viewController
  };
  
  private var shouldEnableCleanup: Bool {
    self.cleanupMode != .disabled
  };
  
  // MARK: - RN Exported Event Props
  // -------------------------------
  
  @objc var onMenuWillShow  : RCTBubblingEventBlock?;
  @objc var onMenuWillHide  : RCTBubblingEventBlock?;
  @objc var onMenuWillCancel: RCTBubblingEventBlock?;
  
  @objc var onMenuDidShow  : RCTBubblingEventBlock?;
  @objc var onMenuDidHide  : RCTBubblingEventBlock?;
  @objc var onMenuDidCancel: RCTBubblingEventBlock?;
  
  @objc var onPressMenuItem: RCTBubblingEventBlock?;
  
  @objc var onRequestDeferredElement: RCTBubblingEventBlock?;

  // MARK: - RN Exported Props
  // -------------------------
  
  private var _menuConfig: RNIMenuItem?;
  @objc var menuConfig: NSDictionary? {
    didSet {
      guard
        let rawMenuConfig = self.menuConfig,
        rawMenuConfig.count > 0,
        
        let rootMenuConfig = RNIMenuItem(dictionary: rawMenuConfig)
      else { return };
      
      self._menuConfig = rootMenuConfig;
      rootMenuConfig.delegate = self;
     
      // cleanup `deferredElementCompletionMap`
      self.cleanupOrphanedDeferredElements(currentMenuConfig: rootMenuConfig);
      
      self.updateContextMenu(with: rootMenuConfig);
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
  
  private var _internalCleanupMode: RNICleanupMode = .automatic;
  @objc var internalCleanupMode: String? {
    willSet {
      guard
        let rawString = newValue,
        let cleanupMode = RNICleanupMode(rawValue: rawString)
      else { return };
      
      self._internalCleanupMode = cleanupMode;
    }
  };
  
  // MARK: - Computed Properties
  // ---------------------------
  
  var cleanupMode: RNICleanupMode {
    get {
      switch self._internalCleanupMode {
        case .automatic: return .reactComponentWillUnmount;
        default: return self._internalCleanupMode;
      };
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
    
    // self.addAction( UIAction(title: ""){ action in
    //   print("menuActionTriggered");
    //   // TODO: wip
    // }, for: .menuActionTriggered);
  };
  
  func updateContextMenu(with menuConfig: RNIMenuItem){
    guard let interaction = self.contextMenuInteraction
    else { return };
    
    let menu = menuConfig.createMenu(
      actionItemHandler: { [unowned self] in
        self.handleOnPressMenuActionItem(dict: $0, action: $1);
        
      }, deferredElementHandler: {  [unowned self] in
        // B. deferred element is requesting for items to load...
        self.handleOnDeferredElementRequest(
          deferredID: $0, completion: $1
        );
      }
    );
    
    if self.isContextMenuVisible {
      // context menu is open, update the menu items
      interaction.updateVisibleMenu { _ in
        return menu;
      };
      
    } else {
      self.menu = menu;
    };
  };
  
  func handleOnPressMenuActionItem(
    dict: [String: Any],
    action: UIAction
  ){
    self.didPressMenuItem = true;
    self.onPressMenuItem?(dict);
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self.deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.onRequestDeferredElement?([
      "deferredID": deferredID,
    ]);
  };
  
  func cleanupOrphanedDeferredElements(currentMenuConfig: RNIMenuItem) {
    guard self.deferredElementCompletionMap.count > 0
    else { return };
    
    let currentDeferredElements = RNIMenuElement.recursivelyGetAllElements(
      from: currentMenuConfig,
      ofType: RNIDeferredMenuElement.self
    );
      
    // get the deferred elements that are not in the new config
    let orphanedKeys = self.deferredElementCompletionMap.keys.filter { deferredID in
      !currentDeferredElements.contains {
        $0.deferredID == deferredID
      };
    };
    
    // cleanup
    orphanedKeys.forEach {
      self.deferredElementCompletionMap.removeValue(forKey: $0);
    };
  };
  
  func attachToParentVC(){
    guard self.shouldEnableAttachToParentVC,
          !self.didAttachToParentVC,
          // find the nearest parent view controller
          let parentVC = RNIUtilities
            .getParent(responder: self, type: UIViewController.self)
    else { return };
    
    self.didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.delegate = self;
    childVC.parentVC = parentVC;
    
    self.viewController = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
  };
  
  func detachFromParentVC(){
    guard !self.didAttachToParentVC,
          let childVC = self.viewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
  };
};
  
// MARK: - Functions For Manager
// -----------------------------

@available(iOS 14, *)
extension RNIContextMenuButton {
  
  @objc func dismissMenu(){
    self.contextMenuInteraction?.dismissMenu();
  };
  
  func provideDeferredElements(id deferredID: String, menuElements: [RNIMenuElement]){
    if let completion = self.deferredElementCompletionMap[deferredID] {

      // create + add menu elements
      completion( menuElements.compactMap { menuElement in
        menuElement.createMenuElement(
          actionItemHandler: { [unowned self] in
            self.handleOnPressMenuActionItem(dict: $0, action: $1);
            
          }, deferredElementHandler: { [unowned self] in
            self.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
          }
        );
      });
      
      // cleanup
      self.deferredElementCompletionMap.removeValue(forKey: deferredID);
    };
  };
};

// MARK: - UIContextMenuInteractionDelegate
// ----------------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton {
  
  // context menu display begins
  override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willDisplayMenuFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    super.contextMenuInteraction(interaction, willDisplayMenuFor: configuration, animator: animator);

    self.isContextMenuVisible = true;
    
    self.onMenuWillShow?([:]);
    animator?.addCompletion { [unowned self] in
      self.onMenuDidShow?([:]);
    };
  };
  
  // context menu display ends
  override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    super.contextMenuInteraction(interaction, willEndFor: configuration, animator: animator);
    
    guard self.isContextMenuVisible else { return };
    
    self.onMenuWillHide?([:]);
    if !self.didPressMenuItem {
      self.onMenuWillCancel?([:]);
    };
    
    animator?.addCompletion { [unowned self] in
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
// -------------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton: RNINavigationEventsNotifiable {
  
  func notifyViewControllerDidPop(sender: RNINavigationEventsReportingViewController) {
    if self.cleanupMode == .viewController {
      // trigger cleanup
      self.cleanup();
    };
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
    self.detachFromParentVC();
    
    #if DEBUG
    NotificationCenter.default.removeObserver(self);
    #endif
  };
};

// MARK: - RNIJSComponentWillUnmountNotifiable
// -------------------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton: RNIJSComponentWillUnmountNotifiable {
  
  func notifyOnJSComponentWillUnmount(){
    guard self.cleanupMode == .reactComponentWillUnmount
    else { return };
    
    self.cleanup();
  };
};

// MARK: - RNIMenuElementEventsNotifiable
// --------------------------------------

@available(iOS 14, *)
extension RNIContextMenuButton: RNIMenuElementEventsNotifiable {
  
  func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self._menuConfig else { return };
    self.updateContextMenu(with: menuConfig);
  };
};
