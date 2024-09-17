import type { HostComponent, ViewProps } from 'react-native';
import type { SharedViewEvents, RemapObject, NativeComponentBaseProps } from 'react-native-ios-utilities';

import { 
  default as RNIContextMenuViewNativeComponent,
  type NativeProps as RNIContextMenuViewNativeComponentProps
} from './RNIContextMenuViewNativeComponent';

import type { OnMenuAuxiliaryPreviewDidShowEvent, OnMenuAuxiliaryPreviewWillShowEvent, OnMenuDidCancelEvent, OnMenuDidHideEvent, OnMenuDidShowEvent, OnMenuWillCancelEvent, OnMenuWillCreateEvent, OnMenuWillHideEvent, OnMenuWillShowEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent, OnRequestDeferredElementEvent } from '../../types/SharedMenuEvents';
import type { MenuConfig } from '../../types/MenuConfig';
import type { MenuPreviewConfig } from '../../types/MenuPreviewConfig';
import type { AuxiliaryPreviewConfigBackwardsCompatible } from '../../types/AuxiliaryPreviewConfigBackwardsCompatible';

type RNIContextMenuViewNativeComponentBaseProps = 
  NativeComponentBaseProps<RNIContextMenuViewNativeComponentProps>;

export type RNIContextMenuNativeViewBaseProps = RemapObject<RNIContextMenuViewNativeComponentBaseProps, {
  
  // Value Props
  // -----------

  menuConfig: MenuConfig; 
  previewConfig: MenuPreviewConfig;
  auxiliaryPreviewConfig: AuxiliaryPreviewConfigBackwardsCompatible;

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
  shouldPreventLongPressGestureFromPropagating: boolean;

  // Events - Lifecycle
  // ------------------

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
}>;

export type RNIContextMenuNativeViewProps = 
    SharedViewEvents
  & ViewProps
  & RNIContextMenuNativeViewBaseProps;

export const RNIContextMenuNativeView = 
  RNIContextMenuViewNativeComponent as unknown as HostComponent<RNIContextMenuNativeViewProps>;
