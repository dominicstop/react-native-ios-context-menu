//
//  RNIContextMenuButtonModule.m
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 7/19/22.
//

#import "React/RCTBridgeModule.h"


@interface RCT_EXTERN_MODULE(RNIContextMenuButtonModule, NSObject)

RCT_EXTERN_METHOD(dismissMenu: (nonnull NSNumber)node
                  // promise blocks -----------------------
                  resolve: (RCTPromiseResolveBlock *)resolve
                  reject : (RCTPromiseRejectBlock  *)reject);

@end
