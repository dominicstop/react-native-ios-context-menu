import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type { BubblingEventHandler } from 'react-native/Libraries/Types/CodegenTypes';
import type { HostComponent, ViewProps } from 'react-native';

// stubs
export interface NativeProps extends ViewProps {
  isMenuPrimaryAction?: boolean;

  // shared props
  onDidSetViewID?: BubblingEventHandler<{}>;

  // inherited props
  menuConfig?: string;
  isContextMenuEnabled?: boolean;

  onMenuWillShow?: BubblingEventHandler<{}>;
  onMenuDidShow?: BubblingEventHandler<{}>;
  onMenuWillHide?: BubblingEventHandler<{}>;
  onMenuDidHide?: BubblingEventHandler<{}>;
  onMenuWillCancel?: BubblingEventHandler<{}>;
  onMenuDidCancel?: BubblingEventHandler<{}>;
  onRequestDeferredElement?: BubblingEventHandler<{}>;
  onPressMenuItem?: BubblingEventHandler<{}>;
};

// stubs
export default codegenNativeComponent<NativeProps>('RNIContextMenuButton', {
  excludedPlatforms: ['android'],
  interfaceOnly: true,
}) as HostComponent<NativeProps>;