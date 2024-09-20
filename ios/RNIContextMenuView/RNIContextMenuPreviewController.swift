//
//  RNIContextMenuPreviewController.swift
//  IosContextMenuExample
//
//  Created by Dominic Go on 11/2/20.
//

import UIKit;
import react_native_ios_utilities


@available(iOS 13.0, *)
public class RNIContextMenuPreviewController: UIViewController {

  // MARK: - Properties
  // ------------------
  
  private var _didSetup = false;

  public var previewConfig: RNIMenuPreviewConfig?;

  public weak var contextMenuParent: RNIContentViewParentDelegate?;
  public weak var contextMenuContent: RNIContextMenuViewContent?;
  
  public weak var menuCustomPreviewParent: RNIContentViewParentDelegate?;
  public weak var menuCustomPreviewContent: RNIWrapperViewContent?;
  
  // MARK: - Computed Properties
  // ---------------------------
    
  /// shorthand for the inferred current size of the react custom preview
  public var menuCustomPreviewSize: CGSize? {
    guard let menuCustomPreviewParent = self.menuCustomPreviewParent else {
      return nil;
    };
    
    if let layoutMetrics = menuCustomPreviewParent.cachedLayoutMetrics {
      return layoutMetrics.frame.size;
    };
    
    if !menuCustomPreviewParent.intrinsicContentSizeOverride.isZero {
      return menuCustomPreviewParent.intrinsicContentSizeOverride;
    };
    
    return menuCustomPreviewParent.frame.size;
  };
  
  // MARK: - Functions - VC Lifecycle
  // --------------------------------
  
  public override func viewDidLoad() {
    super.viewDidLoad();
    
    guard let menuCustomPreviewParent = self.menuCustomPreviewParent else {
      return;
    };
    
    self.view.addSubview(menuCustomPreviewParent);
    menuCustomPreviewParent.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      menuCustomPreviewParent.leadingAnchor.constraint(
        equalTo: self.view.leadingAnchor
      ),
      menuCustomPreviewParent.trailingAnchor.constraint(
        equalTo: self.view.trailingAnchor
      ),
      menuCustomPreviewParent.topAnchor.constraint(
        equalTo: self.view.topAnchor
      ),
      menuCustomPreviewParent.bottomAnchor.constraint(
        equalTo: self.view.bottomAnchor
      ),
    ]);
  };
  
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews();
    
    if let previewConfig = self.previewConfig,
       previewConfig.previewSize == .STRETCH
    {
      self.updateReactViewSize();
    };
  };
  
  // MARK: - Methods
  // ---------------
  
  public func setup(with contextMenuContent: RNIContextMenuViewContent){
    guard !self._didSetup,
          let contextMenuParent = contextMenuContent.parentReactView,
          let menuCustomPreviewParent = contextMenuContent.menuCustomPreviewParent,
          let menuCustomPreviewContent = contextMenuContent.menuCustomPreviewContent
    else {
      return;
    };
    
    self.contextMenuParent = contextMenuParent;
    self.menuCustomPreviewParent = menuCustomPreviewParent;
    self.menuCustomPreviewContent = menuCustomPreviewContent;
    self.previewConfig = contextMenuContent.previewConfig;
    
    self._didSetup = true;
    
    if contextMenuContent.previewConfig.previewSize == .INHERIT {
      menuCustomPreviewParent.reactViewLifecycleDelegates.add(self);
    };
  };
  
  /// Update the size of the controller
  public func updatePreferredContentSize(
    newSize: CGSize,
    shouldEnableAnimations: Bool = true
  ){
    guard let previewConfig = self.previewConfig else {
      return;
    };
    
    let shouldAnimate =
         previewConfig.isResizeAnimated
      && shouldEnableAnimations;
      
    let animationBlock = {
      self.preferredContentSize = newSize;
    };
    
    if shouldAnimate {
      UIView.animate(
        withDuration: 0.3,
        delay: 0,
        options: [.curveEaseInOut],
        animations: animationBlock
      );
      
    } else {
      animationBlock();
    };
  };
  
  public func updateReactViewSize(){
    guard let menuCustomPreviewParent = self.menuCustomPreviewParent else {
      return;
    };
    
    menuCustomPreviewParent.setSize(self.view.bounds.size);
    self.preferredContentSize = .zero;
  };
};

// MARK: - RNIContextMenuPreviewController+RNIViewLifecycle
// --------------------------------------------------------

extension RNIContextMenuPreviewController: RNIViewLifecycle {
  
  public func notifyOnUpdateLayoutMetrics(
    sender: RNIContentViewParentDelegate,
    oldLayoutMetrics: RNILayoutMetrics,
    newLayoutMetrics: RNILayoutMetrics
  ) {
  
    let newSize = newLayoutMetrics.frame.size;
    let shouldApplyNewSize = self.preferredContentSize != newSize;
      
    guard shouldApplyNewSize else {
      return;
    };
      
    self.updatePreferredContentSize(newSize: newSize);
  };
};
