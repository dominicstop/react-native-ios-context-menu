import type React from 'react';
import type { ViewProps } from 'react-native';

import type { RNIContextMenuViewProps } from '../../native_components/RNIContextMenuView';


export type RenderPreviewItem = () => React.ReactElement;

export type ContextMenuViewBaseProps = Pick<RNIContextMenuViewProps,
  | 'menuConfig'
  | 'previewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  // `OnPress` Events
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
> & {
  lazyPreview?: boolean;
  useActionSheetFallback?: boolean;

  renderPreview?: RenderPreviewItem;
};

export type ContextMenuViewProps = 
  ContextMenuViewBaseProps & ViewProps;

export type ContextMenuViewState = {
  menuVisible: boolean;
  mountPreview: boolean;
};