import { requireNativeModule } from 'expo-modules-core';
import type { NotifyOnComponentWillUnmount } from 'react-native-ios-utilities';

import type { MenuElementConfig } from '../../types/MenuConfig';


interface RNIContextMenuButtonModule  {
  notifyOnComponentWillUnmount: NotifyOnComponentWillUnmount;

  presentMenu(
    node: number,
  ): Promise<void>;

  dismissMenu(
    node: number,
  ): Promise<void>;

  provideDeferredElements(
    node: number,
    args: {
      deferredID: string, 
      menuItems: MenuElementConfig[]
    }
  ): Promise<void>;
};

export const RNIContextMenuButtonModule: RNIContextMenuButtonModule = 
  requireNativeModule('RNIContextMenuButton');


  
