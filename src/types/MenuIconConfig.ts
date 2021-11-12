import type { ImageResolvedAssetSource } from "react-native";
import type { DynamicColor } from './MiscTypes';


// TODO: Rename to `MenuIconConfig`
// TODO: Replace with `ImageItemConfig` impl. from `react-native-ios-navigator`
export type IconConfig = {
  iconType: 'NONE';

} | {
  iconType: 'SYSTEM';
  iconValue: string;
  iconTint?: string | DynamicColor;
  
} | {
  iconType: 'ASSET';
  iconValue: string;

} | {
  iconType: 'REQUIRE';
  iconValue: ImageResolvedAssetSource;
};

export type IconType = IconConfig['iconType'];
