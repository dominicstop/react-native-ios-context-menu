//
//  RNIContextMenuViewShadowNode.h
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#if __cplusplus
#pragma once

#if __has_include(<react_native_ios_utilities/RNIBaseViewShadowNode.h>)
#include <react_native_ios_utilities/RNIBaseViewShadowNode.h>
#include <react_native_ios_utilities/RNIBaseViewProps.h>
#include <react_native_ios_utilities/RNIBaseViewEventEmitter.h>
#else
#include <react-native-ios-utilities/RNIBaseViewShadowNode.h>
#include <react-native-ios-utilities/RNIBaseViewProps.h>
#include <react-native-ios-utilities/RNIBaseViewEventEmitter.h>
#endif

#include <react/renderer/components/RNIContextMenuViewSpec/EventEmitters.h>
#include <react/renderer/components/RNIContextMenuViewSpec/Props.h>

#include <react/renderer/components/view/ConcreteViewShadowNode.h>
#include <jsi/jsi.h>


namespace facebook::react {

JSI_EXPORT extern const char RNIContextMenuViewComponentName[] = "RNIContextMenuView";

class JSI_EXPORT RNIContextMenuViewShadowNode final :
  public RNIBaseViewShadowNode<RNIContextMenuViewComponentName> {

public:
  using RNIBaseViewShadowNode::RNIBaseViewShadowNode;
  
  static RNIBaseViewState initialStateData(
      const Props::Shared&r          , // props
      const ShadowNodeFamily::Shared&, // family
      const ComponentDescriptor&       // componentDescriptor
  ) {
    return {};
  }
};

} // facebook::react
#endif
