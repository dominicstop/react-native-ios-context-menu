import * as React from 'react';
import { StyleSheet } from 'react-native';

import { OnReactTagDidSetEvent } from 'react-native-ios-utilities';

import { RNIContextMenuViewModule } from './RNIContextMenuViewModule';
import { RNIContextMenuNativeView } from './RNIContextMenuNativeView';

import type { RNIContextMenuNativeViewProps } from './RNIContextMenuNativeViewTypes';
import { MenuElementConfig } from '../../types/MenuConfig';


export class RNIContextMenuView extends React.PureComponent<RNIContextMenuNativeViewProps> {
  
  reactTag?: number;

  constructor(props: RNIContextMenuNativeViewProps){
    super(props);
  };

  componentWillUnmount(){
    this.notifyComponentWillUnmount(false);
  };

  notifyComponentWillUnmount = (isManuallyTriggered: boolean = true) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    RNIContextMenuViewModule.notifyComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  dismissMenu = () => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    RNIContextMenuViewModule.dismissMenu(reactTag);
  };

  provideDeferredElements = (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    RNIContextMenuViewModule
      .provideDeferredElements(reactTag, deferredID, menuItems);
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