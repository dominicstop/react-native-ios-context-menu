import React from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';

import { RNIContextMenuView } from '../../native_components/RNIContextMenuView';
import { RNIWrapperView } from '../../native_components/RNIWrapperView';

import { RNIContextMenuViewModule } from '../../native_modules/RNIContextMenuViewModule';

import { ContextMenuViewContext } from '../../context/ContextMenuViewContext';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent } from '../../types/MenuEvents';
import type { ContextMenuViewProps, ContextMenuViewState } from './ContextMenuViewTypes';

// @ts-ignore - TODO
import { ActionSheetFallback } from '../../functions/ActionSheetFallback';
import { LIB_ENV, IS_PLATFORM_IOS } from '../../constants/LibEnv';

import * as Helpers from '../../functions/Helpers';


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

  private getProps = () => {
    const {  
      useActionSheetFallback,
      menuConfig,
      previewConfig,
      shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle,
      // event props
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
      // A. Provide default values to props...
      lazyPreview: (
        lazyPreview ?? true
      ),
      useActionSheetFallback: (
        useActionSheetFallback ?? !LIB_ENV.isContextMenuViewSupported
      ),
      shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle: (
        shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle ?? true
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

  dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    await RNIContextMenuViewModule.dismissMenu(
      Helpers.getNativeNodeHandle(this.nativeRef),
    );
  };

  //#region - Handlers
  private _handleGetRefToContextMenuView = () => {
    return this;
  };

  private _handleOnLongPress = async () => {
    const props = this.props;
    
    if(props.menuConfig == null) return;

    const selectedItem = 
      await ActionSheetFallback.show(props.menuConfig);
  
    if(selectedItem == null){
      // A. cancelled pressed
      props.onMenuDidCancel?.({
        isUsingActionSheetFallback: true
      });

    } else {
      // B. an item was selected
      props.onPressMenuItem?.({
        isUsingActionSheetFallback: true,
        nativeEvent: {
          ...selectedItem,
        }
      });
    };
  };

  private _handleOnMenuWillCreate: OnMenuWillCreateEvent = (event) => {
    event.stopPropagation();
    this.setState({mountPreview: true});
  };

  private _handleOnMenuWillShow: OnMenuWillShowEvent = (event) => {
    this.props.onMenuWillShow?.(event);
    event.stopPropagation();

    this.setState({menuVisible: true});
  };

  private _handleOnMenuWillHide: OnMenuWillHideEvent = (event) => {
    this.props.onMenuWillHide?.(event);
    event.stopPropagation();

    this.setState({
      menuVisible : false,
      mountPreview: false,
    });
  };

  private _handleOnMenuWillCancel: OnMenuWillCancelEvent = (event) => {
    this.props.onMenuWillCancel?.(event);
    event.stopPropagation();
  };

  private _handleOnMenuDidShow: OnMenuDidShowEvent = (event) => {
    this.props.onMenuDidShow?.(event);
    event.stopPropagation();
  };

  private _handleOnMenuDidHide: OnMenuDidHideEvent = (event) => {
    this.props.onMenuDidHide?.(event);
    event.stopPropagation();
  };

  private _handleOnMenuDidCancel: OnMenuDidCancelEvent = (event) => {
    this.props.onMenuDidCancel?.(event);

    // guard: event is a native event
    if(event.isUsingActionSheetFallback) return;
    event.stopPropagation();
  };

  private _handleOnPressMenuItem: OnPressMenuItemEvent = (event) => {
    this.props.onPressMenuItem?.(event);

    // guard: event is a native event
    if(event.isUsingActionSheetFallback) return;
    event.stopPropagation();
  };

  private _handleOnPressMenuPreview: OnPressMenuPreviewEvent = (event) => {
    this.props.onPressMenuPreview?.(event);
    event.stopPropagation();
  };
  //#endregion

  render(){
    const props = this.getProps();
    const state = this.state;

    const shouldUseContextMenuView = (
      LIB_ENV.isContextMenuViewSupported && 
      !props.useActionSheetFallback
    );

    const shouldUseActionSheetFallback = (
      IS_PLATFORM_IOS && props.useActionSheetFallback
    );

    const shouldMountPreview = (
      (props.renderPreview != null) &&
      (state.mountPreview || !props.lazyPreview)
    );

    const contents = (
      shouldUseContextMenuView? (
        // A - Use Context Menu View
        <RNIContextMenuView
          {...props.viewProps}
          style={[styles.menuView, props.viewProps.style]}
          ref={r => { this.nativeRef = r! }}

          menuConfig={props.menuConfig}
          previewConfig={props.previewConfig}
          
          // Events: `onPress`-Related
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
          {shouldMountPreview && (
            <RNIWrapperView 
              style={styles.previewContainer}
              shouldNotifyComponentWillUnmount={false}
            >
              {props.renderPreview?.()}
            </RNIWrapperView>
          )}
          {props.viewProps.children}
        </RNIContextMenuView>
      ): shouldUseActionSheetFallback? (
        // B - Use Context Menu Fallback
        <TouchableOpacity 
          onLongPress={this._handleOnLongPress}
          activeOpacity={0.8}
          {...props.viewProps}
        >
          {this.props.children}
        </TouchableOpacity>
      ):(
        // C - Use Regular View
        <View {...props.viewProps}>
          {this.props.children}
        </View>
      )
    );

    return (
      <ContextMenuViewContext.Provider value={{
        getRefToContextMenuView: this._handleGetRefToContextMenuView,
        isMenuVisible: state.menuVisible,
      }}>
        {contents}
      </ContextMenuViewContext.Provider>
    );
  };
};

const styles = StyleSheet.create({
  menuView: {
    backgroundColor: 'transparent',
  },
  previewContainer: {
    position: 'absolute',
    overflow: 'visible',
    backgroundColor: 'transparent',
  },
});