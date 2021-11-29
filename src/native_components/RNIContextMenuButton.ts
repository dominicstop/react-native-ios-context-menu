import { requireNativeComponent, UIManager, ViewProps } from 'react-native';
import type { RNIContextMenuViewProps } from './RNIContextMenuView';


export type RNIContextMenuButtonBaseProps = Pick<RNIContextMenuViewProps,
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
  // TODO: Next Major Version - Rename to `isContextMenuEnabled`
  enableContextMenu?: boolean;
  isMenuPrimaryAction?: boolean;
};

export type RNIContextMenuButtonProps =
  ViewProps & RNIContextMenuButtonBaseProps;

type RNIContextMenuButtonCommandIDMap = {
  dismissMenu: number;
};

const viewName = "RNIContextMenuButton";

export const RNIContextMenuButton = 
  requireNativeComponent<RNIContextMenuButtonProps>(viewName);

export const RNIContextMenuButtonCommands = 
  ((UIManager as any)[viewName]).Commands as RNIContextMenuButtonCommandIDMap;