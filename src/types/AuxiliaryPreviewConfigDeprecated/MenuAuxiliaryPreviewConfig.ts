import type { MenuAuxiliaryPreviewAnchorPosition } from "./MenuAuxiliaryPreviewAnchorPosition";
import type { MenuAuxiliaryPreviewHorizontalAlignment } from "./MenuAuxiliaryPreviewHorizontalAlignment";
import type { MenuAuxiliaryPreviewTransitionConfig } from "./MenuAuxiliaryPreviewTransitionConfig";
import type { MenuAuxiliaryPreviewTransitionEntranceDelay } from "./MenuAuxiliaryPreviewTransitionEntranceDelay";

export type MenuAuxiliaryPreviewConfig = {
  height?: number;
  width?: number;

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
   * set this to `RECOMMENDED` (i.e. 0.325 seconds). A value of less
   * than 0.325 seconds may cause bugs.
   */
  transitionEntranceDelay?: MenuAuxiliaryPreviewTransitionEntranceDelay;
};
