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

#if __has_include(<react_native_ios_utilities/RNIBaseViewComponentDescriptor.h>)
#include <react_native_ios_utilities/RNIBaseViewComponentDescriptor.h>
#include <react_native_ios_utilities/RNIBaseViewState.h>
#else
#include <react-native-ios-utilities/RNIBaseViewComponentDescriptor.h>
#include <react-native-ios-utilities/RNIBaseViewState.h>
#endif

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
