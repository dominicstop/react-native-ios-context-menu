import type React from 'react';
import type { ViewProps } from 'react-native';

import type { TSEventEmitter } from '@dominicstop/ts-event-emitter';
import type { KeyMapType } from 'react-native-ios-utilities';

import type { RNIContextMenuViewProps } from '../../native_components/RNIContextMenuView';

import type { OnMenuDidHideEventObject } from '../../types/SharedMenuEvents';
import type { DeferredElementProvider } from '../../types/SharedMenuTypes';


export type RenderItem = () => React.ReactElement;

export type ContextMenuViewInheritedOptionalProps = Partial<Pick<RNIContextMenuViewProps,
  // Value Props
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'
  | 'debugShouldEnableLogging'

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
>>;

// export type ContextMenuViewInheritedRequiredProps = Required<Pick<RNIContextMenuViewProps,
// >>;

export type ContextMenuViewInheritedProps =
    ContextMenuViewInheritedOptionalProps
// & ContextMenuViewInheritedRequiredProps;

export type ContextMenuViewBaseProps = {
  lazyPreview?: boolean;
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