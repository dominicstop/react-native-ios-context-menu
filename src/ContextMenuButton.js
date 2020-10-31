import React from 'react';
import { StyleSheet, Platform, requireNativeComponent, UIManager, View, TouchableOpacity } from 'react-native';
import Proptypes from 'prop-types';

import { ActionSheetFallback } from './functions/ActionSheetFallback';


const isContextMenuSupported = (
  (Platform.OS === 'ios') &&
  (parseInt(Platform.Version, 10) > 13)
);


const componentName   = "RCTContextMenuButton";
const NativeCommands  = UIManager[componentName]?.Commands;
const NativeComponent = requireNativeComponent(componentName);

const NATIVE_PROP_KEYS = {
  // props: values --------
  menuConfig: 'menuConfig',
  // props: events --------------------
  onMenuWillShow  : 'onMenuWillShow'  ,
  onMenuWillHide  : 'onMenuWillHide'  ,
  onMenuWillCancel: 'onMenuWillCancel',
  onMenuDidShow   : 'onMenuDidShow'   ,
  onMenuDidHide   : 'onMenuDidHide'   ,
  onMenuDidCancel : 'onMenuDidCancel' ,
  // props: onPress events ----------------
  onPressMenuItem   : 'onPressMenuItem',
};


export class ContextMenuButton extends React.PureComponent {
  static proptypes = {
    menuConfig: Proptypes.object,
    useActionSheetFallback: Proptypes.bool,
    // events -----------------------
    onMenuWillShow  : Proptypes.func,
    onMenuWillHide  : Proptypes.func,
    onMenuWillCancel: Proptypes.func,
    onMenuDidShow   : Proptypes.func,
    onMenuDidHide   : Proptypes.func,
    onMenuDidCancel : Proptypes.func,
    // onPress events -----------------
    onPressMenuItem   : Proptypes.func,
    onPressMenuPreview: Proptypes.func,
  };

  static defaultProps = {
    useActionSheetFallback: !isContextMenuSupported,
  };

  constructor(props){
    super(props);

    this.state = {
      menuVisible: false,
    };
  };

  //#region - Event Handlers
  _handleOnLongPress = async () => {
    const { menuConfig, ...props } = this.props;
    const item = await ActionSheetFallback.show(menuConfig);
  
    if(item == null){
      // cancelled pressed
      props.onMenuDidCancel?.();

    } else {
      props.onPressMenuItem?.({nativeEvent: {...item}});
    };
  };

  _handleOnMenuWillShow = (event) => {
    const { onMenuWillShow } = this.props;
    onMenuWillShow?.(event);

    this.setState({menuVisible: true});
  };

  _handleOnMenuWillHide = (event) => {
    const { onMenuWillHide } = this.props;
    onMenuWillHide?.(event);

    this.setState({menuVisible: false});
  };

  _handleOnMenuWillCancel = (event) => {
    const { onMenuWillCancel } = this.props;
    onMenuWillCancel?.(event);
  };

  _handleOnMenuDidShow = (event) => {
    const { onMenuDidShow } = this.props;
    onMenuDidShow?.(event);
  };

  _handleOnMenuDidHide = (event) => {
    const { onMenuDidHide } = this.props;
    onMenuDidHide?.(event);
  };

  _handleOnMenuDidCancel = (event) => {
    const { onMenuDidCancel } = this.props;
    onMenuDidCancel?.(event);
  };

  _handleOnPressMenuItem = (event) => {
    this.props.onPressMenuItem?.(event);
  };
  //#endregion

  _renderContextMenuView(){
    const { style, children, ...props } = this.props;
    const { menuVisible } = this.state;

    const nativeProps = {
      ...props,
      // Native Props: Events ------------------------------------------
      [NATIVE_PROP_KEYS.onMenuWillShow  ]: this._handleOnMenuWillShow  ,
      [NATIVE_PROP_KEYS.onMenuWillHide  ]: this._handleOnMenuWillHide  ,
      [NATIVE_PROP_KEYS.onMenuWillCancel]: this._handleOnMenuWillCancel,
      [NATIVE_PROP_KEYS.onMenuDidShow   ]: this._handleOnMenuDidShow   ,
      [NATIVE_PROP_KEYS.onMenuDidHide   ]: this._handleOnMenuDidHide   ,
      [NATIVE_PROP_KEYS.onMenuDidCancel ]: this._handleOnMenuDidCancel ,
      // Native Props: OnPress Events --------------------------------------
      [NATIVE_PROP_KEYS.onPressMenuItem]: this._handleOnPressMenuItem,
    };

    return(
      <NativeComponent
        style={[styles.menuView, style]}
        {...nativeProps}
      >
        {React.Children.map(children, child => 
          React.cloneElement(child, {menuVisible})
        )}
      </NativeComponent>
    );
  };

  render(){
    const { useActionSheetFallback, ...props } = this.props;
    const useContextMenuView = 
      (isContextMenuSupported && !useActionSheetFallback);

    return(
      useContextMenuView? this._renderContextMenuView() : 
      useActionSheetFallback? (
        <TouchableOpacity 
          onLongPress={this._handleOnLongPress}
          activeOpacity={0.8}
          {...this.props}
        >
          {this.props.children}
        </TouchableOpacity>
      ):(
        <View {...this.props}>
          {this.props.children}
        </View>
      )
    );
  };
};

const styles = StyleSheet.create({
  menuView: {
    backgroundColor: 'transparent',
  },
});