import { type RNIUtilitiesModule } from "react-native-ios-utilities";


export function getRNIUtilitiesModule(): typeof RNIUtilitiesModule{
  // @ts-ignore
  return global.RNIUtilitiesModule;
};
