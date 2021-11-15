import { NativeModules } from 'react-native';


interface RNIWrapperViewModule {
  notifyComponentWillUnmount(
    node: number, 
    params: {
      isManuallyTriggered: boolean;
    }
  ): void;
};

const MODULE_NAME = "RNIWrapperViewModule";

export const RNIWrapperViewModule: RNIWrapperViewModule =
  NativeModules[MODULE_NAME];