import type { PropsWithChildren } from "react";
import type { ViewProps } from "react-native";

import type { RNIContextMenuNativeViewProps } from "./RNIContextMenuNativeView";
import type { StateReactTag, StateViewID } from "react-native-ios-utilities";

import type { MenuElementConfig } from "../../types/MenuConfig";


export type RNIContextMenuViewRef = {
  getViewID: () => StateViewID;
  getReactTag: () => StateReactTag;
  presentMenu: () => Promise<void>;
  dismissMenu: () => Promise<void>;
  showAuxiliaryPreviewAsPopover: () => Promise<void>;
  provideDeferredElements: (
    deferredID: string, 
    menuItems: Array<MenuElementConfig>
  ) => Promise<void>;
};

export type RNIContextMenuViewInheritedOptionalProps = Partial<Pick<RNIContextMenuNativeViewProps,
  // Value Props
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  
  // Lifecycle Events
  | 'onDidSetViewID'
>>;

export type RNIContextMenuViewInheritedRequiredProps = Required<Pick<RNIContextMenuNativeViewProps,
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

export type RNIContextMenuViewInheritedProps =
    RNIContextMenuViewInheritedOptionalProps
  & RNIContextMenuViewInheritedRequiredProps;

export type RNIContextMenuViewBaseProps = {
  // TBA
  debugShouldEnableLogging?: boolean;
};

export type RNIContextMenuViewProps = PropsWithChildren<
    RNIContextMenuViewInheritedProps 
  & RNIContextMenuViewBaseProps
  & ViewProps
>;