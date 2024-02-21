
import * as React from 'react';
import { LayoutChangeEvent, StyleSheet, View } from 'react-native';

import { RNIUtilitiesModule } from 'react-native-ios-utilities';

import { RNIContextMenuButtonModule } from './RNIContextMenuButtonModule';
import { RNIContextMenuNativeButton } from './RNIContextMenuNativeButton';

import type { RNIContextMenuButtonProps } from './RNIContextMenuButtonTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuButton extends React.PureComponent<RNIContextMenuButtonProps> {
  
  nativeRef?: View;
  reactTag?: number;

  constructor(props: RNIContextMenuButtonProps){
    super(props);
  };

  componentWillUnmount(){
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    RNIUtilitiesModule.notifyOnComponentWillUnmount(
      reactTag, {
        shouldForceCleanup: true,
        shouldIgnoreCleanupTriggers: false,
      }
    );
  };

  getNativeRef: () => View | undefined = () => {
    return this.nativeRef;
  };

  getNativeReactTag: () => number | undefined = () => {
    // @ts-ignore
    return this.nativeRef?.nativeTag ?? this.reactTag;
  };

  presentMenu = async () => {
    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.presentMenu(reactTag);
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

    await RNIContextMenuButtonModule.provideDeferredElements(reactTag, { 
      deferredID, 
      menuItems 
    });
  };

  private _handleOnNativeRef = (ref: View) => {
    this.nativeRef = ref;
  };

  private _handleOnLayout = ({nativeEvent}: LayoutChangeEvent) => {
    // @ts-ignore
    this.reactTag = nativeEvent.target;
  };

  render(){
    return React.createElement(RNIContextMenuNativeButton, {
      ...this.props,
      ...((this.reactTag == null) && {
        onLayout: this._handleOnLayout,
      }),
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