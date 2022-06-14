

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
  // TODO: Make optional - if null determine height from component view height
  height: number;

  anchorPosition?: MenuAuxiliaryPreviewAnchorPosition;
  alignmentHorizontal?: MenuAuxiliaryPreviewHorizontalAlignment;
  
  marginPreview?: number;
  marginAuxiliaryPreview?: number;

  transitionConfigEntrance?: MenuAuxiliaryPreviewTransitionConfig;
};