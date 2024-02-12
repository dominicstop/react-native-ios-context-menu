
import type { ViewProps } from 'react-native';
import type { RNIContextMenuNativeButtonBaseProps  } from "./RNIContextMenuNativeButtonTypes";


export type RNIContextMenuButtonBaseProps = Pick<RNIContextMenuNativeButtonBaseProps,
  | 'menuConfig'
  | 'isContextMenuEnabled'
  | 'internalViewCleanupMode'
  | 'isMenuPrimaryAction'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
>;

export type RNIContextMenuButtonProps = 
  RNIContextMenuButtonBaseProps & ViewProps;