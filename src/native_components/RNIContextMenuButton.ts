import { requireNativeComponent, View, Platform, HostComponent, ViewProps } from 'react-native';
import type { RNIContextMenuViewProps } from './RNIContextMenuView';


export type RNIContextMenuButtonBaseProps = Pick<RNIContextMenuViewProps,
  | 'internalCleanupMode'
  | 'menuConfig'
  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
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

/**
 * Do not use `RNIContextMenuButton` if platform is not iOS.
 */
export const RNIContextMenuButton: HostComponent<RNIContextMenuViewProps> = Platform.select({
  ios: () => requireNativeComponent(viewName) as any,
  default: () => View,
})();