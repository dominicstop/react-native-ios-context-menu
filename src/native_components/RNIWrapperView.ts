import React from 'react';
import { requireNativeComponent, ViewStyle } from 'react-native';

import { RNIWrapperViewModule } from '../native_modules/RNIWrapperViewModule';

import * as Helpers from '../functions/Helpers';

import type { NativeSyntheticEvent } from 'react-native';


export type onRequestSizeOverrideEventObject = NativeSyntheticEvent<{
  newWidth : number;
  newHeight: number;
}>;

export type onRequestSizeOverrideEvent = (
  event: onRequestSizeOverrideEventObject
) => void;

export type RNIWrapperViewProps = {
  style?: ViewStyle;
  nativeID?: string;
  children?: React.ReactElement;
  shouldNotifyComponentWillUnmount?: boolean;
  
  onRequestSizeOverride: onRequestSizeOverrideEvent;
};

export type RNIWrapperViewState = {
  overrideWidth ?: number,
  overrideHeight?: number,
};


const COMPONENT_NAME = 'RNIWrapperView';

const NativeComponent = 
  requireNativeComponent<RNIWrapperViewProps>(COMPONENT_NAME);


export class RNIWrapperView extends React.PureComponent<RNIWrapperViewProps, RNIWrapperViewState> {
  nativeRef!: React.Component<RNIWrapperViewProps>;

  constructor(props: RNIWrapperViewProps){
    super(props);

    this.state = {
      overrideWidth : undefined,
      overrideHeight: undefined,
    };
  };

  private _handleNativeRef = (ref: React.Component<RNIWrapperViewProps>) => {
    this.nativeRef = ref;
  };

  componentWillUnmount(){
    const shouldNotifyComponentWillUnmount = 
      this.props.shouldNotifyComponentWillUnmount ?? false;

    if(shouldNotifyComponentWillUnmount){
      this.notifyComponentWillUnmount(false);
    };
  };

  notifyComponentWillUnmount = (isManuallyTriggered: boolean = true) => {
    RNIWrapperViewModule.notifyComponentWillUnmount(
      Helpers.getNativeNodeHandle(this.nativeRef), 
      { isManuallyTriggered }
    );
  };

  _handleOnRequestSizeOverride: onRequestSizeOverrideEvent = ({nativeEvent}) => {
    this.setState({
      overrideWidth : nativeEvent.newWidth ,
      overrideHeight: nativeEvent.newHeight,
    });
  };

  render(){
    const props = this.props;
    const state = this.state;

    const shouldOverrideSize =
      (state.overrideWidth != null || state.overrideHeight != null);

    return React.createElement(NativeComponent, {
      ...props,
      ref: this._handleNativeRef,

      style: {
        ...props.style,
        ...(shouldOverrideSize && {
          width : state.overrideWidth ,
          height: state.overrideHeight,
        }),
      },

      shouldNotifyComponentWillUnmount: 
        props.shouldNotifyComponentWillUnmount ?? false,

      onRequestSizeOverride: this._handleOnRequestSizeOverride,
    });
  };
};