import type { ViewProps } from 'react-native';
import type { RNIContextMenuNativeViewBaseProps } from "../RNIContextMenuView/RNIContextMenuNativeViewTypes";


type InheritedProps = Pick<RNIContextMenuNativeViewBaseProps,
  | 'menuConfig'
  | 'isContextMenuEnabled'
  | 'internalCleanupMode'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
>;

export type RNIContextMenuNativeButtonBaseProps = InheritedProps & {
  isMenuPrimaryAction: boolean;
};

export type RNIContextMenuNativeButtonProps =
  ViewProps & RNIContextMenuNativeButtonBaseProps;