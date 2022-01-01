import type {  ViewProps } from 'react-native';

import type { RNIContextMenuButtonBaseProps } from '../../native_components/RNIContextMenuButton';


export type ContextMenuButtonBaseProps = Pick<RNIContextMenuButtonBaseProps,
  | 'enableContextMenu'
  | 'isMenuPrimaryAction'
  | 'menuConfig'
  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  // `OnPress` Events
  | 'onPressMenuItem'
> & {
  useActionSheetFallback?: boolean;
};

export type ContextMenuButtonProps = 
  ViewProps & ContextMenuButtonBaseProps;

export type ContextMenuButtonState = {
  menuVisible: boolean;
};
