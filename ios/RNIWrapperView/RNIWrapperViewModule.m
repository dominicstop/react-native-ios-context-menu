//
//  RNIWrapperViewModule.m
//  react-native-ios-navigator
//
//  Created by Dominic Go on 8/3/21.
//

#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(RNIWrapperViewModule, NSObject)

RCT_EXTERN_METHOD(notifyComponentWillUnmount:(nonnull NSNumber *)node
                  params:(NSDictionary *)params);

@end
