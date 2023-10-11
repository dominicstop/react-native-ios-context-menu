import { requireNativeViewManager } from 'expo-modules-core';
import type { RNIContextMenuViewProps } from './RNIContextMenuViewTypes';

export const RNIContextMenuNativeView: React.ComponentType<RNIContextMenuViewProps> =
  requireNativeViewManager('RNIContextMenuView');
