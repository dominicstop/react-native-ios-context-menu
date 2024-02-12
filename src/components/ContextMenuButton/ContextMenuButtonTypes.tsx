import type {  ViewProps } from 'react-native';

import type { RNIContextMenuButtonBaseProps } from '../../native_components/RNIContextMenuButton';
import type { ContextMenuViewProps } from '../ContextMenuView';

export type ContextMenuButtonInheritedProps = Partial<Pick<RNIContextMenuButtonBaseProps,
  | 'internalViewCleanupMode'
  | 'isMenuPrimaryAction'
  | 'menuConfig'
  | 'isContextMenuEnabled'

  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  
  // `OnPress` Events
  | 'onPressMenuItem'
  
> & Pick<ContextMenuViewProps,
  | 'onRequestDeferredElement'
>>;

export type ContextMenuButtonBaseProps = {
  useActionSheetFallback?: boolean;
};

export type ContextMenuButtonProps = 
  & ContextMenuButtonInheritedProps
  & ContextMenuButtonBaseProps
  & ViewProps; 

export type ContextMenuButtonState = {
  menuVisible: boolean;
};
