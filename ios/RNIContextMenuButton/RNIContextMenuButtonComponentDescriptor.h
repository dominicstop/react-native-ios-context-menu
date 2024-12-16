//
//  RNIContextMenuButtonComponentDescriptor.h
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#if __cplusplus
#pragma once

#include "RNIContextMenuButtonShadowNode.h"
#include "RNIBaseViewComponentDescriptor.h"
#include "RNIContextMenuHeaderUtils.h"

#import RNI_UTILITIES_HEADER(RNIBaseViewState.h)

#include <react/renderer/core/ConcreteComponentDescriptor.h>


namespace facebook::react {

class RNIContextMenuButtonComponentDescriptor final : public RNIBaseViewComponentDescriptor<
  RNIContextMenuButtonShadowNode,
  RNIContextMenuButtonComponentName
> {

public:
  using RNIBaseViewComponentDescriptor::RNIBaseViewComponentDescriptor;
};

} // namespace facebook::react
#endif
