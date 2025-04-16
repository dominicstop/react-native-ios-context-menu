//
//  RNIContextMenuButtonContent.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

import UIKit
import DGSwiftUtilities
import ContextMenuAuxiliaryPreview
import react_native_ios_utilities


@objc(RNIContextMenuButtonContent)
public final class RNIContextMenuButtonContent: UIButton, RNIContentView {

  // MARK: - Embedded Types
  // ----------------------
  
  public enum Events: String, CaseIterable {
    case onDidSetViewID;
    
    case onMenuWillShow;
    case onMenuWillHide;
    case onMenuWillCancel;
    case onMenuDidShow;
    case onMenuDidHide;
    case onMenuDidCancel;
    case onPressMenuItem;
    case onRequestDeferredElement;
  };
  
  // MARK: - Static Properties
  // -------------------------
  
  public static var propKeyPathMap: Dictionary<String, PartialKeyPath<RNIContextMenuButtonContent>> = [
    "menuConfig": \.menuConfigProp,
    "isContextMenuEnabled": \.isContextMenuEnabled,
    "isMenuPrimaryAction": \.isMenuPrimaryAction,
  ];
  
  // MARK: Properties
  // ----------------
  
  var _didSetup = false;
  
  var _deferredElementCompletionMap:
    [String: RNIDeferredMenuElement.CompletionHandler] = [:];
    
  weak var navEventsVC: RNINavigationEventsReportingViewController?;
  var longPressGestureRecognizer: UILongPressGestureRecognizer!;
    
  // MARK: Public Properties
  // -----------------------
  
   /// Keep track on whether or not the context menu is currently visible.
  internal(set) public var isContextMenuVisible = false;
  
  // TODO: Fix 
  /// This is set to `true` when the menu is open and an item is pressed, and
  /// is immediately set back to `false` once the menu close animation
  /// finishes.
  internal(set) public var didPressMenuItem = false;
  
  /// Whether or not the current view was successfully added as child VC
  private(set) public var didAttachToParentVC = false;
  
  // MARK: - Properties - RNIContentViewDelegate
  // -------------------------------------------
  
  public weak var parentReactView: RNIContentViewParentDelegate?;
  
  // MARK: Properties - Props
  // ------------------------
  
  public var reactProps: NSDictionary = [:];
  
  private(set) public var menuConfig: RNIMenuItem?;
  @objc public var menuConfigProp: NSDictionary? {
    willSet {
      guard let newValue = newValue as? Dictionary<String, Any>,
            newValue.count > 0,
            
            let menuConfig = RNIMenuItem(dictionary: newValue)
      else {
        self.menuConfig = nil;
        return;
      };
      
      menuConfig.delegate = self;
      self.updateContextMenuIfVisible(with: menuConfig);
      
      // cleanup `deferredElementCompletionMap`
      self.cleanupOrphanedDeferredElements(currentMenuConfig: menuConfig);
      
      // update config
      self.menuConfig = menuConfig;
      
      guard #available(iOS 14.0, *) else {
        return;
      };
      
      let menu = self.createMenu(with: menuConfig);
      self.menu = menu;
    }
  };
  
  @objc public var isContextMenuEnabled = true {
    willSet {
      guard #available(iOS 14.0, *) else { return };
      self.isContextMenuInteractionEnabled = newValue;
    }
  };
  
  @objc public var isMenuPrimaryAction = false {
    willSet {
      guard #available(iOS 14.0, *) else { return };
      self.showsMenuAsPrimaryAction = newValue;
    }
  };
  
  // MARK: Init
  // ----------
  
  public static func createInstance(
    sender: RNIContentViewParentDelegate,
    frame: CGRect
  ) -> RNIContextMenuButtonContent {
    
    return .init();
  };
  
  // MARK: Functions - Setup
  // -----------------------
 
  func _setupIfNeeded(){
    guard !self._didSetup else { return };
    self._didSetup = true;
    
    self.isEnabled = true;
    self.isAccessibilityElement = false;
  };
    
  // MARK: Functions
  // ---------------
  
  func createMenu(with menuConfig: RNIMenuItem? = nil) -> UIMenu? {
    guard let menuConfig = menuConfig ?? self.menuConfig
    else { return nil };
    
    return menuConfig.createMenu(actionItemHandler: { [weak self] in
      // A. menu item has been pressed...
      self?.handleOnPressMenuActionItem(dict: $0, action: $1);
      
    }, deferredElementHandler: { [weak self] in
      // B. deferred element is requesting for items to load...
      self?.handleOnDeferredElementRequest(deferredID: $0, completion: $1);
    });
  };
  
  func updateContextMenuIfVisible(with menuConfig: RNIMenuItem){
    guard #available(iOS 14.0, *),
          self.isContextMenuVisible,
          
          let interaction = self.contextMenuInteraction,
          let menu = self.createMenu(with: menuConfig)
    else { return };
    
    // context menu is open, update the menu items
    interaction.updateVisibleMenu { _ in
      return menu;
    };
  };
  
  func handleOnPressMenuActionItem(
    dict: [String: Any],
    action: UIAction
  ){
    self.didPressMenuItem = true;
    
    self.dispatchEvent(
      for: .onPressMenuItem,
      withPayload: dict
    );
  };
  
  func handleOnDeferredElementRequest(
    deferredID: String,
    completion: @escaping RNIDeferredMenuElement.CompletionHandler
  ){
    // register completion handler
    self._deferredElementCompletionMap[deferredID] = completion;
    
    // notify js that a deferred element needs to be loaded
    self.dispatchEvent(
      for: .onRequestDeferredElement,
      withPayload: [
        "deferredID": deferredID,
      ]
    );
  };
  
  @objc func handleLongPressGesture(_ sender: UILongPressGestureRecognizer){
    // no-op
  };
  
  func attachToParentVC(){
    guard !self.didAttachToParentVC else { return };
        
    // find the nearest parent view controller
    let parentVC = self.recursivelyFindNextResponder(
      withType: UIViewController.self
    );
    
    guard let parentVC = parentVC else { return };
    self.didAttachToParentVC = true;
    
    let childVC = RNINavigationEventsReportingViewController();
    childVC.view = self;
    childVC.delegate = self;
    childVC.parentVC = parentVC;
    
    self.navEventsVC = childVC;

    parentVC.addChild(childVC);
    childVC.didMove(toParent: parentVC);
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
  
  func detachFromParentVCIfAny(){
    guard !self.didAttachToParentVC,
          let navEventsVC = self.navEventsVC
    else { return };
    
    navEventsVC.willMove(toParent: nil);
    navEventsVC.removeFromParent();
    navEventsVC.view.removeFromSuperview();
  };
  
  // MARK: - Functions - View Module Commands
  // ----------------------------------------
  
  public func dismissMenu() throws {
    guard #available(iOS 14.0, *) else {
      throw RNIContextMenuError(
        errorCode: .guardCheckFailed,
        description: "Unsupported, requires iOS 14+"
      );
    };
    
    guard let contextMenuInteraction = self.contextMenuInteraction else {
      throw RNIContextMenuError.init(
        errorCode: .unexpectedNilValue,
        description: "contextMenuInteraction is nil"
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
    
    guard let contextMenuInteraction = self.contextMenuInteraction else {
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
};

// MARK: - RNIContextMenuButtonDelegate+RNIContentViewDelegate
// --------------------------------------------------

extension RNIContextMenuButtonContent: RNIContentViewDelegate {

  public typealias KeyPathRoot = RNIContextMenuButtonContent;

  // MARK: Paper + Fabric
  // --------------------
  
  public func notifyOnInit(sender: RNIContentViewParentDelegate) {
    // no-op
  };
    
  public func notifyOnMountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    self.addSubview(childComponentView);
  };
  
  public func notifyOnUnmountChildComponentView(
    sender: RNIContentViewParentDelegate,
    childComponentView: UIView,
    index: NSInteger,
    superBlock: () -> Void
  ) {
    #if !RCT_NEW_ARCH_ENABLED
    superBlock();
    #endif
    
    childComponentView.removeFromSuperview();
  };
  
  public func notifyDidSetProps(sender: RNIContentViewParentDelegate) {
    self._setupIfNeeded();
  };

  public func notifyOnViewCommandRequest(
    sender: RNIContentViewParentDelegate,
    forCommandName commandName: String,
    withCommandArguments commandArguments: NSDictionary,
    resolve resolveBlock: @escaping RNIContentView.PromiseCompletionBlock,
    reject rejectBlock: @escaping RNIContentView.PromiseRejectionBlock
  ) {
    
    do {
      guard let commandArguments = commandArguments as? Dictionary<String, Any> else {
        throw RNIContextMenuError(
            errorCode: .invalidValue,
            description: "Unable to parse commandArguments",
            extraDebugValues: [
              "commandName": commandName,
              "commandArguments": commandArguments,
            ]
          );
      };
      
      switch commandName {
        case "presentMenu":
          try self.presentMenu();
          resolveBlock([:]);
          
        case "dismissMenu":
          try self.dismissMenu();
          resolveBlock([:]);
          
        case "provideDeferredElements":
          let id: String =
            try commandArguments.getValueFromDictionary(forKey: "id");
            
          let menuElementsRaw: [Any] =
            try commandArguments.getValueFromDictionary(forKey: "menuElements");
            
          let menuElements: [RNIMenuElement] = menuElementsRaw.compactMap {
            guard let dict = $0 as? Dictionary<String, Any> else {
              return nil;
            };
            
            return .init(dictionary: dict);
          };
          
          try self.provideDeferredElements(
            id: id,
            menuElements: menuElements
          );
          
          resolveBlock([:]);
          
        default:
          throw RNIContextMenuError(
            errorCode: .invalidValue,
            description: "No matching command for commandName",
            extraDebugValues: [
              "commandName": commandName,
              "commandArguments": commandArguments,
            ]
          );
      };
    
    } catch {
      rejectBlock(error.localizedDescription);
    };
  };
  
  // MARK: - Fabric Only
  // -------------------

  #if RCT_NEW_ARCH_ENABLED
  public func shouldRecycleContentDelegate(
    sender: RNIContentViewParentDelegate
  ) -> Bool {
    return false;
  };
  #endif
};


// MARK: - RNINavigationEventsNotifiable
// -------------------------------------

extension RNIContextMenuButtonContent: RNIMenuElementEventsNotifiable {

  public func notifyOnMenuElementUpdateRequest(for element: RNIMenuElement) {
    guard let menuConfig = self.menuConfig else { return };
    self.updateContextMenuIfVisible(with: menuConfig);
  };
};

// MARK: - RNINavigationEventsNotifiable
// -------------------------------------

extension RNIContextMenuButtonContent: RNINavigationEventsNotifiable {
  
  public func notifyViewControllerDidPop(
    sender: RNINavigationEventsReportingViewController
  ) {
    // TODO: WIP - To be re-impl.
    // try? self.viewCleanupMode
    //  .triggerCleanupIfNeededForViewControllerDidPopEvent(for: self);
  };
};
