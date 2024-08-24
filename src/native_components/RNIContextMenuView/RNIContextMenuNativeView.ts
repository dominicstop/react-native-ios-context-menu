import type { HostComponent, ViewProps } from 'react-native';
import type { SharedViewEvents, RemapObject } from 'react-native-ios-utilities';

import { 
  default as RNIContextMenuViewNativeComponent,
  type NativeProps as RNIContextMenuViewNativeComponentProps
} from './RNIContextMenuViewNativeComponent';


type RNIContextMenuViewNativeComponentBaseProps = 
  Omit<RNIContextMenuViewNativeComponentProps, keyof (ViewProps & SharedViewEvents)>

export type RNIContextMenuNativeViewBaseProps = RemapObject<RNIContextMenuViewNativeComponentBaseProps, {
  // TBA
}>;

export type RNIContextMenuNativeViewProps = 
    SharedViewEvents
  & ViewProps
  & RNIContextMenuNativeViewBaseProps;

export const RNIContextMenuNativeView = 
  RNIContextMenuViewNativeComponent as unknown as HostComponent<RNIContextMenuNativeViewProps>;
