import type {  ViewProps } from 'react-native';

import type { RNIContextMenuButtonProps } from '../../native_components/RNIContextMenuButton';
import type { ContextMenuViewProps } from '../ContextMenuView';

export type ContextMenuButtonInheritedProps = Partial<Pick<RNIContextMenuButtonProps,
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


export type ContextMenuButtonProps = 
    ContextMenuButtonInheritedProps
  & ViewProps;

export type ContextMenuButtonState = {
  menuVisible: boolean;
};
