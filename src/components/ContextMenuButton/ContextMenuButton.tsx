import React from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';

import { RNIContextMenuButton } from '../../native_components/RNIContextMenuButton';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnPressMenuItemEvent, OnRequestDeferredElementEvent } from '../../types/MenuEvents';
import type { ContextMenuButtonProps, ContextMenuButtonState } from './ContextMenuButtonTypes';

// @ts-ignore - TODO
import { ActionSheetFallback } from '../../functions/ActionSheetFallback';
import { ContextMenuView } from '../ContextMenuView';

import { ContextMenuButtonContext } from '../../context/ContextMenuButtonContext';

import { LIB_ENV, IS_PLATFORM_IOS } from '../../constants/LibEnv';
import type { MenuElementConfig } from '../../types/MenuConfig';


export class ContextMenuButton extends React.PureComponent<ContextMenuButtonProps, ContextMenuButtonState> {

  nativeRef!: RNIContextMenuButton;

  constructor(props: ContextMenuButtonProps){
    super(props);

    this.state = {
      menuVisible: false,
    };
  };

  getProps = () => {
    const {
      menuConfig,
      isContextMenuEnabled,
      isMenuPrimaryAction,
      useActionSheetFallback,
      internalViewCleanupMode,
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onPressMenuItem,
      onRequestDeferredElement,
      ...viewProps 
    } = this.props;

    return {
      // A. Provide default values to props...
      isContextMenuEnabled: (
        isContextMenuEnabled ?? true
      ),
      useActionSheetFallback: (
        useActionSheetFallback ?? !LIB_ENV.isContextMenuViewSupported
      ),
      internalViewCleanupMode: (
        internalViewCleanupMode ?? { mode: 'default' }
      ),
      isMenuPrimaryAction: (
        isMenuPrimaryAction ?? true
      ),

      // B. Pass down props...
      menuConfig,
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onPressMenuItem,
      onRequestDeferredElement,
      // C. Move all the default view-related
      //    props here...
      viewProps
    };
  };

  presentMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.presentMenu();
  };

  dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuButtonSupported) return;
    this.nativeRef.dismissMenu();
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    this.nativeRef.provideDeferredElements(
      deferredID, menuItems
    );
  };

  //#region - Handlers
  _handleGetRefToContextMenuButton = () => {
    return this;
  };

  _handleOnLongPress = async () => {
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

  _handleOnMenuWillShow: OnMenuWillShowEvent = (event) => {
    this.props.onMenuWillShow?.(event);
    event.stopPropagation();

    this.setState({menuVisible: true});
  };

  _handleOnMenuWillHide: OnMenuWillHideEvent = (event) => {
    this.props.onMenuWillHide?.(event);
    event.stopPropagation();

    this.setState({menuVisible: false});
  };

  _handleOnMenuWillCancel: OnMenuWillCancelEvent = (event) => {
    this.props.onMenuWillCancel?.(event);
    event.stopPropagation();
  };

  _handleOnMenuDidShow: OnMenuDidShowEvent = (event) => {
    this.props.onMenuDidShow?.(event);
    event.stopPropagation();
  };

  _handleOnMenuDidHide: OnMenuDidHideEvent = (event) => {
    this.props.onMenuDidHide?.(event);
    event.stopPropagation();
  };

  _handleOnMenuDidCancel: OnMenuDidCancelEvent = (event) => {
    this.props.onMenuDidCancel?.(event);

    // guard: event is a native event
    if(event.isUsingActionSheetFallback) return;
    event.stopPropagation();
  };

  _handleOnPressMenuItem: OnPressMenuItemEvent = (event) => {
    this.props.onPressMenuItem?.(event);

    // guard: event is a native event
    if(event.isUsingActionSheetFallback) return;
    event.stopPropagation();
  };

  private _handleOnRequestDeferredElement: OnRequestDeferredElementEvent = (event) => {
    const { onRequestDeferredElement } = this.props;
    const { deferredID } = event.nativeEvent;

    onRequestDeferredElement?.(deferredID, (items) => {
      this.provideDeferredElements(deferredID, items);
    });
  };
  //#endregion

  render(){
    const props = this.getProps();
    const state = this.state;

    const shouldUseContextMenuButton = (
      !props.useActionSheetFallback &&
      LIB_ENV.isContextMenuButtonSupported
    );

    const shouldUseContextMenuView = (
      !props.useActionSheetFallback &&
      !LIB_ENV.isContextMenuButtonSupported &&
      LIB_ENV.isContextMenuViewSupported
    );

    const shouldUseActionSheetFallback = (
      IS_PLATFORM_IOS && props.useActionSheetFallback
    );

    // TODO: Rename to 'sharedProps'
    const nativeComponentProps = {
      menuConfig: props.menuConfig,
      isContextMenuEnabled: props.isContextMenuEnabled,
      isMenuPrimaryAction: props.isMenuPrimaryAction,
      internalViewCleanupMode: props.internalViewCleanupMode,

      // event handlers
      onMenuWillShow: this._handleOnMenuWillShow,
      onMenuWillHide: this._handleOnMenuWillHide,
      onMenuDidShow: this._handleOnMenuDidShow,
      onMenuDidHide: this._handleOnMenuDidHide,
      onMenuDidCancel: this._handleOnMenuDidCancel,
      onMenuWillCancel: this._handleOnMenuWillCancel,
      onPressMenuItem: this._handleOnPressMenuItem,
      onRequestDeferredElement: this._handleOnRequestDeferredElement,
    };
    
    const contents = (
      shouldUseContextMenuButton? (
        // A - Use 'RNIContextMenuButton'
        <RNIContextMenuButton
          {...props.viewProps}
          {...nativeComponentProps}
          ref={r => { this.nativeRef = r! }}
          style={[styles.menuButton, props.viewProps.style]}
        >
          {props.viewProps.children}
        </RNIContextMenuButton>
      ): shouldUseContextMenuView? (
        // B - Use 'ContextMenuView' Fallback
        <ContextMenuView
          {...props.viewProps}
          {...nativeComponentProps}
          onRequestDeferredElement={props.onRequestDeferredElement}
        >
          {props.viewProps.children}
        </ContextMenuView>
      ): shouldUseActionSheetFallback? (
        // C - Use 'ActionSheet' Fallback
        <TouchableOpacity 
          onLongPress={this._handleOnLongPress}
          activeOpacity={0.8}
          {...props.viewProps}
        >
          {this.props.children}
        </TouchableOpacity>
      ): (
        // D - Use Regular View
        <View {...props.viewProps}>
          {this.props.children}
        </View>
      )
    );

    return (
      <ContextMenuButtonContext.Provider value={{
        getRefToContextMenuButton: this._handleGetRefToContextMenuButton,
        isMenuVisible: state.menuVisible,
      }}>
        {contents}
      </ContextMenuButtonContext.Provider>
    );
  };
};

const styles = StyleSheet.create({
  menuButton: {
    backgroundColor: 'transparent',
  },
});