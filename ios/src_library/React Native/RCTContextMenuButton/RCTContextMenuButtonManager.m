//
//  RCTContextMenuButtonManager.m
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/28/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
 

@interface RCT_EXTERN_MODULE(RCTContextMenuButtonManager, RCTViewManager)

// -----------------------------------
// MARK: Props - RN Comp Props: Events
// -----------------------------------

// TODO: WIP

RCT_EXPORT_VIEW_PROPERTY(onMenuWillShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onMenuDidShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onPressMenuItem   , RCTBubblingEventBlock);

// -----------------------------------
// MARK: Props - RN Comp Props: Values
// -----------------------------------

RCT_EXPORT_VIEW_PROPERTY(menuConfig, NSDictionary);

@end
