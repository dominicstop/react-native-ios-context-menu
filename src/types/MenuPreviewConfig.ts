import type { DynamicColor, NativeViewIdentifier } from 'react-native-ios-utilities';

export type MenuPreviewType = 'DEFAULT' | 'CUSTOM';

export type MenuPreviewSize = 'INHERIT' | 'STRETCH';

/** Maps to `UIContextMenuInteractionCommitStyle` */
export type ContextMenuInteractionCommitStyle = 'dismiss' | 'pop';

export type MenuPreviewConfig = {
  previewType?: MenuPreviewType;
  previewSize?: MenuPreviewSize;
  isResizeAnimated?: boolean;
  borderRadius?: number;
  backgroundColor?: DynamicColor | string;
  preferredCommitStyle?: ContextMenuInteractionCommitStyle;
} & ({
  // deprecated
  targetViewNode?: number;
} | {
  viewIdentifier?: NativeViewIdentifier;
});

