//
//  RNIWrapperViewManager.m
//  IosNavigatorExample
//
//  Created by Dominic Go on 2/1/21.
//

#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RNIWrapperViewManager, RCTViewManager)

// MARK: - Export Props - Events
// -----------------------------

RCT_EXPORT_VIEW_PROPERTY(onRequestSizeOverride, RCTBubblingEventBlock);

// MARK: - Export Props - Values
// -----------------------------

RCT_EXPORT_VIEW_PROPERTY(shouldNotifyComponentWillUnmount, BOOL);

@end
