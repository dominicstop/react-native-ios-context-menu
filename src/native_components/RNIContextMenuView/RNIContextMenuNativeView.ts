import { requireNativeViewManager } from 'expo-modules-core';
import { Platform } from 'react-native';
import type { RNIContextMenuNativeViewProps } from './RNIContextMenuNativeViewTypes';

let RNIContextMenuView: React.ComponentType<RNIContextMenuNativeViewProps>;

if (Platform.OS === 'ios') {
  RNIContextMenuView = requireNativeViewManager('RNIContextMenuView');
}

export const RNIContextMenuNativeView = RNIContextMenuView;

