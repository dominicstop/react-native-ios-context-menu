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

// export type RNIContextMenuViewInheritedRequiredProps = Required<Pick<RNIContextMenuNativeViewProps,
//   | 'blurConfig'
// >>;

export type RNIContextMenuViewInheritedProps =
  RNIContextMenuViewInheritedOptionalProps
//  & RNIContextMenuViewInheritedRequiredProps;

export type RNIContextMenuViewBaseProps = {
  // TBA
};

export type RNIContextMenuViewProps = PropsWithChildren<
    RNIContextMenuViewInheritedProps 
  & RNIContextMenuViewBaseProps
  & ViewProps
>;