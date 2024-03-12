import type { ViewProps } from 'react-native';
import type { RNIContextMenuNativeViewProps } from "../RNIContextMenuView/RNIContextMenuNativeViewTypes";


type InheritedProps = Pick<RNIContextMenuNativeViewProps,
  | 'menuConfig'
  | 'isContextMenuEnabled'
  | 'internalViewCleanupMode'
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