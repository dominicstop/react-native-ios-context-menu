import { requireNativeComponent, Platform, ViewProps, HostComponent, View } from 'react-native';

import type { MenuConfig } from '../types/MenuConfig';
import type { MenuPreviewConfig } from '../types/MenuPreviewConfig';
import type { MenuAuxiliaryPreviewConfig } from '../types/MenuAuxiliaryPreviewConfig';
import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuAuxiliaryPreviewDidShowEvent, OnRequestDeferredElementEvent  } from '../types/MenuEvents';
import type { RNICleanupMode } from 'src/types/RNICleanupMode';


// TODO: Add type annotation - Remove `any` type usage
export type RNIContextMenuViewProps = ViewProps & {

  // Internal
  // --------

  internalCleanupMode?: RNICleanupMode;

  // Value Props
  // -----------

  menuConfig?: MenuConfig; 
  previewConfig?: MenuPreviewConfig;
  auxiliaryPreviewConfig?: MenuAuxiliaryPreviewConfig;

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
  shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle?: boolean;

  isContextMenuEnabled?: boolean;
  isAuxiliaryPreviewEnabled?: boolean;

  // Events - Lifecycle
  // ------------------

  onMenuWillShow?: OnMenuWillShowEvent;
  onMenuDidShow?: OnMenuDidShowEvent;

  onMenuWillHide?: OnMenuWillHideEvent;
  onMenuDidHide?: OnMenuDidHideEvent;

  onMenuWillCancel?: OnMenuWillCancelEvent;
  onMenuDidCancel ?: OnMenuDidCancelEvent;

  onMenuWillCreate?: OnMenuWillCreateEvent;
  onRequestDeferredElement?: OnRequestDeferredElementEvent;

  // Events - Aux. Preview
  // ---------------------

  onMenuAuxiliaryPreviewWillShow?: OnMenuAuxiliaryPreviewWillShowEvent;
  onMenuAuxiliaryPreviewDidShow ?: OnMenuAuxiliaryPreviewDidShowEvent;

  // Events - OnPress
  // ----------------

  onPressMenuItem?: OnPressMenuItemEvent;
  onPressMenuPreview?: OnPressMenuPreviewEvent;
};

const viewName = "RNIContextMenuView";

/**
 * Do not use `RNIContextMenuView` if platform is not iOS.
 */
export const RNIContextMenuView: HostComponent<RNIContextMenuViewProps> = Platform.select({
  ios: () => requireNativeComponent(viewName) as any,
  default: () => View,
})();