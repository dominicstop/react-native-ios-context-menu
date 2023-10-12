import * as React from 'react';
import { StyleSheet } from 'react-native';

import { OnReactTagDidSetEvent } from 'react-native-ios-utilities';

import { RNIContextMenuViewModule } from './RNIContextMenuViewModule';
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { RNIContextMenuViewProps } from './RNIContextMenuViewTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuView extends React.PureComponent<RNIContextMenuViewProps> {
  
  reactTag?: number;

  constructor(props: RNIContextMenuViewProps){
    super(props);
  };

  componentWillUnmount(){
    this.notifyComponentWillUnmount(false);
  };

  notifyComponentWillUnmount = async (isManuallyTriggered: boolean = true) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.notifyComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  dismissMenu = async () => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.dismissMenu(reactTag);
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    await RNIContextMenuViewModule.provideDeferredElements(
      reactTag, 
      deferredID, 
      menuItems
    );
  };

  private _handleOnReactTagDidSet: OnReactTagDidSetEvent = ({nativeEvent}) => {
    this.reactTag = nativeEvent.reactTag;
  };

  render(){
    return React.createElement(RNIContextMenuNativeView, {
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