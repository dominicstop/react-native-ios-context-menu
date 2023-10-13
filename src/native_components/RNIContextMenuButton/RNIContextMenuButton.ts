
import * as React from 'react';
import { StyleSheet } from 'react-native';

import { OnReactTagDidSetEvent } from 'react-native-ios-utilities';

import { RNIContextMenuButtonModule } from './RNIContextMenuButtonModule';
import { RNIContextMenuNativeButton } from './RNIContextMenuNativeButton';

import type { RNIContextMenuButtonProps } from './RNIContextMenuButtonTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuButton extends React.PureComponent<RNIContextMenuButtonProps> {
  
  reactTag?: number;

  constructor(props: RNIContextMenuButtonProps){
    super(props);
  };

  componentWillUnmount(){
    this.notifyComponentWillUnmount(false);
  };

  notifyComponentWillUnmount = async (isManuallyTriggered: boolean = true) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.notifyComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  dismissMenu = async () => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.dismissMenu(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuButtonModule.provideDeferredElements(
      reactTag, 
      deferredID, 
      menuItems
    );
  };

  private _handleOnReactTagDidSet: OnReactTagDidSetEvent = ({nativeEvent}) => {
    this.reactTag = nativeEvent.reactTag;
  };

  render(){
    return React.createElement(RNIContextMenuNativeButton, {
      ...this.props,
      style: [
        this.props.style,
        styles.nativeView
      ],
      onReactTagDidSet: this._handleOnReactTagDidSet,
    });
  };
};

const styles = StyleSheet.create({
  nativeView: {
  },
});