import { Transform3D } from "react-native-ios-utilities";
import { AuxiliaryPreviewSizeValue } from "./AuxiliaryPreviewSizeValue";

export type AuxiliaryPreviewTransitionKeyframeConfig = {
  opacity?: number;
  transform?: Transform3D;
  auxiliaryPreviewPreferredWidth?: AuxiliaryPreviewSizeValue;
  auxiliaryPreviewPreferredHeight?: AuxiliaryPreviewSizeValue;
};