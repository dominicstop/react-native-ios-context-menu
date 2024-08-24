#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface IosContextMenuViewManager : RCTViewManager
@end

@implementation IosContextMenuViewManager

RCT_EXPORT_MODULE(IosContextMenuView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end
