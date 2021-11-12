import type { DynamicColor } from "./MiscTypes";

export type PreviewType = 'DEFAULT' | 'CUSTOM';

export type PreviewSize = 'INHERIT' | 'STRETCH';

export type CommitStyle = 'dismiss' | 'pop';

export type MenuPreviewConfig = {
  previewType?: PreviewType;
  previewSize?: PreviewSize;
  isResizeAnimated?: boolean;
  borderRadius?: number;
  backgroundColor?: DynamicColor | string;
  preferredCommitStyle?: CommitStyle;
  targetViewNode?: number;
};