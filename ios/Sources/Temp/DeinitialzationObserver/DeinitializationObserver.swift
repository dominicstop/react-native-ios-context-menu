//
//  DeinitializationObserver.swift
//  ReactNativeIosContextMenu
//
//  Created by Dominic Go on 2/12/24.
//

import Foundation
import DGSwiftUtilities

public class DeinitializationObserver {

  public typealias ListenerBlock = () -> Void;

  public let delegates: MulticastDelegate<DeinitilizationNotifiable> = .init();
  public var listenerBlocks: Array<ListenerBlock> = [];

  public init() {
    // no-op
  };

  deinit {
    self.notifyListeners();
  };
  
  private func notifyListeners(){
    self.delegates.invoke {
      $0.onObjectDeinitialization();
    };
    
    self.listenerBlocks.forEach {
      $0();
    };
  };
  
  public func addListenerBlock(_ block: @escaping ListenerBlock) {
    listenerBlocks.append(block);
  };
};

