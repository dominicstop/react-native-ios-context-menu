import { NativeModules } from 'react-native';


interface RNIUtilitiesModule {
  initialize(params: object): void;
};

const MODULE_NAME = "RNIUtilitiesModule";

export const RNIUtilitiesModule: RNIUtilitiesModule =
  NativeModules[MODULE_NAME];

// Calling this will initialize `RNIUtilities.sharedBridge`.
// Note: This module must be imported for this function to be invoked.
RNIUtilitiesModule.initialize({});
