import React from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';

import { TSEventEmitter } from '@dominicstop/ts-event-emitter';

import { RNIContextMenuView } from '../../native_components/RNIContextMenuView';
import { RNIWrapperView } from '../../native_components/RNIWrapperView';

import { RNIContextMenuViewModule } from '../../native_modules/RNIContextMenuViewModule';

import { ContextMenuViewContext } from '../../context/ContextMenuViewContext';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuAuxiliaryPreviewDidShowEvent, OnRequestDeferredElementEvent } from '../../types/MenuEvents';
import type { ContextMenuViewProps, ContextMenuViewState, NavigatorViewEventEmitter } from './ContextMenuViewTypes';

// @ts-ignore - TODO
import { ActionSheetFallback } from '../../functions/ActionSheetFallback';
import { LIB_ENV, IS_PLATFORM_IOS } from '../../constants/LibEnv';

import * as Helpers from '../../functions/Helpers';
import type { MenuElementConfig } from 'src/types/MenuConfig';


const NATIVE_ID_KEYS = {
  contextMenuPreview: 'contextMenuPreview',
  contextMenuAuxiliaryPreview: 'contextMenuAuxiliaryPreview',
};

export class ContextMenuView extends 
  React.PureComponent<ContextMenuViewProps, ContextMenuViewState> {

  static defaultProps = {
    useActionSheetFallback: !LIB_ENV.isContextMenuViewSupported,
  };

  nativeRef!: React.Component;

  emitter: NavigatorViewEventEmitter;

  constructor(props: ContextMenuViewProps){
    super(props);

    this.state = {
      menuVisible : false,
      mountPreview: false,
    };

    this.emitter = new TSEventEmitter();
  };

  componentWillUnmount(): void {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    RNIContextMenuViewModule.notifyComponentWillUnmount(
      Helpers.getNativeNodeHandle(this.nativeRef),
      {}
    );
  };

  private getProps = () => {
    const {  
      useActionSheetFallback,
      menuConfig,
      previewConfig,
      auxiliaryPreviewConfig,
      shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle,
      shouldWaitForMenuToHideBeforeFiringOnPressMenuItem,
      shouldEnableAggressiveCleanup,
      isAuxiliaryPreviewEnabled,
      // internal
      internalCleanupMode,
      // event props
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onRequestDeferredElement,
      onMenuAuxiliaryPreviewWillShow,
      onMenuAuxiliaryPreviewDidShow,
      onPressMenuItem,
      onPressMenuPreview,
      lazyPreview,
      renderPreview,
      renderAuxiliaryPreview: renderAuxillaryPreview,
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
      shouldWaitForMenuToHideBeforeFiringOnPressMenuItem: (
        shouldWaitForMenuToHideBeforeFiringOnPressMenuItem ?? true
      ),
      shouldEnableAggressiveCleanup: (
        shouldEnableAggressiveCleanup ?? true
      ),
      isAuxiliaryPreviewEnabled: (
        isAuxiliaryPreviewEnabled ?? false
      ),

      // B. Pass down props...
      menuConfig,
      previewConfig,
      auxiliaryPreviewConfig,
      internalCleanupMode,
      onMenuWillShow,
      onMenuWillHide,
      onMenuWillCancel,
      onMenuDidShow,
      onMenuDidHide,
      onMenuDidCancel,
      onRequestDeferredElement,
      onMenuAuxiliaryPreviewWillShow,
      onMenuAuxiliaryPreviewDidShow,
      onPressMenuItem,
      onPressMenuPreview,
      renderPreview,
      renderAuxillaryPreview,

      // C. Move all the default view-related
      //    props here...
      viewProps
    };
  };

  dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    await RNIContextMenuViewModule.dismissMenu(
      Helpers.getNativeNodeHandle(this.nativeRef)
    );
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    await RNIContextMenuViewModule.provideDeferredElements(
      Helpers.getNativeNodeHandle(this.nativeRef),
      deferredID, menuItems
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
    this.setState({mountPreview: true});
    event.stopPropagation();
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
    this.emitter.emit('onMenuDidHide', event);

    event.stopPropagation();
    event.persist();
  };

  private _handleOnMenuDidCancel: OnMenuDidCancelEvent = (event) => {
    this.props.onMenuDidCancel?.(event);

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

  private _handleOnMenuAuxiliaryPreviewWillShow: OnMenuAuxiliaryPreviewWillShowEvent = (event) => {
    this.props.onMenuAuxiliaryPreviewWillShow?.(event);
    event.stopPropagation();
  };

  private _handleOnMenuAuxiliaryPreviewDidShow: OnMenuAuxiliaryPreviewDidShowEvent = (event) => {
    this.props.onMenuAuxiliaryPreviewDidShow?.(event);
    event.stopPropagation();
  };

  private _handleOnPressMenuItem: OnPressMenuItemEvent = async (event) => {
    const props = this.getProps();
  
    // guard: event is a native event
    if(event.isUsingActionSheetFallback) return;

    event.stopPropagation();
    event.persist();

    const isKeepsMenuPresentedEnabled = 
      event.nativeEvent.menuAttributes?.includes('keepsMenuPresented');

    const shouldWaitForMenuToHide =
      !isKeepsMenuPresentedEnabled &&
      props.shouldWaitForMenuToHideBeforeFiringOnPressMenuItem;

    try {
      if(shouldWaitForMenuToHide){
        // wait for `onMenuDidHide`
        await Helpers.promiseWithTimeout(1000, new Promise<void>((resolve) => {
          this.emitter.once('onMenuDidHide', () => {
            resolve();
          });
        }));

        props.onPressMenuItem?.(event);

      } else {
        props.onPressMenuItem?.(event);
      };

    } catch(error){
      props.onPressMenuItem?.(event);
      console.log(
          '_handleOnPressMenuItem - Promise waiting for `onMenuDidHide`'
        + ' has timed out'
      );
    };
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

    const shouldMountAuxPreview = (
      (props.renderAuxillaryPreview != null) && 
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
          auxiliaryPreviewConfig={props.auxiliaryPreviewConfig}
          internalCleanupMode={props.internalCleanupMode}
          
          // Events: `onPress`-Related
          onMenuWillShow={this._handleOnMenuWillShow}
          onMenuWillHide={this._handleOnMenuWillHide}
          onMenuWillCancel={this._handleOnMenuWillCancel}
          onMenuDidShow={this._handleOnMenuDidShow}
          onMenuDidHide={this._handleOnMenuDidHide}
          onMenuDidCancel={this._handleOnMenuDidCancel}
          onRequestDeferredElement={this._handleOnRequestDeferredElement}
          onMenuWillCreate={this._handleOnMenuWillCreate}

          // Events: "Aux. Preview"-Related
          onMenuAuxiliaryPreviewWillShow={this._handleOnMenuAuxiliaryPreviewWillShow}
          onMenuAuxiliaryPreviewDidShow={this._handleOnMenuAuxiliaryPreviewDidShow}

          // Events: `onPress`-Related
          onPressMenuItem={this._handleOnPressMenuItem}
          onPressMenuPreview={this._handleOnPressMenuPreview}
        >
          {shouldMountPreview && (
            <RNIWrapperView 
              style={styles.previewContainer}
              nativeID={NATIVE_ID_KEYS.contextMenuPreview}
              isDummyView={true}
              shouldAutoDetachSubviews={true}
              shouldCreateTouchHandlerForSubviews={true}
              shouldNotifyComponentWillUnmount={props.shouldEnableAggressiveCleanup}
              shouldAutoCleanupOnJSUnmount={props.shouldEnableAggressiveCleanup}
            >
              {props.renderPreview?.()}
            </RNIWrapperView>
          )}
          {shouldMountAuxPreview && (
            <RNIWrapperView 
              style={styles.previewAuxWrapper}
              nativeID={NATIVE_ID_KEYS.contextMenuAuxiliaryPreview}
              isDummyView={true}
              shouldAutoDetachSubviews={true}
              shouldCreateTouchHandlerForSubviews={true}
              shouldNotifyComponentWillUnmount={props.shouldEnableAggressiveCleanup}
              shouldAutoCleanupOnJSUnmount={props.shouldEnableAggressiveCleanup}
            >
              {props.renderAuxillaryPreview?.()}
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
  previewAuxWrapper: {
    position: 'absolute',
    overflow: 'visible',
    flex: 0,
  },
});