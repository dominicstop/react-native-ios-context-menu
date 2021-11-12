import React from 'react';
import { StyleSheet, Platform, UIManager, View, TouchableOpacity, findNodeHandle } from 'react-native';
import Proptypes from 'prop-types';

import { RNIContextMenuView, RNIContextMenuViewCommands } from '../native_components/RNIContextMenuView';

import { PreviewType } from '../Enums';

import { ActionSheetFallback } from '../functions/ActionSheetFallback';


const isContextMenuSupported = (
  (Platform.OS === 'ios') &&
  (parseInt(Platform.Version, 10) > 12)
);



const NATIVE_PROP_KEYS = {
  // props: values ----------
  menuConfig   : 'menuConfig'   ,
  previewConfig: 'previewConfig',
  // props: events --------------------
  onMenuWillShow  : 'onMenuWillShow'  ,
  onMenuWillHide  : 'onMenuWillHide'  ,
  onMenuWillCancel: 'onMenuWillCancel',
  onMenuDidShow   : 'onMenuDidShow'   ,
  onMenuDidHide   : 'onMenuDidHide'   ,
  onMenuDidCancel : 'onMenuDidCancel' ,
  onMenuWillCreate: 'onMenuWillCreate',
  // props: onPress events ----------------
  onPressMenuItem   : 'onPressMenuItem'   ,
  onPressMenuPreview: 'onPressMenuPreview',
};

export class ContextMenuView extends React.PureComponent {
  static proptypes = {
    menuConfig   : Proptypes.object,
    previewConfig: Proptypes.object,
    renderPreview: Proptypes.func,
    // flags -----------------------
    lazyPreview           : Proptypes.bool,
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
    lazyPreview: true,
    previewType: PreviewType.DEFAULT,
    useActionSheetFallback: !isContextMenuSupported,
  };

  constructor(props){
    super(props);

    this.state = {
      menuVisible : false,
      mountPreview: false,
    };
  };

  getProps(){
    // TODO: fix this
    let otherProps  = { ...this.props };
    let nativeProps = {};

    const nativeKeys = Object.keys(NATIVE_PROP_KEYS);

    for (const key of nativeKeys) {
      nativeProps[key] = otherProps[key];
      delete otherProps[key];
    };

    return { nativeProps, ...otherProps };
  };

  dismissMenu = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.nativeRef),
      RNIContextMenuViewCommands?.dismissMenu,
      null
    );
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

  _handleOnMenuWillCreate = () => {
    this.setState({mountPreview: true});
  };

  _handleOnMenuWillShow = (event) => {
    const { onMenuWillShow } = this.props;
    onMenuWillShow?.(event);

    this.setState({menuVisible: true});
  };

  _handleOnMenuWillHide = (event) => {
    const { onMenuWillHide } = this.props;
    onMenuWillHide?.(event);

    this.setState({
      menuVisible : false,
      mountPreview: false,
    });
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
    const { onPressMenuItem } = this.props;
    onPressMenuItem?.(event);
  };

  _handleOnPressMenuPreview = (event) => {
    const { onPressMenuPreview } = this.props;
    onPressMenuPreview?.(event);
  };
  //#endregion

  _renderContextMenuView(){
    const { style, children, nativeProps, ...props } = this.getProps();
    const { menuVisible, mountPreview } = this.state;

    const nativeCompProps = {
      ...nativeProps,
      // Native Props: Events ------------------------------------------
      [NATIVE_PROP_KEYS.onMenuWillShow  ]: this._handleOnMenuWillShow  ,
      [NATIVE_PROP_KEYS.onMenuWillHide  ]: this._handleOnMenuWillHide  ,
      [NATIVE_PROP_KEYS.onMenuWillCancel]: this._handleOnMenuWillCancel,
      [NATIVE_PROP_KEYS.onMenuDidShow   ]: this._handleOnMenuDidShow   ,
      [NATIVE_PROP_KEYS.onMenuDidHide   ]: this._handleOnMenuDidHide   ,
      [NATIVE_PROP_KEYS.onMenuDidCancel ]: this._handleOnMenuDidCancel ,
      [NATIVE_PROP_KEYS.onMenuWillCreate]: this._handleOnMenuWillCreate,
      // Native Props: OnPress Events --------------------------------------
      [NATIVE_PROP_KEYS.onPressMenuItem   ]: this._handleOnPressMenuItem   ,
      [NATIVE_PROP_KEYS.onPressMenuPreview]: this._handleOnPressMenuPreview,
    };

    return(
      <RNIContextMenuView
        style={[styles.menuView, style]}
        ref={r => this.nativeRef = r}
        {...nativeCompProps}
      >
        <View style={styles.previewContainer}>
          {(mountPreview || !props.lazyPreview) && (
            props.renderPreview?.()
          )}
        </View>
        {React.Children.map(children, child => 
          React.cloneElement(child, {menuVisible})
        )}
      </RNIContextMenuView>
    );
  };

  render(){
    const { useActionSheetFallback, children, ...props } = this.getProps();
    const useContextMenuView = 
      (isContextMenuSupported && !useActionSheetFallback);

    return(
      useContextMenuView? this._renderContextMenuView() : 
      useActionSheetFallback? (
        <TouchableOpacity 
          onLongPress={this._handleOnLongPress}
          activeOpacity={0.8}
          {...props}
        >
          {children}
        </TouchableOpacity>
      ):(
        <View {...props}>
          {children}
        </View>
      )
    );
  };
};

const styles = StyleSheet.create({
  menuView: {
    backgroundColor: 'transparent',
  },
  previewContainer: {
    position: 'absolute',
    backgroundColor: 'transparent',
  },
});