import * as React from 'react';

import { type StateViewID, type StateReactTag } from "react-native-ios-utilities";
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { 
  RNIContextMenuViewProps, 
  RNIContextMenuViewRef, 
} from './RNIContextMenuViewTypes';

import * as Helpers from '../../functions/Helpers';


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
    presentMenu: async () => {
      if(viewID == null) return;
      const module = Helpers.getRNIUtilitiesModule();

      await module.viewCommandRequest(
        /* viewID     : */ viewID,
        /* commandName: */ 'presentMenu',
        /* commandArgs: */ {}
      );
    },
    dismissMenu: async () => {
      if(viewID == null) return;
      const module = Helpers.getRNIUtilitiesModule();

      await module.viewCommandRequest(
        /* viewID     : */ viewID,
        /* commandName: */ 'dismissMenu',
        /* commandArgs: */ {}
      );
    },
    showAuxiliaryPreviewAsPopover: async () => {
      if(viewID == null) return;
      const module = Helpers.getRNIUtilitiesModule();

      await module.viewCommandRequest(
        /* viewID     : */ viewID,
        /* commandName: */ 'showAuxiliaryPreviewAsPopover',
        /* commandArgs: */ {}
      );
    },
    provideDeferredElements: async (deferredID, menuItems) => {
      if(viewID == null) return;
      const module = Helpers.getRNIUtilitiesModule();

      const commandArgs = {
        deferredID,
        menuItems,
      };

      await module.viewCommandRequest(
        /* viewID     : */ viewID,
        /* commandName: */ 'provideDeferredElements',
        /* commandArgs: */ commandArgs
      );
    },
  }));

  return (
    <RNIContextMenuNativeView
      {...props}
      onDidSetViewID={(event) => {
        setViewID(event.nativeEvent.viewID);
        setReactTag(event.nativeEvent.reactTag);

        props.onDidSetViewID?.(event);
        event.stopPropagation();
      }}
    >
      {props.children}
    </RNIContextMenuNativeView>
  );
});