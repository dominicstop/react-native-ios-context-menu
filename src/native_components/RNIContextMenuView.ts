import { requireNativeComponent, UIManager, ViewProps } from 'react-native';

import type { MenuConfig } from '../types/MenuConfig';
import type { MenuPreviewConfig } from '../types/MenuPreviewConfig';


// TODO: Add type annotation - Remove `any` type usage
export type RNIContextMenuViewProps = ViewProps & {

  // Value Props
  // -----------

  menuConfig: MenuConfig; 
  previewConfig?: MenuPreviewConfig;

  // Events - Lifecycle
  // ------------------

  onMenuWillShow?: any;
  onMenuWillHide?: any;

  onMenuDidShow?: any;
  onMenuDidHide?: any;

  onMenuWillCancel?: any;
  onMenuDidCancel ?: any;

  onMenuWillCreate?: any;

  // Events - OnPress
  // ----------------

  onPressMenuItem?: any;
  onPressMenuPreview?: any;
};

export type RNIContextMenuViewCommandIDMap = {
  dismissMenu: number;
};

const viewName = "RNIContextMenuView";

export const RNIContextMenuView = 
  requireNativeComponent<RNIContextMenuViewProps>(viewName);

export const RNIContextMenuViewCommands = 
  ((UIManager as any)[viewName]).Commands as RNIContextMenuViewCommandIDMap;
  

