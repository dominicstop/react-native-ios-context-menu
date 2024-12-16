//
//  RNIContextMenuViewShadowNode.h
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#if __cplusplus
#pragma once

#include "RNIHeaderUtils.h"

#import RNI_INCLUDE_HEADER(RNIBaseViewShadowNode.h)
#import RNI_INCLUDE_HEADER(RNIBaseViewProps.h)
#import RNI_INCLUDE_HEADER(RNIBaseViewEventEmitter.h)

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
