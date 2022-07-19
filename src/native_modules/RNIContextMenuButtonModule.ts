import { NativeModules } from 'react-native';


interface RNIContextMenuButtonModule {
  dismissMenu(
    node: number,
  ): Promise<void>;
};

const MODULE_NAME = "RNIContextMenuButtonModule";

export const RNIContextMenuButtonModule: RNIContextMenuButtonModule =
  NativeModules[MODULE_NAME];