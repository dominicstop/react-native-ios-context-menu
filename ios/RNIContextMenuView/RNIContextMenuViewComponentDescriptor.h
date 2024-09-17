//
//  RNIContextMenuViewComponentDescriptor.h
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#if __cplusplus
#pragma once

#include "RNIContextMenuViewShadowNode.h"
#include "RNIBaseViewComponentDescriptor.h"

#include "react-native-ios-utilities/RNIBaseViewComponentDescriptor.h"
#include "react-native-ios-utilities/RNIBaseViewState.h"

#include <react/renderer/core/ConcreteComponentDescriptor.h>


namespace facebook::react {

class RNIContextMenuViewComponentDescriptor final : public RNIBaseViewComponentDescriptor<
  RNIContextMenuViewShadowNode,
  RNIContextMenuViewComponentName
> {
  
public:
  using RNIBaseViewComponentDescriptor::RNIBaseViewComponentDescriptor;
};

} // namespace facebook::react
#endif
