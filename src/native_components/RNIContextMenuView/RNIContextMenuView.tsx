import * as React from 'react';

import type { StateViewID, StateReactTag } from "react-native-ios-utilities";
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { 
	RNIContextMenuViewProps, 
	RNIContextMenuViewRef, 
} from './RNIContextMenuViewTypes';


export const RNIContextMenuView = React.forwardRef<
	RNIContextMenuViewRef, 
	RNIContextMenuViewProps
>((props, ref) => {

	const [viewID, setViewID] = React.useState<StateViewID>();
	const [reactTag, setReactTag] = React.useState<StateReactTag>();

	React.useImperativeHandle(ref, () => ({
		getReactTag: () => {
			return reactTag;
		},
		getViewID: () => {
			return viewID;
		},
	}));

	return (
		<RNIContextMenuNativeView
			{...props}
			onDidSetViewID={(event) => {
				setViewID(event.nativeEvent.viewID);
				setReactTag(event.nativeEvent.reactTag);
				props.onDidSetViewID?.(event);
			}}
		>
			{props.children}
		</RNIContextMenuNativeView>
	);
});