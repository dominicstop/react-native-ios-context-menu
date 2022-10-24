
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