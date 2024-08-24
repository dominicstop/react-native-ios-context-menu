//
//  RNIContextMenuView.mm
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#import "RNIContextMenuView.h"

#import "react-native-ios-context-menu/Swift.h"
#import "react-native-ios-utilities/RNIBaseView.h"

#import "react-native-ios-utilities/RNIContentViewParentDelegate.h"

#import "react-native-ios-utilities/UIApplication+RNIHelpers.h"
#import "react-native-ios-utilities/RNIObjcUtils.h"

#if RCT_NEW_ARCH_ENABLED
#include "RNIContextMenuViewComponentDescriptor.h"

#include "react-native-ios-utilities/RNIBaseViewState.h"
#include "react-native-ios-utilities/RNIBaseViewProps.h"

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
  RCTIosContextMenuViewViewProtocol
#else
  RCTInvalidating
#endif
> {
  // TBA
}
@end

@implementation RNIContextMenuView {
}

// MARK: - Init
// ------------

- (void)initCommon {
  [super initCommon];
}

// MARK: - RNIBaseView
// -------------------

+ (Class)viewDelegateClass
{
  return [RNIContextMenuViewContent class];
}

// MARK: - Fabric
// --------------

#if RCT_NEW_ARCH_ENABLED
+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNIContextMenuViewComponentDescriptor>();
}

Class<RCTComponentViewProtocol> RNIContextMenuViewCls(void)
{
  return RNIContextMenuView.class;
}
#else

// MARK: - Paper
// -------------

- (void)invalidate
{
  // to be impl.
}

#endif
@end



