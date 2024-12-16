//
//  RNIContextMenuViewManager.m
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 8/24/24.
//

#import "RNIContextMenuView.h"
#import <objc/runtime.h>

#import "RNIContextMenuHeaderUtils.h"

#import RNI_UTILITIES_HEADER(RNIBaseViewUtils.h)

#import "RCTBridge.h"
#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>


@interface RNIContextMenuViewManager : RCTViewManager
@end

@implementation RNIContextMenuViewManager

RCT_EXPORT_MODULE(RNIContextMenuView)

#ifndef RCT_NEW_ARCH_ENABLED
- (UIView *)view
{
  return [[RNIContextMenuView alloc] initWithBridge:self.bridge];
}
#endif

RNI_EXPORT_VIEW_PROPERTY(menuConfig, NSDictionary)
RNI_EXPORT_VIEW_PROPERTY(previewConfig, NSDictionary)
RNI_EXPORT_VIEW_PROPERTY(auxiliaryPreviewConfig, NSDictionary)

RNI_EXPORT_VIEW_PROPERTY(shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle, BOOL)
RNI_EXPORT_VIEW_PROPERTY(isContextMenuEnabled, BOOL)
RNI_EXPORT_VIEW_PROPERTY(shouldPreventLongPressGestureFromPropagating, BOOL)
RNI_EXPORT_VIEW_PROPERTY(isAuxiliaryPreviewEnabled, BOOL)

RNI_EXPORT_VIEW_EVENT(onDidSetViewID, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuWillShow, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuWillHide, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuWillCancel, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuDidShow, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuDidHide, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuDidCancel, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onPressMenuItem, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onPressMenuPreview, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onMenuWillCreate, RCTBubblingEventBlock)
RNI_EXPORT_VIEW_EVENT(onRequestDeferredElement, RCTBubblingEventBlock)

@end
