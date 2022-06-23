//
//  RNIContextMenuViewModule.m
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 11/16/21.
//

#import "React/RCTBridgeModule.h"


@interface RCT_EXTERN_MODULE(RNIContextMenuViewModule, NSObject)


RCT_EXTERN_METHOD(dismissMenu: (nonnull NSNumber)node
                  // promise blocks -----------------------
                  resolve: (RCTPromiseResolveBlock *)resolve
                  reject : (RCTPromiseRejectBlock  *)reject);

RCT_EXTERN_METHOD(provideDeferredElements: (nonnull NSNumber)node
                  deferredID: NSString
                  menuItems : NSArray
                  // promise blocks -----------------------
                  resolve: (RCTPromiseResolveBlock *)resolve
                  reject : (RCTPromiseRejectBlock  *)reject);

@end
