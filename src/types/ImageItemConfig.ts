import type { Point, PointPreset, DynamicColor } from "./MiscTypes";


/** Object returned by `Image.resolveAssetSource()` */
export type ImageResolvedAssetSource = {
  height: number;
  width: number;
  scale: number;
  uri: string;
};

export enum ImageTypes {
  IMAGE_ASSET    = 'IMAGE_ASSET'   ,
  IMAGE_SYSTEM   = 'IMAGE_SYSTEM'  ,
  IMAGE_REQUIRE  = 'IMAGE_REQUIRE' ,
  IMAGE_EMPTY    = 'IMAGE_EMPTY'   ,
  IMAGE_RECT     = 'IMAGE_RECT'    ,
  IMAGE_GRADIENT = 'IMAGE_GRADIENT',
};

export type ImageRectConfig = {
  width: number;
  height: number;
  fillColor: string;
  borderRadius?: number;
};

/** Maps to `UIImage.RenderingMode`*/
export type ImageRenderingModes = 
  'automatic' | 'alwaysOriginal' | 'alwaysTemplate';

/** `UIImage`-related */
export type UIImageConfig = {
  tint?: string | DynamicColor;
  renderingMode?: ImageRenderingModes;
};

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

/** Maps to `UIImage.SymbolConfiguration` */
type ImageSystemSymbolConfiguration = {
  pointSize?: number;
  weight?: ImageSymbolWeight;
  scale?: ImageSymbolScale;
} & ({
  /** Requires iOS 15+ */
  hierarchicalColor?: string | DynamicColor;
} | {
  /** Requires iOS 15+ */
  paletteColors?: [string | DynamicColor];
});

export type ImageSystemConfig = ImageSystemSymbolConfiguration & {
  systemName: string;
};

export type ImageGradientConfig = Partial<Pick<ImageRectConfig, 
  | 'width'
  | 'height'
  | 'borderRadius'
>> & {
  /* An array defining the color of each gradient stop. */
  colors: Array<string>;

  /* Defines the location of each gradient stop. */
  locations?: Array<number>;

  /* The start point of the gradient when drawn in the layer’s coordinate space. */
  startPoint?: Point | PointPreset;

  /* The end point of the gradient when drawn in the layer’s coordinate space. */
  endPoint?: Point | PointPreset;
  
  /* Style of gradient drawn by the layer. Defaults to axial. */
  type?: 'axial' | 'conic' | 'radial'
};

/**
 * A configuration object for images.
 * 
 * This configuration object is used to either programmatically create images,
 * (e.g. gradients, rects, SFSymbols icons, etc)., or refer to existing image assets
 * in the project (e.g. js image assets, XCAssets).
 */
export type ImageItemConfig = {
  type: 'IMAGE_ASSET';
  /** The corresponding key of asset item in the asset catalog */
  imageValue: string;
  imageOptions?: UIImageConfig;

} | {
  type: 'IMAGE_SYSTEM';
  /** The key/name of the SF Symbols system icon */
  imageValue: ImageSystemConfig;
  imageOptions?: UIImageConfig;

} | {
  type: 'IMAGE_REQUIRE';
  /** Object returned by `Image.resolveAssetSource()` */
  imageValue: ImageResolvedAssetSource;
  imageOptions?: UIImageConfig;

} | {
  type: 'IMAGE_EMPTY';

} | {
  type: 'IMAGE_RECT';
  imageValue: ImageRectConfig;

} | {
  type: 'IMAGE_GRADIENT';
  imageValue: ImageGradientConfig;
  
};

export type ImageItemConfigType = ImageItemConfig['type'];