import { NativeModules } from 'react-native';


interface RNIContextMenuViewModule {
  dismissMenu(
    node: number, 
  ): Promise<void>;
};

const MODULE_NAME = "RNIContextMenuViewModule";

export const RNIContextMenuViewModule: RNIContextMenuViewModule =
  NativeModules[MODULE_NAME];