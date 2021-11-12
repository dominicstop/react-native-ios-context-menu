import React from 'react';
import { StyleSheet, UIManager, View, TouchableOpacity, findNodeHandle, ViewProps } from 'react-native';

import { RNIContextMenuView, RNIContextMenuViewCommands, RNIContextMenuViewProps } from '../native_components/RNIContextMenuView';

import { ActionSheetFallback } from '../functions/ActionSheetFallback';
import { LIB_ENV, IS_PLATFORM_IOS } from '../constants/LibEnv';


export type RenderPreviewItem = () => React.ReactElement | null | undefined;

export type ContextMenuViewBaseProps = Pick<RNIContextMenuViewProps,
  | 'menuConfig'
  | 'previewConfig'
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
> & {
  lazyPreview: boolean;
  useActionSheetFallback: boolean;

  renderPreview: RenderPreviewItem;
};

export type ContextMenuViewProps = 
  ContextMenuViewBaseProps & ViewProps;

export type ContextMenuViewState = {
  menuVisible: boolean;
  mountPreview: boolean;
};


export class ContextMenuView extends 
  React.PureComponent<ContextMenuViewProps, ContextMenuViewState> {

  static defaultProps = {
    useActionSheetFallback: !LIB_ENV.isContextMenuViewSupported,
  };

  nativeRef!: React.Component;

  constructor(props: ContextMenuViewProps){
    super(props);

    this.state = {
      menuVisible : false,
      mountPreview: false,
    };
  };

  getProps = () => {
    const {  
      useActionSheetFallback,
      menuConfig,
      previewConfig,
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onPressMenuItem,
      onPressMenuPreview,
      lazyPreview,
      renderPreview,
      ...viewProps 
    } = this.props;

    return {
      // A. Add default values to props...
      lazyPreview: (
        lazyPreview ?? true
      ),
      useActionSheetFallback: (
        useActionSheetFallback ?? !LIB_ENV.isContextMenuViewSupported
      ),

      // B. Pass down props...
      menuConfig,
      previewConfig,
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onPressMenuItem,
      onPressMenuPreview,
      renderPreview,

      // C. Move all the default view-related
      //    props here...
      viewProps
    };
  };

  dismissMenu = () => {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this.nativeRef),
      RNIContextMenuViewCommands?.dismissMenu
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


  render(){
    const props = this.getProps();
    const { menuVisible, mountPreview } = this.state;

    const shouldUseContextMenuView = (
      LIB_ENV.isContextMenuViewSupported && 
      !props.useActionSheetFallback
    );

    const shouldUseActionSheetFallback = (
      IS_PLATFORM_IOS && props.useActionSheetFallback
    );

    if(shouldUseContextMenuView){
      // A - Use Context Menu View
      return (
        <RNIContextMenuView
          style={[styles.menuView, props.viewProps.style]}
          ref={r => { this.nativeRef = r! }}
          menuConfig={props.menuConfig}

          // Events: Menu Lifecycle
          onMenuWillShow={this._handleOnMenuWillShow}
          onMenuWillHide={this._handleOnMenuWillHide}
          onMenuWillCancel={this._handleOnMenuWillCancel}
          onMenuDidShow={this._handleOnMenuDidShow}
          onMenuDidHide={this._handleOnMenuDidHide}
          onMenuDidCancel={this._handleOnMenuDidCancel}
          onMenuWillCreate={this._handleOnMenuWillCreate}

          // Events: `onPress`-Related
          onPressMenuItem={this._handleOnPressMenuItem}
          onPressMenuPreview={this._handleOnPressMenuPreview}
        >
          <View style={styles.previewContainer}>
            {(mountPreview || !props.lazyPreview) && (
              props.renderPreview?.()
            )}
          </View>
          {React.Children.map(this.props.children, (child) => 
            //@ts-ignore
            React.cloneElement(child, {menuVisible})
          )}
        </RNIContextMenuView>
      );

    } else if (shouldUseActionSheetFallback){
      // B - Use Context Menu Fallback
      return (
        <TouchableOpacity 
          onLongPress={this._handleOnLongPress}
          activeOpacity={0.8}
          {...props.viewProps}
        >
          {this.props.children}
        </TouchableOpacity>
      );

    } else {
      // C - Use Regular View
      return (
        <View {...props.viewProps}>
          {this.props.children}
        </View>
      );
    };
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