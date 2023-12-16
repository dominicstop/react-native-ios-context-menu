import * as React from 'react';
import { LayoutChangeEvent, StyleSheet, View } from 'react-native';

import { RNIContextMenuViewModule } from './RNIContextMenuViewModule';
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { RNIContextMenuViewProps } from './RNIContextMenuViewTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuView extends React.PureComponent<RNIContextMenuViewProps> {
  
  nativeRef?: View;
  reactTag?: number;

  constructor(props: RNIContextMenuViewProps){
    super(props);
  };

  componentWillUnmount(){
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    this.notifyOnComponentWillUnmount(false);
  };

  getNativeRef: () => View | undefined = () => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    return this.nativeRef;
  };

  getNativeReactTag: () => number | undefined = () => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    // @ts-ignore
    return this.nativeRef?.nativeTag ?? this.reactTag
  };

  notifyOnComponentWillUnmount = async (isManuallyTriggered: boolean = true) => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.notifyOnComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  presentMenu = async () => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }


    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.presentMenu(reactTag);
  };

  dismissMenu = async () => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }


    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.dismissMenu(reactTag);
  };

  showAuxiliaryPreviewAsPopover = async () => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }


    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.showAuxiliaryPreviewAsPopover(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    const reactTag = this.getNativeReactTag();
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.provideDeferredElements(reactTag, { 
      deferredID, 
      menuItems 
    });
  };

  private _handleOnLayout = ({nativeEvent}: LayoutChangeEvent) => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    // @ts-ignore
    this.reactTag = nativeEvent.target;
  };

  private _handleOnNativeRef = (ref: View) => {
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    this.nativeRef = ref;
  };

  render(){
    if (!RNIContextMenuNativeView) {
      if (__DEV__) {
        console.warn(
          'RNIContextMenuView is not available on this platform'
        );
      }

      return;
    }

    return React.createElement(RNIContextMenuNativeView, {
      ...this.props,
      ...((this.reactTag == null) && {
        onLayout: this._handleOnLayout,
      }),
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