import type { PropsWithChildren } from "react";
import type { ViewProps } from "react-native";

import type { RNIContextMenuNativeViewProps } from "./RNIContextMenuButtonNativeView";
import type { StateReactTag, StateViewID } from "react-native-ios-utilities";

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

export type RNIContextMenuButtonInheritedOptionalProps = Partial<Pick<RNIContextMenuNativeViewProps,
  // Value Props
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  
  // Lifecycle Events
  | 'onDidSetViewID'
>>;

export type RNIContextMenuButtonInheritedRequiredProps = Required<Pick<RNIContextMenuNativeViewProps,
  // Value Props
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'

  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  | 'onMenuAuxiliaryPreviewWillShow'
  | 'onMenuAuxiliaryPreviewDidShow'
  | 'onMenuWillCreate'
  | 'onRequestDeferredElement'

  // `OnPress` Events
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
>>;

export type RNIContextMenuButtonInheritedProps =
    RNIContextMenuButtonInheritedOptionalProps
  & RNIContextMenuButtonInheritedRequiredProps;

export type RNIContextMenuButtonBaseProps = {
  // TBA
  debugShouldEnableLogging?: boolean;
};

export type RNIContextMenuButtonProps = PropsWithChildren<
    RNIContextMenuButtonInheritedProps 
  & RNIContextMenuButtonBaseProps
  & ViewProps
>;