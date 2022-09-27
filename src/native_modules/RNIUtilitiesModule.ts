import { NativeModules } from 'react-native';


interface RNIUtilitiesModule {
  initialize(params: object): void;
};

const MODULE_NAME = "RNIUtilitiesModule";

export const RNIUtilitiesModule: RNIUtilitiesModule =
  NativeModules[MODULE_NAME];


RNIUtilitiesModule.initialize({});
