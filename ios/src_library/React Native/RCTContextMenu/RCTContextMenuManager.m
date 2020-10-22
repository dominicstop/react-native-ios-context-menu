
//
//  RCTContextMenuManager.m
//  nativeUIModulesTest
//
//  Created by Dominic Go on 7/14/20.
//

#import <React/RCTViewManager.h>
 

@interface RCT_EXTERN_MODULE(RCTContextMenuManager, RCTViewManager)

// --------------------------------
// MARK: Props - RN Component Props
// --------------------------------

RCT_EXPORT_VIEW_PROPERTY(onPressMenuItem, RCTDirectEventBlock);

RCT_EXPORT_VIEW_PROPERTY(menuTitle, NSString);

RCT_EXPORT_VIEW_PROPERTY(menuItems  , NSArray);
RCT_EXPORT_VIEW_PROPERTY(menuOptions, NSArray);

@end
