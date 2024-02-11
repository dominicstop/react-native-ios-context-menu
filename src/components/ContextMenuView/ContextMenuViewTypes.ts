import type React from 'react';
import type { ViewProps } from 'react-native';

import type { TSEventEmitter } from '@dominicstop/ts-event-emitter';
import type { KeyMapType } from 'react-native-ios-utilities';

import type { RNIContextMenuViewBaseProps, RNIContextMenuViewInheritedProps } from '../../native_components/RNIContextMenuView';

import type { OnMenuDidHideEventObject } from '../../types/MenuEvents';
import type { DeferredElementProvider } from '../../types/MenuSharedTypes';


export type RenderItem = () => React.ReactElement;

export type ContextMenuViewInheritedProps = Partial<Pick<RNIContextMenuViewInheritedProps, 
  // Value Props
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'
  | 'internalViewCleanupMode'

  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  | 'onMenuAuxiliaryPreviewWillShow'
  | 'onMenuAuxiliaryPreviewDidShow'

  // `OnPress` Events
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
  
>> & Partial<Pick<RNIContextMenuViewBaseProps,
  | 'debugShouldEnableLogging'
>>;

export type ContextMenuViewBaseProps = {
  lazyPreview?: boolean;
  useActionSheetFallback?: boolean;
  shouldWaitForMenuToHideBeforeFiringOnPressMenuItem?: boolean;

  shouldEnableAggressiveCleanup?: boolean;
  shouldCleanupOnComponentWillUnmountForMenuPreview?: boolean;
  shouldCleanupOnComponentWillUnmountForAuxPreview?: boolean;

  onRequestDeferredElement?: DeferredElementProvider;
  renderPreview?: RenderItem;
  renderAuxiliaryPreview?: RenderItem;
};

export type ContextMenuViewProps = 
    ContextMenuViewInheritedProps 
  & ContextMenuViewBaseProps
  & ViewProps;

export type ContextMenuViewState = {
  menuVisible: boolean;
  mountPreview: boolean;
};

export enum ContextMenuEmitterEvents {
  onMenuDidHide = "onMenuDidHide",
};

export type ContextMenuEmitterEventMap = KeyMapType<ContextMenuEmitterEvents, {
  onMenuDidHide: OnMenuDidHideEventObject['nativeEvent'],
}>

export type ContextMenuEventEmitter = 
  TSEventEmitter<ContextMenuEmitterEvents, ContextMenuEmitterEventMap>;