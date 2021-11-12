import { requireNativeComponent, UIManager, ViewProps } from 'react-native';
import type { RNIContextMenuViewProps } from './RNIContextMenuView';


export type RNIContextMenuButtonProps = ViewProps & Pick<RNIContextMenuViewProps,
  | 'menuConfig'
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  | 'onPressMenuItem'
> & {
  enableContextMenu: boolean;
  isMenuPrimaryAction: boolean;
};

export type RNIContextMenuButtonCommandID = {
  dismissMenu: number;
};

const viewName = "RNIContextMenuButton";

export const RNIContextMenuButton = 
  requireNativeComponent<RNIContextMenuButtonProps>(viewName);

export const RNIContextMenuButtonCommands = 
  ((UIManager as any)[viewName]).Commands as RNIContextMenuButtonCommandID;