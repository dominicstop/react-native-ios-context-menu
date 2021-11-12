import React from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';
import Proptypes from 'prop-types';

import { RNIContextMenuButton } from '../native_components/RNIContextMenuButton';

import { ActionSheetFallback } from '../functions/ActionSheetFallback';
import { ContextMenuView } from './ContextMenuView';

import { LIB_ENV } from '../constants/LibEnv';

const NATIVE_PROP_KEYS = {
  // props: values --------
  menuConfig: 'menuConfig',
  // props: flags ---------------------------
  enableContextMenu  : 'enableContextMenu'  ,
  isMenuPrimaryAction: 'isMenuPrimaryAction',
  // props: events --------------------
  onMenuWillShow  : 'onMenuWillShow'  ,
  onMenuWillHide  : 'onMenuWillHide'  ,
  onMenuWillCancel: 'onMenuWillCancel',
  onMenuDidShow   : 'onMenuDidShow'   ,
  onMenuDidHide   : 'onMenuDidHide'   ,
  onMenuDidCancel : 'onMenuDidCancel' ,
  // props: onPress events ----------
  onPressMenuItem: 'onPressMenuItem',
};


export class ContextMenuButton extends React.PureComponent {
  static proptypes = {
    menuConfig: Proptypes.object,
    // flags ------------------------------
    enableContextMenu     : Proptypes.bool,
    isMenuPrimaryAction   : Proptypes.bool,
    useActionSheetFallback: Proptypes.bool,
    wrapNativeComponent   : Proptypes.bool,
    // events -----------------------
    onMenuWillShow  : Proptypes.func,
    onMenuWillHide  : Proptypes.func,
    onMenuWillCancel: Proptypes.func,
    onMenuDidShow   : Proptypes.func,
    onMenuDidHide   : Proptypes.func,
    onMenuDidCancel : Proptypes.func,
    // onPress events --------------
    onPressMenuItem: Proptypes.func,
  };

  static defaultProps = {
    enableContextMenu     : true,
    wrapNativeComponent   : true,
    useActionSheetFallback: !LIB_ENV.isContextMenuViewSupported,
  };

  constructor(props){
    super(props);

    this.state = {
      menuVisible: false,
    };
  };

  getProps(){
    const otherProps  = { ...this.props };
    const nativeProps = {};

    const nativeKeys = Object.keys(NATIVE_PROP_KEYS);

    for (const key of nativeKeys) {
      nativeProps[key] = otherProps[key];
      delete otherProps[key];
    };

    return { nativeProps, ...otherProps };
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
    const { nativeProps, style, children, ...props } = this.getProps();
    const { menuVisible } = this.state;

    const nativeCompProps = {
      ...nativeProps,
      // Native Props: Events ------------------------------------------
      [NATIVE_PROP_KEYS.onMenuWillShow  ]: this._handleOnMenuWillShow  ,
      [NATIVE_PROP_KEYS.onMenuWillHide  ]: this._handleOnMenuWillHide  ,
      [NATIVE_PROP_KEYS.onMenuWillCancel]: this._handleOnMenuWillCancel,
      [NATIVE_PROP_KEYS.onMenuDidShow   ]: this._handleOnMenuDidShow   ,
      [NATIVE_PROP_KEYS.onMenuDidHide   ]: this._handleOnMenuDidHide   ,
      [NATIVE_PROP_KEYS.onMenuDidCancel ]: this._handleOnMenuDidCancel ,
      // Native Props: OnPress Events --------------------------------
      [NATIVE_PROP_KEYS.onPressMenuItem]: this._handleOnPressMenuItem,
    };

    const childItems = React.Children.map(children, child => 
      React.cloneElement(child, {menuVisible})
    );

    const nativeComp = (LIB_ENV.isContextMenuButtonSupported? (
      <RNIContextMenuButton
        {...nativeCompProps}
        style={(props.wrapNativeComponent
          ? styles.wrappedMenuButton
          : [styles.menuButton, style]
        )}
      >
        {childItems}
      </RNIContextMenuButton>
    ):(
      <ContextMenuView
        {...nativeCompProps}
      >
        {childItems}
      </ContextMenuView>
    ));

    if(props.wrapNativeComponent){
      return(
        <TouchableOpacity
          activeOpacity={0.8}
          {...{style, ...props}}
        >
          {nativeComp}
        </TouchableOpacity>
      );
    } else {
      return nativeComp;
    };
  };

  render(){
    const { useActionSheetFallback } = this.props;
    const useContextMenu = 
      (LIB_ENV.isContextMenuViewSupported && !useActionSheetFallback);

    return(
      useContextMenu? this._renderContextMenuView() : 
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
  menuButton: {
    backgroundColor: 'transparent',
  },
  wrappedMenuButton: {
    flex: 1,
  },
});