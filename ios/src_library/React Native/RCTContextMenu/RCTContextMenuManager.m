
//
//  RCTContextMenuManager.m
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

#import <React/RCTViewManager.h>
 

@interface RCT_EXTERN_MODULE(RCTContextMenuManager, RCTViewManager)

// -----------------------------------
// MARK: Props - RN Comp Props: Events
// -----------------------------------

RCT_EXPORT_VIEW_PROPERTY(onMenuShow        , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuHide        , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuCancel      , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onPressMenuItem   , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onPressMenuPreview, RCTBubblingEventBlock);

// -----------------------------------
// MARK: Props - RN Comp Props: Values
// -----------------------------------

RCT_EXPORT_VIEW_PROPERTY(menuConfig, NSDictionary);

@end
