import type { HorizontalAlignmentPosition, VerticalAnchorPositionMode } from "react-native-ios-utilities";
import type { AuxiliaryPreviewSizeValue } from "./AuxiliaryPreviewSizeValue";
import type { AuxiliaryPreviewEntranceTransitionConfig } from "./AuxiliaryPreviewEntranceTransitionConfig";
import type { AuxiliaryPreviewTransitionPreset } from "./AuxiliaryPreviewTransitionPreset";


export type AuxiliaryPreviewConfig = {
  verticalAnchorPosition?: VerticalAnchorPositionMode;
  horizontalAlignment: HorizontalAlignmentPosition;
  preferredWidth?: AuxiliaryPreviewSizeValue;
  preferredHeight?: AuxiliaryPreviewSizeValue;

  marginVerticalInner?: number;
  marginVerticalOuter?: number;

  transitionConfigEntrance: AuxiliaryPreviewEntranceTransitionConfig;
  transitionExitPreset: AuxiliaryPreviewTransitionPreset;
};