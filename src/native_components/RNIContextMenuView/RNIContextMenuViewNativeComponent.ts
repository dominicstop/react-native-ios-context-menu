import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type { BubblingEventHandler } from 'react-native/Libraries/Types/CodegenTypes';
import type { HostComponent, ViewProps } from 'react-native';

// stubs
export interface NativeProps extends ViewProps {
  onDidSetViewID: BubblingEventHandler<{}>;

  menuConfig?: string; 
  previewConfig?: string;
  auxiliaryPreviewConfig?: string;
  
  shouldUseDiscoverabilityTitleAsFallbackValueForSubtitle?: string;
  isContextMenuEnabled?: string;
  isAuxiliaryPreviewEnabled?: string;
  shouldPreventLongPressGestureFromPropagating?: string;

  onMenuWillShow?: BubblingEventHandler<{}>;
  onMenuDidShow?: BubblingEventHandler<{}>;
  onMenuWillHide?: BubblingEventHandler<{}>;
  onMenuDidHide?: BubblingEventHandler<{}>;
  onMenuWillCancel?: BubblingEventHandler<{}>;
  onMenuDidCancel?: BubblingEventHandler<{}>;
  onMenuWillCreate?: BubblingEventHandler<{}>;
  onRequestDeferredElement?: BubblingEventHandler<{}>;
  onPressMenuItem?: BubblingEventHandler<{}>;
  onPressMenuPreview?: BubblingEventHandler<{}>;
  onMenuAuxiliaryPreviewWillShow?: BubblingEventHandler<{}>;
  onMenuAuxiliaryPreviewDidShow?: BubblingEventHandler<{}>;
};

// stubs
export default codegenNativeComponent<NativeProps>('RNIContextMenuView', {
  excludedPlatforms: ['android'],
  interfaceOnly: true,
}) as HostComponent<NativeProps>;