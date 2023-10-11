import { ViewProps } from 'react-native';
import type { OnReactTagDidSetEvent, RNICleanupMode } from 'react-native-ios-utilities';

import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuAuxiliaryPreviewDidShowEvent, OnRequestDeferredElementEvent } from '../../types/MenuEvents';

import type { MenuConfig } from '../../types/MenuConfig';
import type { MenuPreviewConfig } from '../../types/MenuPreviewConfig';
import type { MenuAuxiliaryPreviewConfig } from '../../types/MenuAuxiliaryPreviewConfig';


export type RNIContextMenuViewBaseProps = {

  // Internal
  // --------

  internalCleanupMode: RNICleanupMode;
  shouldCleanupOnComponentWillUnmount: boolean;

  // Value Props
  // -----------

  menuConfig: MenuConfig; 
  previewConfig: MenuPreviewConfig;
  auxiliaryPreviewConfig: MenuAuxiliaryPreviewConfig;

  /** 
   * On iOS 15+, the `MenuActionConfig.discoverabilityTitle` is no longer 
   * displayed as a subtitle under the menu action.
   * 
   * Instead you need to set a different a different property 
   * called `subtitle`.
   * 
   * The `discoverabilityTitle` property is now used for the "discoverability
   * heads-up display" (e.g when an app supports keyboard shortcuts, holding down 
   * the command key presents a list of shortcuts; the `discoverabilityTitle`
   * is then used as the title for the shortcut).
   * 
   * This property, for backwards-compatibility, uses `discoverabilityTitle`
   * value as the subtitle for the menu action, preserving the old behavior.
   * 
   * This prop is set to `true` by default; set this to `false` if you don't 
   * want this automatic behaviour to happen.
   * 
   * */
  shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle: boolean;

  isContextMenuEnabled: boolean;
  isAuxiliaryPreviewEnabled: boolean;

  // Events - Lifecycle
  // ------------------

  onReactTagDidSet: OnReactTagDidSetEvent;

  onMenuWillShow: OnMenuWillShowEvent;
  onMenuDidShow: OnMenuDidShowEvent;

  onMenuWillHide: OnMenuWillHideEvent;
  onMenuDidHide: OnMenuDidHideEvent;

  onMenuWillCancel: OnMenuWillCancelEvent;
  onMenuDidCancel: OnMenuDidCancelEvent;

  onMenuWillCreate: OnMenuWillCreateEvent;
  onRequestDeferredElement: OnRequestDeferredElementEvent;

  onPressMenuItem: OnPressMenuItemEvent;
  onPressMenuPreview: OnPressMenuPreviewEvent;

  onMenuAuxiliaryPreviewWillShow: OnMenuAuxiliaryPreviewWillShowEvent;
  onMenuAuxiliaryPreviewDidShow: OnMenuAuxiliaryPreviewDidShowEvent;
};

export type RNIContextMenuViewProps = 
  RNIContextMenuViewBaseProps & ViewProps;