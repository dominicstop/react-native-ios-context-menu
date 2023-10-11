import type { MenuElementConfig } from 'src/types/MenuConfig';

import { NativeModules } from 'react-native';


interface RNIContextMenuButtonModule {
  dismissMenu(
    node: number,
  ): Promise<void>;

  provideDeferredElements(
    node: number,
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ): Promise<void>;

  notifyComponentWillUnmount(
    node: number,
    params: {}
  ): void;
};

const MODULE_NAME = "RNIContextMenuButtonModule";

export const RNIContextMenuButtonModule: RNIContextMenuButtonModule =
  NativeModules[MODULE_NAME];