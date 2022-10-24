import type { ImageItemConfig } from "./ImageItemConfig";


export type ImageLoadingConfig = {
  shouldCache?: boolean;
  shouldLazyLoad?: boolean;
};

export type ImageRemoteUrlConfig = {
  url: string;
  fallbackImage?: ImageItemConfig;
};

export type ImageRemoteURLFallbackBehavior = 
  | 'afterFinalAttempt'
  | 'whileNotLoaded'
  | 'onLoadError';

export type ImageRemoteURLLoadingConfig = ImageLoadingConfig & {
  maxRetryAttempts?: number;
  shouldImmediatelyRetryLoading?: boolean;
  fallbackBehavior?: ImageRemoteURLFallbackBehavior
};
