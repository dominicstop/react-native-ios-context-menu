import { requireNativeComponent, ViewProps } from 'react-native';

import type { MenuConfig } from '../types/MenuConfig';
import type { MenuPreviewConfig } from '../types/MenuPreviewConfig';
import type { OnMenuWillShowEvent, OnMenuWillHideEvent, OnMenuDidShowEvent, OnMenuDidHideEvent, OnMenuWillCancelEvent, OnMenuDidCancelEvent, OnMenuWillCreateEvent, OnPressMenuItemEvent, OnPressMenuPreviewEvent,  } from '../types/MenuEvents';


// TODO: Add type annotation - Remove `any` type usage
export type RNIContextMenuViewProps = ViewProps & {

  // Value Props
  // -----------

  menuConfig: MenuConfig; 
  previewConfig?: MenuPreviewConfig;

  // Events - Lifecycle
  // ------------------

  onMenuWillShow?: OnMenuWillShowEvent;
  onMenuWillHide?: OnMenuWillHideEvent;

  onMenuDidShow?: OnMenuDidShowEvent;
  onMenuDidHide?: OnMenuDidHideEvent;

  onMenuWillCancel?: OnMenuWillCancelEvent;
  onMenuDidCancel ?: OnMenuDidCancelEvent;

  onMenuWillCreate?: OnMenuWillCreateEvent;

  // Events - OnPress
  // ----------------

  onPressMenuItem?: OnPressMenuItemEvent;
  onPressMenuPreview?: OnPressMenuPreviewEvent;
};

const viewName = "RNIContextMenuView";

export const RNIContextMenuView = 
  requireNativeComponent<RNIContextMenuViewProps>(viewName);