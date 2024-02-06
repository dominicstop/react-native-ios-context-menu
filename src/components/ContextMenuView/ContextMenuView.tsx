import React from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';

import { TSEventEmitter } from '@dominicstop/ts-event-emitter';

import { RNIContextMenuView } from '../../native_components/RNIContextMenuView';
import { ContextMenuViewContext } from '../../context/ContextMenuViewContext';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuAuxiliaryPreviewDidShowEvent, OnRequestDeferredElementEvent } from '../../types/MenuEvents';
import type { ContextMenuViewProps, ContextMenuViewState, ContextMenuEventEmitter } from './ContextMenuViewTypes';

// @ts-ignore - TODO
import { ActionSheetFallback } from '../../functions/ActionSheetFallback';
import { LIB_ENV, IS_PLATFORM_IOS } from '../../constants/LibEnv';

import * as Helpers from '../../functions/Helpers';
import type { MenuElementConfig } from '../../types/MenuConfig';
import { RNIDetachedView } from 'react-native-ios-utilities';


const NATIVE_ID_KEYS = {
  contextMenuPreview: 'contextMenuPreview',
  contextMenuAuxiliaryPreview: 'contextMenuAuxiliaryPreview',
};

export class ContextMenuView extends 
  React.PureComponent<ContextMenuViewProps, ContextMenuViewState> {

  static defaultProps = {
    useActionSheetFallback: !LIB_ENV.isContextMenuViewSupported,
  };

  nativeRef!: RNIContextMenuView;
  emitter: ContextMenuEventEmitter;

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
    this.nativeRef.notifyOnComponentWillUnmount();
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
      shouldCleanupOnComponentWillUnmountForMenuPreview,
      shouldCleanupOnComponentWillUnmountForAuxPreview,
      isAuxiliaryPreviewEnabled,
      isContextMenuEnabled,
      shouldPreventLongPressGestureFromPropagating,

      // internal
      internalCleanupMode,
      debugShouldEnableLogging,

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

      // render props
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
        isAuxiliaryPreviewEnabled ?? true
      ),
      internalCleanupMode: (
        internalCleanupMode ?? 'automatic'
      ),
      isContextMenuEnabled: (
        isContextMenuEnabled ?? true
      ),
      shouldPreventLongPressGestureFromPropagating: (
        shouldPreventLongPressGestureFromPropagating ?? true
      ),
      debugShouldEnableLogging: (
        debugShouldEnableLogging ?? true
      ),

      // B. Pass down props...
      shouldCleanupOnComponentWillUnmountForMenuPreview,
      shouldCleanupOnComponentWillUnmountForAuxPreview,
      menuConfig,
      previewConfig,
      auxiliaryPreviewConfig,

      // C. Pass down, and group event props...
      eventProps: {
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
      },

      // D. Pass down, and group render props
      renderProps: {
        renderPreview,
        renderAuxillaryPreview,
      },

      // E. Move all the default view-related
      //    props here...
      viewProps
    };
  };

  dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.dismissMenu();
  };

  provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.provideDeferredElements(
      deferredID, 
      menuItems
    );
  };

  presentMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.presentMenu();
  };

  showAuxiliaryPreviewAsPopover = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    await Helpers.setStateAsync(this, () => ({
      mountPreview: true
    }))
    
    await this.nativeRef.showAuxiliaryPreviewAsPopover();
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
    const eventProps = props.eventProps;
    
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

        eventProps.onPressMenuItem?.(event);

      } else {
        eventProps.onPressMenuItem?.(event);
      };

    } catch(error){
      eventProps.onPressMenuItem?.(event);
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

    const shouldMountPreviewContainer = 
      props.renderProps.renderPreview != null;

    const shouldMountPreviewContent = 
          state.mountPreview 
      || !props.lazyPreview;

    const shouldMountAuxPreviewContainer = 
      props.renderProps.renderAuxillaryPreview != null;

    const shouldMountAuxPreviewContent = 
         state.mountPreview
      || !props.lazyPreview;

    props.debugShouldEnableLogging && console.log(
      "ContextMenuView.render",
      `\n - nativeRef.reactTag: ${this.nativeRef?.reactTag ?? -1}`,
      `\n - shouldMountPreviewContainer: ${shouldMountPreviewContainer}`,
      `\n - shouldMountPreviewContent: ${shouldMountPreviewContent}`,
      `\n - shouldMountAuxPreviewContainer: ${shouldMountAuxPreviewContainer}`,
      `\n - shouldMountAuxPreviewContent: ${shouldMountAuxPreviewContent}`,
      `\n`
    );

    const contents = (
      shouldUseContextMenuView? (
        // A - Use Context Menu View
        <RNIContextMenuView
          {...props.viewProps}
          ref={r => { this.nativeRef = r! }}
          style={[styles.menuView, props.viewProps.style]}
          menuConfig={props.menuConfig}
          previewConfig={props.previewConfig}
          auxiliaryPreviewConfig={props.auxiliaryPreviewConfig}
          internalCleanupMode={props.internalCleanupMode}
          isContextMenuEnabled={props.isContextMenuEnabled}
          shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle={props.shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle}
          isAuxiliaryPreviewEnabled={props.isAuxiliaryPreviewEnabled}
          shouldPreventLongPressGestureFromPropagating={props.shouldPreventLongPressGestureFromPropagating}
          debugShouldEnableLogging={props.debugShouldEnableLogging}

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
          {shouldMountPreviewContainer && (
            <RNIDetachedView 
              nativeID={NATIVE_ID_KEYS.contextMenuPreview}
              shouldCleanupOnComponentWillUnmount={
                props.shouldCleanupOnComponentWillUnmountForMenuPreview
              }
            >
              {shouldMountPreviewContent && (
                props.renderProps.renderPreview?.()
              )}
            </RNIDetachedView>
          )}
          {shouldMountAuxPreviewContainer && (
            <RNIDetachedView 
              nativeID={NATIVE_ID_KEYS.contextMenuAuxiliaryPreview}
              shouldCleanupOnComponentWillUnmount={
                props.shouldCleanupOnComponentWillUnmountForAuxPreview
              }
            >
              {shouldMountAuxPreviewContent && (
                props.renderProps.renderAuxillaryPreview?.()
              )}
            </RNIDetachedView>
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
});