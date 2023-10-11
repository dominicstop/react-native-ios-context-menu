import { NativeModules } from 'react-native';

import type { MenuElementConfig } from 'src/types/MenuConfig';
import type { RNIJSComponentWillUnmountNotifiable } from 'src/types/RNIJSComponentWillUnmountNotifiable';


interface RNIContextMenuViewModule extends RNIJSComponentWillUnmountNotifiable {
  dismissMenu(
    node: number,
  ): Promise<void>;

  provideDeferredElements(
    node: number,
    deferredID: string, 
    menuItems: MenuElementConfig[]
  ): Promise<void>;
};

const MODULE_NAME = "RNIContextMenuViewModule";

export const RNIContextMenuViewModule: RNIContextMenuViewModule =
  NativeModules[MODULE_NAME];