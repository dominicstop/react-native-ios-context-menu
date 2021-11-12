
//
//  RCTContextMenuManager.m
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

#import <React/RCTViewManager.h>
 

@interface RCT_EXTERN_MODULE(RNIContextMenuViewManager, RCTViewManager)

// MARK: - Export Props - Events
// -----------------------------

RCT_EXPORT_VIEW_PROPERTY(onMenuWillShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onMenuDidShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onPressMenuItem   , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onPressMenuPreview, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onMenuWillCreate, RCTBubblingEventBlock);

// MARK: - Export Props - Values
// -----------------------------

RCT_EXPORT_VIEW_PROPERTY(menuConfig   , NSDictionary);
RCT_EXPORT_VIEW_PROPERTY(previewConfig, NSDictionary);

// MARK: Export View Manager Commands
// ----------------------------------

RCT_EXTERN_METHOD(dismissMenu:(nonnull NSNumber *)node);

@end
