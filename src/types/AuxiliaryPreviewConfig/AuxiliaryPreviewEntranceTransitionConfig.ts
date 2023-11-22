import type { AuxiliaryPreviewTransitionAnimationConfig } from "./AuxiliaryPreviewTransitionAnimationConfig";

export type AuxiliaryPreviewEntranceTransitionConfig = {
  mode: 'syncedToMenuEntranceTransition';
  shouldAnimateSize: boolean;
} | {
  mode: 'customDelay';
  config: AuxiliaryPreviewTransitionAnimationConfig;
} | {
  mode: 'afterMenuEntranceTransition';
  config: AuxiliaryPreviewTransitionAnimationConfig;
};
