import type { UIViewAnimateConfig } from "./UIViewAnimateConfig";

export type MenuAuxiliaryPreviewBaseTransitionConfig =  & ({
  transition: 'none';
} | {
  transition: 'fade';
} | {
  transition: 'slide';
  slideOffset?: number;
} | {
  transition: 'zoom';
  zoomOffset?: number;
} | {
  transition: 'zoomAndSlide';
  slideOffset?: number;
  zoomOffset?: number;
});


export type MenuAuxiliaryPreviewTransitionConfig = 
  UIViewAnimateConfig & MenuAuxiliaryPreviewBaseTransitionConfig;