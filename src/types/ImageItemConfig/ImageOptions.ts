import type { DynamicColor } from 'react-native-ios-utilities';


/** Maps to `UIImage.RenderingMode`*/
export type ImageRenderingModes = 
  'automatic' | 'alwaysOriginal' | 'alwaysTemplate';

/** `UIImage`-related */
export type UIImageConfig = {
  tint?: string | DynamicColor;
  renderingMode?: ImageRenderingModes;
};

export type ImageOptions = UIImageConfig & {
  cornerRadius?: number
};