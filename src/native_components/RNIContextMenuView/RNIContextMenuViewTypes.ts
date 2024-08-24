import type { PropsWithChildren } from "react";
import type { ViewProps } from "react-native";

import type { RNIContextMenuNativeViewProps } from "./RNIContextMenuNativeView";
import type { StateReactTag, StateViewID } from "react-native-ios-utilities";


export type RNIContextMenuViewRef = {
  getViewID: () => StateViewID;
  getReactTag: () => StateReactTag;
};

export type RNIContextMenuViewInheritedOptionalProps = Partial<Pick<RNIContextMenuNativeViewProps,
  | 'onDidSetViewID'
>>;

export type RNIContextMenuViewInheritedRequiredProps = Required<Pick<RNIContextMenuNativeViewProps,
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'
  | 'onMenuWillCreate'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
  | 'onMenuAuxiliaryPreviewWillShow'
  | 'onMenuAuxiliaryPreviewDidShow'
>>;

export type RNIContextMenuViewInheritedProps =
    RNIContextMenuViewInheritedOptionalProps
  & RNIContextMenuViewInheritedRequiredProps;

export type RNIContextMenuViewBaseProps = {
  // TBA
};

export type RNIContextMenuViewProps = PropsWithChildren<
    RNIContextMenuViewInheritedProps 
  & RNIContextMenuViewBaseProps
  & ViewProps
>;