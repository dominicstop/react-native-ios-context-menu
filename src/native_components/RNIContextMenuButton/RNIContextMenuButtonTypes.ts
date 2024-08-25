import type { PropsWithChildren } from "react";
import type { ViewProps } from "react-native";

import type { StateReactTag, StateViewID } from "react-native-ios-utilities";
import type { RNIContextMenuButtonNativeViewProps } from "./RNIContextMenuButtonNativeView";

import type { MenuElementConfig } from "../../types/MenuConfig";


export type RNIContextMenuButtonRef = {
  getViewID: () => StateViewID;
  getReactTag: () => StateReactTag;
  presentMenu: () => Promise<void>;
  dismissMenu: () => Promise<void>;
  provideDeferredElements: (
    deferredID: string, 
    menuItems: Array<MenuElementConfig>
  ) => Promise<void>;
};

export type RNIContextMenuButtonInheritedOptionalProps = Partial<Pick<RNIContextMenuButtonNativeViewProps,
  // Value Props
  | 'menuConfig'

  // Lifecycle Events
  | 'onDidSetViewID'
>>;

export type RNIContextMenuButtonInheritedRequiredProps = Required<Pick<RNIContextMenuButtonNativeViewProps,
  // Value Props
  | 'isContextMenuEnabled'
  | 'isMenuPrimaryAction'

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
>>;

export type RNIContextMenuButtonInheritedProps =
    RNIContextMenuButtonInheritedOptionalProps
  & RNIContextMenuButtonInheritedRequiredProps;

export type RNIContextMenuButtonBaseProps = {
  // TBA
};

export type RNIContextMenuButtonProps = PropsWithChildren<
    RNIContextMenuButtonInheritedProps 
  & RNIContextMenuButtonBaseProps
  & ViewProps
>;