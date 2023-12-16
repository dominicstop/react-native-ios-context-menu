
import * as React from 'react';
import { LayoutChangeEvent, StyleSheet, View } from 'react-native';

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
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    this.notifyOnComponentWillUnmount(false);
  };

  getNativeRef: () => View | undefined = () => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    return this.nativeRef;
  };

  getNativeReactTag: () => number | undefined = () => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    // @ts-ignore
    return this.nativeRef?.nativeTag ?? this.reactTag;
  };

  notifyOnComponentWillUnmount = async (isManuallyTriggered: boolean = true) => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.notifyOnComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  presentMenu = async () => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.presentMenu(reactTag);
  };

  dismissMenu = async () => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.dismissMenu(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.provideDeferredElements(reactTag, { 
      deferredID, 
      menuItems 
    });
  };

  private _handleOnNativeRef = (ref: View) => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    this.nativeRef = ref;
  };

  private _handleOnLayout = ({nativeEvent}: LayoutChangeEvent) => {
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return;
    }

    // @ts-ignore
    this.reactTag = nativeEvent.target;
  };

  render(){
    if (!RNIContextMenuNativeButton) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuButton is not available on this platform'
        );
      }

      return null;
    }

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