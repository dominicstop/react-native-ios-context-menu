import type { Transform3D } from "react-native-ios-utilities";
import type { AuxiliaryPreviewSizeValue } from "./AuxiliaryPreviewSizeValue";

export type AuxiliaryPreviewTransitionKeyframeConfig = {
  opacity?: number;
  transform?: Transform3D;
  auxiliaryPreviewPreferredWidth?: AuxiliaryPreviewSizeValue;
  auxiliaryPreviewPreferredHeight?: AuxiliaryPreviewSizeValue;
};