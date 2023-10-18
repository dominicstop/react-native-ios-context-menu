import * as React from 'react';
import { StyleSheet, View } from 'react-native';

import { RNIContextMenuViewModule } from './RNIContextMenuViewModule';
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { RNIContextMenuViewProps } from './RNIContextMenuViewTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuView extends React.PureComponent<RNIContextMenuViewProps> {
  
  nativeRef?: View;

  constructor(props: RNIContextMenuViewProps){
    super(props);
  };

  componentWillUnmount(){
    this.notifyOnComponentWillUnmount(false);
  };

  getNativeRef: () => View | undefined = () => {
    return this.nativeRef;
  };

  getNativeReactTag: () => number | undefined = () => {
    // @ts-ignore
    return this.nativeRef?.nativeTag;
  };

  notifyOnComponentWillUnmount = async (isManuallyTriggered: boolean = true) => {
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.notifyOnComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  dismissMenu = async () => {
    const reactTag = this.getNativeReactTag();
    console.log("dismissMenu - reactTag:", reactTag);
    console.log("dismissMenu - this.nativeRef:", this.nativeRef);
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.dismissMenu(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.provideDeferredElements(reactTag, { 
      deferredID, 
      menuItems 
    });
  };

  private _handleOnNativeRef = (ref: View) => {
    this.nativeRef = ref;
  };

  render(){
    return React.createElement(RNIContextMenuNativeView, {
      ...this.props,
      // @ts-ignore
      ref: this._handleOnNativeRef,
      style: [
        this.props.style,
        styles.nativeView
      ],
    });
  };
};

const styles = StyleSheet.create({
  nativeView: {
  },
});