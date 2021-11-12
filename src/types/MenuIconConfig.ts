import type { ImageResolvedAssetSource } from "react-native";


// TODO: Rename to `MenuIconConfig`
// TODO: Replace with `ImageItemConfig` impl. from `react-native-ios-navigator`
export type IconConfig = {
  iconType: 'NONE';

} | {
  iconType: 'SYSTEM';
  iconValue: string;

} | {
  iconType: 'ASSET';
  iconValue: string;

} | {
  iconType: 'REQUIRE';
  iconValue: ImageResolvedAssetSource;
};

export type IconType = IconConfig['iconType'];
