import { ViewProps } from 'react-native';
import { RNIContextMenuNativeViewBaseProps } from './RNIContextMenuNativeViewTypes';


export type RNIContextMenuViewBaseProps = Pick<RNIContextMenuNativeViewBaseProps,
  | 'internalCleanupMode'
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onMenuWillCreate'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
  | 'onMenuAuxiliaryPreviewWillShow'
  | 'onMenuAuxiliaryPreviewDidShow'
>;

export type RNIContextMenuViewProps = 
  RNIContextMenuViewBaseProps & ViewProps;