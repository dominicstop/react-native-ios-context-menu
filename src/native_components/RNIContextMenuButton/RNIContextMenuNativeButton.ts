import { requireNativeViewManager } from 'expo-modules-core';
import type { RNIContextMenuNativeButtonProps } from './RNIContextMenuNativeButtonTypes';

export const RNIContextMenuNativeButton: React.ComponentType<RNIContextMenuNativeButtonProps> =
  requireNativeViewManager('RNIContextMenuButton');
