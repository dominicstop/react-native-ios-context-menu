//
//  RNIContextMenuView.mm
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#import "RNIContextMenuView.h"
#import "../Swift.h"

#import "RNIContextMenuHeaderUtils.h"

#import RNI_UTILITIES_HEADER(RNIBaseView.h)
#import RNI_UTILITIES_HEADER(RNIContentViewParentDelegate.h)
#import RNI_UTILITIES_HEADER(UIApplication+RNIHelpers.h)
#import RNI_UTILITIES_HEADER(RNIObjcUtils.h)

#if RCT_NEW_ARCH_ENABLED
#import RNI_UTILITIES_HEADER(RNIBaseViewState.h)
#endif

#if RCT_NEW_ARCH_ENABLED
#include "RNIContextMenuViewComponentDescriptor.h"

#import RNI_UTILITIES_HEADER(RNIBaseViewState.h)
#import RNI_UTILITIES_HEADER(RNIBaseViewProps.h)

#import <React/RCTConversions.h>
#import <React/RCTFabricComponentsPlugins.h>
#import <React/RCTRootComponentView.h>
#import <React/RCTSurfaceTouchHandler.h>

#include <react/renderer/core/ComponentDescriptor.h>
#include <react/renderer/core/ConcreteComponentDescriptor.h>
#include <react/renderer/graphics/Float.h>
#include <react/renderer/core/graphicsConversions.h>

#import <react/renderer/components/RNIContextMenuViewSpec/EventEmitters.h>
#import <react/renderer/components/RNIContextMenuViewSpec/RCTComponentViewHelpers.h>
#else
#import <React/RCTTouchHandler.h>
#import <React/RCTInvalidating.h>
#endif

#ifdef RCT_NEW_ARCH_ENABLED
using namespace facebook::react;
#endif


@interface RNIContextMenuView () <
  RNIContentViewParentDelegate,
#ifdef RCT_NEW_ARCH_ENABLED
  RCTRNIContextMenuViewViewProtocol
#else
  RCTInvalidating
#endif
> {
  // TBA
}
@end

@implementation RNIContextMenuView {
}

// MARK: - RNIBaseView
// -------------------

+ (Class)viewDelegateClass
{
  return [RNIContextMenuViewContent class];
}

// MARK: - Fabric-Only
// -------------------

#if RCT_NEW_ARCH_ENABLED
+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNIContextMenuViewComponentDescriptor>();
}

Class<RCTComponentViewProtocol> RNIContextMenuViewCls(void)
{
  return RNIContextMenuView.class;
}
#endif
@end



