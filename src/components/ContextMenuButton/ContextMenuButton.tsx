import React from 'react';
import { StyleSheet, View } from 'react-native';

import { RNIContextMenuButton, type RNIContextMenuButtonRef } from '../../native_components/RNIContextMenuButton';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnPressMenuItemEvent, OnRequestDeferredElementEvent } from '../../types/SharedMenuEvents';
import type { ContextMenuButtonProps, ContextMenuButtonState } from './ContextMenuButtonTypes';

import { ContextMenuView } from '../ContextMenuView';

import { ContextMenuButtonContext } from '../../context/ContextMenuButtonContext';

import { LIB_ENV } from '../../constants/LibEnv';
import type { MenuElementConfig } from '../../types/MenuConfig';
import type { RNIContextMenuViewRef } from '../../native_components/RNIContextMenuView';


export class ContextMenuButton extends React.PureComponent<ContextMenuButtonProps, ContextMenuButtonState> {

  private nativeRef!: RNIContextMenuButtonRef | RNIContextMenuViewRef;

  constructor(props: ContextMenuButtonProps){
    super(props);

    this.state = {
      menuVisible: false,
    };
  };

  private getProps = () => {
    const {
      menuConfig,
      isContextMenuEnabled,
      isMenuPrimaryAction,
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

  public presentMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.presentMenu();
  };

  public dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuButtonSupported) return;
    this.nativeRef.dismissMenu();
  };

  public provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    this.nativeRef.provideDeferredElements(
      deferredID, menuItems
    );
  };

  private _handleGetRefToContextMenuButton = () => {
    return this;
  };

  private _handleOnMenuWillShow: OnMenuWillShowEvent = (event) => {
    this.props.onMenuWillShow?.(event);
    event.stopPropagation();

    this.setState({menuVisible: true});
  };

  private _handleOnMenuWillHide: OnMenuWillHideEvent = (event) => {
    this.props.onMenuWillHide?.(event);
    event.stopPropagation();

    this.setState({menuVisible: false});
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
    event.stopPropagation();
  };

  private _handleOnRequestDeferredElement: OnRequestDeferredElementEvent = (event) => {
    const { onRequestDeferredElement } = this.props;
    const { deferredID } = event.nativeEvent;

    onRequestDeferredElement?.(deferredID, (items) => {
      this.provideDeferredElements(deferredID, items);
    });
  };

  render(){
    const props = this.getProps();
    const state = this.state;

    const shouldUseContextMenuButton = LIB_ENV.isContextMenuButtonSupported;

    const shouldUseContextMenuView = (
      !LIB_ENV.isContextMenuButtonSupported &&
      LIB_ENV.isContextMenuViewSupported
    );

    // TODO: Rename to 'sharedProps'
    const nativeComponentProps = {
      menuConfig: props.menuConfig,
      isContextMenuEnabled: props.isContextMenuEnabled,
      isMenuPrimaryAction: props.isMenuPrimaryAction,

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
      ): (
        // C - Use Regular View
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