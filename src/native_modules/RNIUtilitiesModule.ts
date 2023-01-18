import { NativeModules } from 'react-native';
import { IS_PLATFORM_IOS } from '../constants/LibEnv';


interface RNIUtilitiesModule {
  initialize(params: object): void;
};

const MODULE_NAME = "RNIUtilitiesModule";

export const RNIUtilitiesModule: RNIUtilitiesModule =
  NativeModules[MODULE_NAME];

if(IS_PLATFORM_IOS){
  // Calling this will initialize `RNIUtilities.sharedBridge`.
  // Note: This module must be imported for this function to be invoked.
  RNIUtilitiesModule.initialize({});
};
