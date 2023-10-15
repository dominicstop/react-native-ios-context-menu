
import * as React from 'react';
import { StyleSheet, View } from 'react-native';

import { RNIContextMenuButtonModule } from './RNIContextMenuButtonModule';
import { RNIContextMenuNativeButton } from './RNIContextMenuNativeButton';

import type { RNIContextMenuButtonProps } from './RNIContextMenuButtonTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuButton extends React.PureComponent<RNIContextMenuButtonProps> {
  
  nativeRef?: View;

  constructor(props: RNIContextMenuButtonProps){
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

    await RNIContextMenuButtonModule.notifyOnComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  dismissMenu = async () => {
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.dismissMenu(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.provideDeferredElements(
      reactTag, 
      deferredID, 
      menuItems
    );
  };

  render(){
    return React.createElement(RNIContextMenuNativeButton, {
      ...this.props,
      style: [
        this.props.style,
        styles.nativeView
      ],
      // @ts-ignore
      ref: this._handleOnNativeRef,
    });
  };
};

const styles = StyleSheet.create({
  nativeView: {
  },
});