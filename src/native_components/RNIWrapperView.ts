import React from 'react';
import { requireNativeComponent, ViewProps, ViewStyle } from 'react-native';

import { RNIWrapperViewModule } from '../native_modules/RNIWrapperViewModule';

import * as Helpers from '../functions/Helpers';


export type RNIWrapperViewProps = ViewProps & {
  style?: ViewStyle;
  nativeID?: string;
  children?: React.ReactElement;

  shouldNotifyComponentWillUnmount?: boolean;  
  shouldAutoCleanupOnJSUnmount?: boolean;
  shouldAutoCleanupOnWindowNil?: boolean;
  shouldAutoSetSizeOnLayout?: boolean;

  isDummyView?: boolean;
  shouldAutoDetachSubviews?: boolean;
  
  shouldCreateTouchHandlerForParentView?: boolean;
  shouldCreateTouchHandlerForSubviews?: boolean;
};


const COMPONENT_NAME = 'RNIWrapperView';

const NativeComponent = 
  requireNativeComponent<RNIWrapperViewProps>(COMPONENT_NAME);


export class RNIWrapperView extends React.PureComponent<RNIWrapperViewProps> {
  nativeRef!: React.Component<RNIWrapperViewProps>;

  constructor(props: RNIWrapperViewProps){
    super(props);
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

  render(){
    const props = this.props;

    return React.createElement(NativeComponent, {
      ...props,
      ref: this._handleNativeRef,

      shouldNotifyComponentWillUnmount: 
        props.shouldNotifyComponentWillUnmount ?? false,
    });
  };
};