//
//  RNIContextMenuButton.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/28/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import ExpoModulesCore
import ReactNativeIosUtilities
import ContextMenuAuxiliaryPreview


public class RNIContextMenuButton:
  ExpoView, RNIMenuElementEventsNotifiable, UIGestureRecognizerDelegate,
  RNINavigationEventsNotifiable, RNICleanable {

  // MARK: - Properties
  // ------------------
  
  var button: UIButton!;

  var _deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
    
  weak var viewController: RNINavigationEventsReportingViewController?;
  
  override public var reactTag: NSNumber! {
    didSet {
      try? RNICleanableViewRegistryShared.register(
        forDelegate: self,
        shouldIncludeDelegateInViewsToCleanup: true,
        shouldProceedCleanupWhenDelegateIsNil: true
      );
    }
  };
  
  // MARK: - Properties - Flags
  // --------------------------
  
  var isContextMenuVisible = false;
  var didPressMenuItem = false;
  
  var _didTriggerCleanup = false;
  
  /// Whether or not the current view was successfully added as child VC
  var _didAttachToParentVC = false;
  
  // MARK: - Properties - Props
  // --------------------------
  
  private(set) public var menuConfig: RNIMenuItem?;
  public var menuConfigRaw: Dictionary<String, Any>? {
    willSet {
      guard let newValue = newValue,
            newValue.count > 0,
            
            let rootMenuConfig = RNIMenuItem(dictionary: newValue)
      else { return };
      
      self.menuConfig = rootMenuConfig;
      rootMenuConfig.delegate = self;
      
      // cleanup `_deferredElementCompletionMap`
      self.cleanupOrphanedDeferredElements(currentMenuConfig: rootMenuConfig);
      self.updateContextMenu(with: rootMenuConfig);
    }
  };
  
  public var isMenuPrimaryAction: Bool = false {
    didSet {
      guard #available(iOS 14.0, *),
            self.isMenuPrimaryAction != oldValue
      else { return };
      
      self.button.showsMenuAsPrimaryAction = self.isMenuPrimaryAction;
    }
  };
  
  public var isContextMenuEnabled: Bool = true {
    didSet {
      guard #available(iOS 14.0, *),
            self.isContextMenuEnabled != oldValue
      else { return };
      
      self.button.isContextMenuInteractionEnabled = self.isContextMenuEnabled;
    }
  };
  
  private(set) public var viewCleanupMode: RNIViewCleanupMode = .default;
  public var internalViewCleanupModeRaw: Dictionary<String, Any>? {
    willSet {
      let nextValue: RNIViewCleanupMode = {
        guard let newValue = newValue,
              let viewCleanupMode = try? RNIViewCleanupMode(fromDict: newValue)
        else {
          return .default;
        };
        
        return viewCleanupMode;
      }();
      
      self.viewCleanupMode = nextValue;
      
      if let cleanableViewItem = self.associatedCleanableViewItem {
        cleanableViewItem.viewCleanupMode = nextValue;
      };
    }
  };
  
  // MARK: - Properties - Props - Events
  // -----------------------------------

  public var onMenuWillShow   = EventDispatcher("onMenuWillShow");
  public var onMenuWillHide   = EventDispatcher("onMenuWillHide");
  public var onMenuWillCancel = EventDispatcher("onMenuWillCancel");
  
  public var onMenuDidShow   = EventDispatcher("onMenuDidShow");
  public var onMenuDidHide   = EventDispatcher("onMenuDidHide");
  public var onMenuDidCancel = EventDispatcher("onMenuDidCancel");
  
  public var onPressMenuItem = EventDispatcher("onPressMenuItem");
  
  public var onRequestDeferredElement =
    EventDispatcher("onRequestDeferredElement");
    
  // MARK: Init + Lifecycle
  // ----------------------
  
  public required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext);
    
    self.setupButton();
    self.setupAddContextMenuInteraction();
  };
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  public override func reactSetFrame(_ frame: CGRect) {
    super.reactSetFrame(frame);
  };
  
  deinit {
    try? self.viewCleanupMode.triggerCleanupIfNeededForDeinit(
      for: self,
      shouldForceCleanup: true
    );
  };
  
  // MARK: - View Lifecycle
  // ----------------------
  
  public override func didMoveToWindow() {
    let shouldAttachToParentVC = self.viewCleanupMode.shouldAttachToParentController(
      forView: self,
      associatedViewController: self.viewController,
      currentWindow: self.window
    );
      
    if shouldAttachToParentVC {
      // begin setup - attach this view as child vc
      self.attachToParentVC();
    
    } else {
      // trigger manual cleanup
      try? self.viewCleanupMode.triggerCleanupIfNeededForDidMoveToWindow(
        forView: self,
        associatedViewController: self.viewController,
        currentWindow: self.window
      );
    };
  };
  
  public override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    self.button.insertSubview(subview, at: atIndex);
  };
  
  public override func removeReactSubview(_ subview: UIView!) {
    guard let subviewToRemove = self.button.viewWithTag(subview.tag) else { return };
    subviewToRemove.removeFromSuperview();
  };
  
  // MARK: - Functions
  // -----------------
  
  func setupButton(){
    let button = UIButton();
    self.button = button;
    
    self.addSubview(button);
    button.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(
        equalTo: self.leadingAnchor
      ),
      button.trailingAnchor.constraint(
        equalTo: self.trailingAnchor
      ),
      button.topAnchor.constraint(
        equalTo: self.topAnchor
      ),
      button.bottomAnchor.constraint(
        equalTo: self.bottomAnchor
      ),
    ]);
  };
  
  /// Add a context menu interaction to button
  func setupAddContextMenuInteraction(){
    self.button.isEnabled = true;
    self.button.isUserInteractionEnabled = true;
    
    let gesture = UIGestureRecognizer();
    gesture.cancelsTouchesInView = true;
    gesture.delegate = self;
    
    // self.addAction( UIAction(title: ""){ action in
    //   print("menuActionTriggered");
    //   // TODO: wip
    // }, for: .menuActionTriggered);
  };
  
  func updateContextMenu(with menuConfig: RNIMenuItem){
    guard #available(iOS 14.0, *),
          let interaction = self.button.contextMenuInteraction
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
      self.button.menu = menu;
    };
  };
  
  func handleOnPressMenuActionItem(
    dict: [String: Any],
    action: UIAction
  ){
    self.didPressMenuItem = true;
    self.onPressMenuItem.callAsFunction(dict);
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self._deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.onRequestDeferredElement.callAsFunction([
      "deferredID": deferredID,
    ]);
  };
  
  func cleanupOrphanedDeferredElements(currentMenuConfig: RNIMenuItem) {
    guard self._deferredElementCompletionMap.count > 0
    else { return };
    
    let currentDeferredElements = RNIMenuElement.recursivelyGetAllElements(
      from: currentMenuConfig,
      ofType: RNIDeferredMenuElement.self
    );
      
    // get the deferred elements that are not in the new config
    let orphanedKeys = self._deferredElementCompletionMap.keys.filter { deferredID in
      !currentDeferredElements.contains {
        $0.deferredID == deferredID
      };
    };
    
    // cleanup
    orphanedKeys.forEach {
      self._deferredElementCompletionMap.removeValue(forKey: $0);
    };
  };
  
  func attachToParentVC(){
    guard !self._didAttachToParentVC else { return };
        
    // find the nearest parent view controller
    let parentVC = RNIHelpers.getParent(
      responder: self,
      type: UIViewController.self
    );
    
    guard let parentVC = parentVC else { return };
    self._didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.delegate = self;
    childVC.parentVC = parentVC;
    
    self.viewController = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
  };
  
  func detachFromParentVCIfAny(){
    guard !self._didAttachToParentVC,
          let childVC = self.viewController
    else { return };
    
    childVC.willMove(toParent: nil);
    childVC.removeFromParent();
    childVC.view.removeFromSuperview();
  };
  
  // MARK: - Functions - View Module Commands
  // ----------------------------------------
  
  func presentMenu() throws {
    guard #available(iOS 14.0, *) else {
      throw RNIContextMenuError(
        errorCode: .guardCheckFailed,
        description: "Unsupported, requires iOS 14+"
      );
    };
    
    guard self.isContextMenuEnabled else {
      throw RNIContextMenuError.init(
        errorCode: .guardCheckFailed,
        description: "Context menu is disabled"
      );
    };
    
    guard !self.isContextMenuVisible else {
      throw RNIContextMenuError.init(
        errorCode: .guardCheckFailed,
        description: "Context menu is already visible"
      );
    };
    
    guard let contextMenuInteraction = self.button.contextMenuInteraction else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "contextMenuInteraction is nil"
      );
    };
    
    guard let contextMenuInteractionWrapper =
            ContextMenuInteractionWrapper(objectToWrap: contextMenuInteraction)
    else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "Unable to create ContextMenuInteractionWrapper"
      );
    };
    
    try contextMenuInteractionWrapper.presentMenuAtLocation(point: .zero);
  };

  func dismissMenu() throws {
    guard #available(iOS 14.0, *) else {
      throw RNIContextMenuError(
        errorCode: .guardCheckFailed,
        description: "Unsupported, requires iOS 14+"
      );
    };
    
    guard let contextMenuInteraction = self.button.contextMenuInteraction else {
      throw RNIContextMenuError(
        errorCode: .unexpectedNilValue,
        description: "button.contextMenuInteraction is nil"
      );
    };
    
    contextMenuInteraction.dismissMenu();
  };
  
  public func provideDeferredElements(
    id deferredID: String,
    menuElements rawMenuElements: [RNIMenuElement]
  ) throws {
  
    guard let completionHandler = self._deferredElementCompletionMap[deferredID]
    else {
      throw RNIContextMenuError(
        description: "No matching deferred completion handler found for deferredID",
        extraDebugValues: ["deferredID": deferredID]
      );
    };
    
    // create menu elements
    let menuElements = rawMenuElements.compactMap { menuElement in
      menuElement.createMenuElement(
        actionItemHandler: { [unowned self] in
          self.handleOnPressMenuActionItem(dict: $0, action: $1);
          
        }, deferredElementHandler: { [unowned self] in
          self.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
        }
      );
    };
    
    // add menu elements
    completionHandler(menuElements);
  
    // cleanup
    self._deferredElementCompletionMap.removeValue(forKey: deferredID);
  };
  
  // MARK: - RNIMenuElementEventsNotifiable
  // --------------------------------------
  
  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self.menuConfig else { return };
    self.updateContextMenu(with: menuConfig);
  };
  
  // MARK: - UIGestureRecognizerDelegate
  // -----------------------------------
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldReceive touch: UITouch
  ) -> Bool {
    return true;
  };
  
  // MARK: - RNINavigationEventsNotifiable
  // -------------------------------------
  
  public func notifyViewControllerDidPop(
    sender: RNINavigationEventsReportingViewController
  ) {
    try? self.viewCleanupMode
      .triggerCleanupIfNeededForViewControllerDidPopEvent(for: self);
  };
  
  // MARK: - RNICleanable
  // --------------------
  
  public func cleanup(){
    guard let viewCleanupKey = self.viewCleanupKey else { return };
    
    try? RNICleanableViewRegistryShared.notifyCleanup(
      forKey: viewCleanupKey,
      sender: .cleanableViewDelegate(self),
      shouldForceCleanup: true,
      cleanupTrigger: nil
    );
  };
};
