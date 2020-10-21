import { NativeModules } from 'react-native';

type IosContextMenuType = {
  multiply(a: number, b: number): Promise<number>;
};

const { IosContextMenu } = NativeModules;

export default IosContextMenu as IosContextMenuType;
