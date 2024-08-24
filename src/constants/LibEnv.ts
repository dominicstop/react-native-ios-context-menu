import { Platform } from 'react-native';

// @ts-ignore
export const IOS_VERSION = parseInt(Platform.Version, 10);

export const IS_PLATFORM_IOS = (Platform.OS === 'ios');

export const LIB_ENV = {
  isContextMenuButtonSupported: (
    IS_PLATFORM_IOS && (IOS_VERSION >= 14)
  ),
  isContextMenuViewSupported: (
    IS_PLATFORM_IOS && (IOS_VERSION >= 13)
  ),
  shouldEnableLogging: false,
  shouldEnableDetachedView: true,
};