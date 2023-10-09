import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { ReactNativeIosContextMenuViewProps } from './ReactNativeIosContextMenu.types';

const NativeView: React.ComponentType<ReactNativeIosContextMenuViewProps> =
  requireNativeViewManager('ReactNativeIosContextMenu');

export default function ReactNativeIosContextMenuView(props: ReactNativeIosContextMenuViewProps) {
  return <NativeView {...props} />;
}
