import React from 'react';
import { StyleSheet, View } from 'react-native';

import { TSEventEmitter } from '@dominicstop/ts-event-emitter';
import { RNIDetachedView, RNIDetachedViewContent } from 'react-native-ios-utilities';

import { RNIContextMenuView, type RNIContextMenuViewRef } from '../../native_components/RNIContextMenuView';
import { ContextMenuViewContext } from '../../context/ContextMenuViewContext';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuAuxiliaryPreviewDidShowEvent, OnRequestDeferredElementEvent } from '../../types/SharedMenuEvents';
import type { ContextMenuViewProps, ContextMenuViewState, ContextMenuEventEmitter } from './ContextMenuViewTypes';
import type { MenuElementConfig } from '../../types/MenuConfig';

import { LIB_ENV } from '../../constants/LibEnv';
import * as Helpers from '../../functions/Helpers';


export const NATIVE_ID_KEYS = {
  detachedView: 'detachedView',
  contextMenuPreview: 'contextMenuPreview',
  contextMenuAuxiliaryPreview: 'contextMenuAuxiliaryPreview',
};

export class ContextMenuView extends 
  React.PureComponent<ContextMenuViewProps, ContextMenuViewState> {

  static defaultProps = {
    useActionSheetFallback: !LIB_ENV.isContextMenuViewSupported,
  };

  nativeRef!: RNIContextMenuViewRef;
  emitter: ContextMenuEventEmitter;

  constructor(props: ContextMenuViewProps){
    super(props);

    this.state = {
      menuVisible: false,
      mountPreview: false,
    };

    this.emitter = new TSEventEmitter();
  };

  private getProps = () => {
    const {  
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
      isContextMenuEnabled: (
        isContextMenuEnabled ?? true
      ),
      shouldPreventLongPressGestureFromPropagating: (
        shouldPreventLongPressGestureFromPropagating ?? true
      ),
      debugShouldEnableLogging: (
        debugShouldEnableLogging ?? LIB_ENV.shouldEnableLogging
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

  public dismissMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.dismissMenu();
  };

  public provideDeferredElements = async (
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ) => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.provideDeferredElements(
      deferredID, 
      menuItems
    );
  };

  public presentMenu = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;
    await this.nativeRef.presentMenu();
  };

  public showAuxiliaryPreviewAsPopover = async () => {
    if(!LIB_ENV.isContextMenuViewSupported) return;

    await Helpers.setStateAsync(this, () => ({
      mountPreview: true
    }))
    
    await this.nativeRef.showAuxiliaryPreviewAsPopover();
  };

  private _handleGetRefToContextMenuView = () => {
    return this;
  };

  private _handleOnMenuWillCreate: OnMenuWillCreateEvent = (event) => {
    this.setState({mountPreview: true});
    event.stopPropagation();
  };

  private _handleOnMenuWillShow: OnMenuWillShowEvent = (event) => {
    this.props.onMenuWillShow?.(event);
    event.stopPropagation();

    this.setState({
      menuVisible: true,
      mountPreview: true,
    });
  };

  private _handleOnMenuWillHide: OnMenuWillHideEvent = (event) => {
    this.props.onMenuWillHide?.(event);
    event.stopPropagation();

    this.setState({menuVisible : false});
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

    this.setState({mountPreview : false});
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

  render(){
    const props = this.getProps();
    const state = this.state;

    const shouldUseContextMenuView = LIB_ENV.isContextMenuViewSupported;

    const isUsingCustomPreview =
      props.renderProps.renderPreview != null;

    const shouldMountPreviewContent = (
          state.mountPreview 
      || !props.lazyPreview
    );

    const isUsingAuxillaryPreview = 
      props.renderProps.renderAuxillaryPreview != null;

    const shouldMountAuxPreviewContent = (
         state.mountPreview
      || !props.lazyPreview
    );

    const shouldMountDetachedView = (
         isUsingCustomPreview
      || isUsingAuxillaryPreview
    );

    props.debugShouldEnableLogging && console.log(
      "ContextMenuView.render",
      `\n - isUsingCustomPreview: ${isUsingCustomPreview}`,
      `\n - shouldMountPreviewContent: ${shouldMountPreviewContent}`,
      `\n - isUsingAuxillaryPreview: ${isUsingAuxillaryPreview}`,
      `\n - shouldMountAuxPreviewContent: ${shouldMountAuxPreviewContent}`,
      `\n - shouldMountDetachedView: ${shouldMountDetachedView}`,
      `\n`
    );

    const contents = (
      shouldUseContextMenuView? (
        // A - Use Context Menu View
        <RNIContextMenuView
          {...props.viewProps}
          ref={ref => { 
            this.nativeRef = ref!;
          }}
          style={[styles.menuView, props.viewProps.style]}
          menuConfig={props.menuConfig}
          previewConfig={props.previewConfig}
          auxiliaryPreviewConfig={props.auxiliaryPreviewConfig}
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
          {shouldMountDetachedView && (
            <RNIDetachedView 
              nativeID={NATIVE_ID_KEYS.detachedView}
              shouldImmediatelyDetach={true}
            >
              <React.Fragment>
                {isUsingCustomPreview && (
                  <RNIDetachedViewContent
                    nativeID={NATIVE_ID_KEYS.contextMenuPreview}
                  >
                    {shouldMountPreviewContent && 
                      props.renderProps.renderPreview?.()
                    }
                  </RNIDetachedViewContent>
                )}
              </React.Fragment>
              <React.Fragment>
                {isUsingAuxillaryPreview && (
                  <RNIDetachedViewContent
                    nativeID={NATIVE_ID_KEYS.contextMenuAuxiliaryPreview}
                  >
                    {shouldMountAuxPreviewContent && 
                      props.renderProps.renderAuxillaryPreview?.()
                    }
                  </RNIDetachedViewContent>
                )}
              </React.Fragment>
            </RNIDetachedView>
          )}
          <View>
            {props.viewProps.children}
          </View>
        </RNIContextMenuView>
      ):(
        // B - Use Regular View
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