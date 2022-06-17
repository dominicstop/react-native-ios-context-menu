

export type MenuAuxiliaryPreviewAnchorPosition = 
  | "top" 
  | "bottom" 
  | "automatic";

export type MenuAuxiliaryPreviewHorizontalAlignment = 
  | 'stretchScreen'
  | 'stretchPreview'
  | 'previewLeading'
  | 'previewTrailing'
  | 'previewCenter';

export type MenuAuxiliaryPreviewTransitionConfig = {
export type UIViewAnimateConfig = {
  duration?: number;
  delay?: number;
};

export type MenuAuxiliaryPreviewTransitionConfig = UIViewAnimateConfig & ({
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

export type MenuAuxiliaryPreviewTransitionEntranceDelay = 
  | number
  | 'RECOMMENDED'
  | 'AFTER_PREVIEW';

export type MenuAuxiliaryPreviewConfig = {
  height?: number;
  // TODO: Make optional - if null determine width from component view height
  // width?: number;

  anchorPosition?: MenuAuxiliaryPreviewAnchorPosition;
  alignmentHorizontal?: MenuAuxiliaryPreviewHorizontalAlignment;
  
  marginPreview?: number;
  marginAuxiliaryPreview?: number;

  transitionConfigEntrance?: MenuAuxiliaryPreviewTransitionConfig;

  /**
   * The number of seconds to wait before showing the context menu
   * 
   * The default is `AFTER_PREVIEW` (i.e. show the aux. preview after
   * the context menu becomes visible).
   * 
   * Note: If you want to show the aux. preview as soon as possible,
   * set this to `RECOMMENDED` (i.e. 0.25 seconds). A value of less 
   * than 0.25 seconds may cause bugs.
   */
  transitionEntranceDelay?: MenuAuxiliaryPreviewTransitionEntranceDelay;
};