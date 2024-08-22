// This guard prevent this file to be compiled in the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>

#ifndef IosContextMenuViewNativeComponent_h
#define IosContextMenuViewNativeComponent_h

NS_ASSUME_NONNULL_BEGIN

@interface IosContextMenuView : RCTViewComponentView
@end

NS_ASSUME_NONNULL_END

#endif /* IosContextMenuViewNativeComponent_h */
#endif /* RCT_NEW_ARCH_ENABLED */
