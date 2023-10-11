import type { DynamicColor } from "../MiscTypes";

export type ImageSymbolWeight = 
  | 'unspecified'
  | 'ultraLight'
  | 'thin'
  | 'light'
  | 'regular'
  | 'medium'
  | 'semibold'
  | 'bold'
  | 'heavy'
  | 'black';

export type ImageSymbolScale = 
  | 'default'
  | 'unspecified'
  | 'small'
  | 'medium'
  | 'large';

export type ImageSystemConfig = ImageSystemSymbolConfiguration & {
  systemName: string;
};

/** Maps to `UIImage.SymbolConfiguration` */
export type ImageSystemSymbolConfiguration = {
  pointSize?: number;
  weight?: ImageSymbolWeight;
  scale?: ImageSymbolScale;
} & ({
  /** Requires iOS 15+ */
  hierarchicalColor?: string | DynamicColor;
} | {
  /** Requires iOS 15+ */
  paletteColors?: Array<string | DynamicColor>;
});
