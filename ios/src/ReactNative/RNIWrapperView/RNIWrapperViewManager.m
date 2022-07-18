//
//  RNIWrapperViewManager.m
//  IosNavigatorExample
//
//  Created by Dominic Go on 2/1/21.
//

#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RNIWrapperViewManager, RCTViewManager)

// MARK: - Export Props - Values
// -----------------------------

RCT_EXPORT_VIEW_PROPERTY(shouldNotifyComponentWillUnmount, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldAutoCleanupOnJSUnmount, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldAutoCleanupOnWindowNil, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldAutoSetSizeOnLayout, BOOL);

RCT_EXPORT_VIEW_PROPERTY(isDummyView, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldAutoDetachSubviews, BOOL);

RCT_EXPORT_VIEW_PROPERTY(shouldCreateTouchHandlerForParentView, BOOL);
RCT_EXPORT_VIEW_PROPERTY(shouldCreateTouchHandlerForSubviews, BOOL);



@end
