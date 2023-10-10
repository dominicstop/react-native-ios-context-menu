//
//  RNIContextMenuButtonManager.m
//  IosContextMenuExample
//
//  Created by Dominic Go on 10/28/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <React/RCTViewManager.h>
 

@interface RCT_EXTERN_MODULE(RNIContextMenuButtonManager, RCTViewManager)

// MARK: - Export Props - Events
// -----------------------------

// TODO: WIP

RCT_EXPORT_VIEW_PROPERTY(onMenuWillShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuWillCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onMenuDidShow  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidHide  , RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onMenuDidCancel, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onPressMenuItem, RCTBubblingEventBlock);

RCT_EXPORT_VIEW_PROPERTY(onRequestDeferredElement, RCTBubblingEventBlock);

// MARK: - Export Props - Values
// ----------------------------

RCT_EXPORT_VIEW_PROPERTY(menuConfig, NSDictionary);

RCT_EXPORT_VIEW_PROPERTY(enableContextMenu   , BOOL);
RCT_EXPORT_VIEW_PROPERTY(isMenuPrimaryAction , BOOL);
RCT_EXPORT_VIEW_PROPERTY(isContextMenuEnabled, BOOL);

// MARK: -  View Manager Commands
// ------------------------------

RCT_EXTERN_METHOD(dismissMenu:(nonnull NSNumber *)node);

@end
