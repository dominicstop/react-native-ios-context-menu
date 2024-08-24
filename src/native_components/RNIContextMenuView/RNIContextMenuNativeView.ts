import type { HostComponent, ViewProps } from 'react-native';

import { default as RNIContextMenuViewNativeComponent } from './RNIContextMenuViewNativeComponent';
import type { SharedViewEvents } from 'react-native-ios-utilities';


export type RNIContextMenuNativeViewBaseProps = {
  // TBA
};

export type RNIContextMenuNativeViewProps = 
    SharedViewEvents
  & ViewProps
  & RNIContextMenuNativeViewBaseProps;

export const RNIContextMenuNativeView = 
  RNIContextMenuViewNativeComponent as unknown as HostComponent<RNIContextMenuNativeViewProps>;
