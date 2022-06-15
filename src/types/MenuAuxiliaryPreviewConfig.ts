

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
  transition: 'none';
} | {
  transition: 'fade' | 'slide' | 'zoom';
  duration?: number;
};

export type MenuAuxiliaryPreviewConfig = {
  height?: number;
  // TODO: Make optional - if null determine width from component view height
  // width?: number; 


  anchorPosition?: MenuAuxiliaryPreviewAnchorPosition;
  alignmentHorizontal?: MenuAuxiliaryPreviewHorizontalAlignment;
  
  marginPreview?: number;
  marginAuxiliaryPreview?: number;

  transitionConfigEntrance?: MenuAuxiliaryPreviewTransitionConfig;
};