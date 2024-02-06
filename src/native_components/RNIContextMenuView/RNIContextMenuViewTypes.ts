import { ViewProps } from 'react-native';
import { RNIContextMenuNativeViewBaseProps } from './RNIContextMenuNativeViewTypes';


export type RNIContextMenuViewInheritedProps = Pick<RNIContextMenuNativeViewBaseProps,
  | 'internalCleanupMode'
  | 'menuConfig'
  | 'previewConfig'
  | 'auxiliaryPreviewConfig'
  | 'shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle'
  | 'isContextMenuEnabled'
  | 'isAuxiliaryPreviewEnabled'
  | 'shouldPreventLongPressGestureFromPropagating'
  | 'onMenuWillCreate'
  | 'onMenuWillShow'
  | 'onMenuDidShow'
  | 'onMenuWillHide'
  | 'onMenuDidHide'
  | 'onMenuWillCancel'
  | 'onMenuDidCancel'
  | 'onRequestDeferredElement'
  | 'onPressMenuItem'
  | 'onPressMenuPreview'
  | 'onMenuAuxiliaryPreviewWillShow'
  | 'onMenuAuxiliaryPreviewDidShow'
>;

export type RNIContextMenuViewBaseProps = {
  debugShouldEnableLogging: boolean;
};

export type RNIContextMenuViewProps = 
    RNIContextMenuViewInheritedProps 
  & RNIContextMenuViewBaseProps
  & ViewProps;