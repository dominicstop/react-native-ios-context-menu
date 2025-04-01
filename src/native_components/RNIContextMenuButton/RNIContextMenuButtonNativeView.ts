import type { HostComponent, ViewProps } from 'react-native';
import type { SharedViewEvents, RemapObject, NativeComponentBaseProps } from 'react-native-ios-utilities';

import { 
  default as RNIContextMenuButtonNativeComponent,
  type NativeProps as RNIContextMenuButtonNativeComponentProps
} from './RNIContextMenuButtonNativeComponent';

import type { RNIContextMenuNativeViewBaseProps } from '../RNIContextMenuView/RNIContextMenuNativeView';


type RNIContextMenuButtonNativeComponentBaseProps = 
  NativeComponentBaseProps<RNIContextMenuButtonNativeComponentProps>;

export type RNIContextMenuNativeViewInheritedProps = Pick<RNIContextMenuNativeViewBaseProps,
  | 'menuConfig'
  | 'isContextMenuEnabled'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
>;

export type RNIContextMenuButtonNativeViewBaseProps = RemapObject<
  RNIContextMenuButtonNativeComponentBaseProps, 
  (
    Required<RNIContextMenuNativeViewInheritedProps> & {
      isMenuPrimaryAction: boolean;
    }
  )
>;

export type RNIContextMenuButtonNativeViewProps = 
    SharedViewEvents
  & ViewProps
  & RNIContextMenuNativeViewInheritedProps
  & RNIContextMenuButtonNativeViewBaseProps;

export const RNIContextMenuButtonNativeView = 
  RNIContextMenuButtonNativeComponent as unknown as HostComponent<RNIContextMenuButtonNativeViewProps>;


