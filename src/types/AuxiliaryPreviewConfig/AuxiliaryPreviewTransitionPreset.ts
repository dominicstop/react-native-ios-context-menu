import type { AuxiliaryPreviewTransitionKeyframeConfig } from "./AuxiliaryPreviewTransitionKeyframeConfig";


export type AuxiliaryPreviewTransitionPreset = {
  mode: 'none';

} | {
  mode: 'fade';

} | {
  mode: 'slide';
  slideOffset?: number;

} | {
  mode: 'zoom';
  zoomOffset?: number;

} | {
  mode: 'zoomAndSlide';
  slideOffset?: number;
  zoomOffset?: number;
  
} | {
  mode: 'custom';
  keyframeStart: AuxiliaryPreviewTransitionKeyframeConfig;
  keyframeEnd?: AuxiliaryPreviewTransitionKeyframeConfig;
};