import type { AnimationConfig } from "react-native-ios-utilities";
import type { AuxiliaryPreviewTransitionPreset } from "./AuxiliaryPreviewTransitionPreset";

export type AuxiliaryPreviewTransitionAnimationConfig = {
  delay: number;
  animatorConfig: AnimationConfig;
  transitionPreset: AuxiliaryPreviewTransitionPreset;
};