import type { PointPreset } from "../MiscTypes";
import type { Point } from "../MiscTypes";
import type { ImageRectConfig } from "./ImageRectConfig";


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