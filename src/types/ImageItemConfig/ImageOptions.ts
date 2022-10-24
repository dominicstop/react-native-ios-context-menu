import type { DynamicColor } from "../MiscTypes";


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