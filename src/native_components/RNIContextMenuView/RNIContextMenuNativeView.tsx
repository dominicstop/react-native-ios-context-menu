import { requireNativeViewManager } from 'expo-modules-core';
import type { RNIContextMenuNativeViewProps } from './RNIContextMenuNativeViewTypes';

export const RNIContextMenuNativeView: React.ComponentType<RNIContextMenuNativeViewProps> =
  requireNativeViewManager('RNIContextMenuView');
