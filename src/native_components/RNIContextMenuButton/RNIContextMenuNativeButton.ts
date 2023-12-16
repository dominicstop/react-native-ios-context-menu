import { requireNativeViewManager } from 'expo-modules-core';
import { Platform } from 'react-native';
import type { RNIContextMenuNativeButtonProps } from './RNIContextMenuNativeButtonTypes';

let RNIContextMenuNativeButtonView: React.ComponentType<RNIContextMenuNativeButtonProps>;

if (Platform.OS === 'ios') {
  RNIContextMenuNativeButtonView = requireNativeViewManager('RNIContextMenuButton');
}

export const RNIContextMenuNativeButton = RNIContextMenuNativeButtonView;