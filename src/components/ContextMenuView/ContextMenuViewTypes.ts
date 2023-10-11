import type React from 'react';

import type { TSEventEmitter } from '@dominicstop/ts-event-emitter';

import type { ViewProps } from 'react-native';
import type { OnMenuDidHideEventObject } from 'src/types/MenuEvents';
import type { KeyMapType } from 'src/types/UtilityTypes';
import type { DeferredElementProvider } from 'src/types/MenuSharedTypes';

import type { RNIContextMenuViewProps } from '../../native_components/RNIContextMenuView';


export type RenderItem = () => React.ReactElement;

export type ContextMenuViewBaseProps = Pick<RNIContextMenuViewProps,  
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
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
    // Internal
  | 'internalCleanupMode'
> & {
  lazyPreview?: boolean;
  useActionSheetFallback?: boolean;
  shouldWaitForMenuToHideBeforeFiringOnPressMenuItem?: boolean;
  shouldEnableAggressiveCleanup?: boolean;

  onRequestDeferredElement?: DeferredElementProvider;

  renderPreview?: RenderItem;
  renderAuxiliaryPreview?: RenderItem;
};

export type ContextMenuViewProps = 
  ContextMenuViewBaseProps & ViewProps;

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

export type NavigatorViewEventEmitter = 
  TSEventEmitter<ContextMenuEmitterEvents, ContextMenuEmitterEventMap>;