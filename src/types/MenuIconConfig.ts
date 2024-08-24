import type { ImageResolvedAssetSource } from "react-native";
import type { DynamicColor } from 'react-native-ios-utilities';


// TODO: Next Major Version - Rename to `MenuIconConfigDeprecated`
/** 
 * **Deprecated** - Use `ImageItemConfig` type instead.
 * Used to configure the icons on a menu.
 * */
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
