import type { ImageOptions } from './ImageOptions';
import type { ImageLoadingConfig, ImageRemoteUrlConfig, ImageRemoteURLLoadingConfig } from './ImageLoadingConfig';
import type { ImageSystemConfig } from './ImageSystemConfig';
import type { ImageResolvedAssetSource } from './ImageMiscTypes';
import type { ImageRectConfig } from './ImageRectConfig';
import type { ImageGradientConfig } from './ImageGradientConfig';

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
  imageOptions?: ImageOptions;

} | {
  type: 'IMAGE_SYSTEM';
  /** The key/name of the SF Symbols system icon */
  imageValue: ImageSystemConfig;
  imageOptions?: ImageOptions;

} | {
  type: 'IMAGE_REQUIRE';
  /** Object returned by `Image.resolveAssetSource()` */
  imageValue: ImageResolvedAssetSource;
  imageOptions?: ImageOptions;
  imageLoadingConfig?: ImageLoadingConfig;

} | {
  type: 'IMAGE_EMPTY';

} | {
  type: 'IMAGE_RECT';
  imageValue: ImageRectConfig;

} | {
  type: 'IMAGE_GRADIENT';
  imageValue: ImageGradientConfig;
  imageOptions?: ImageOptions;
  
} | {
  type: 'IMAGE_REMOTE_URL';
  imageValue: ImageRemoteUrlConfig;
  imageLoadingConfig?: ImageRemoteURLLoadingConfig;
  imageOptions?: ImageOptions;
};

export type ImageItemConfigType = ImageItemConfig['type'];
