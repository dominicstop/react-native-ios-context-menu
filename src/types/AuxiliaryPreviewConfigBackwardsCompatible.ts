import type { AuxiliaryPreviewConfig } from "./AuxiliaryPreviewConfig/AuxiliaryPreviewConfig";
import type { AuxiliaryPreviewConfigDeprecated } from "./AuxiliaryPreviewConfigDeprecated";

export type AuxiliaryPreviewConfigBackwardsCompatible = 
  | AuxiliaryPreviewConfigDeprecated
  | AuxiliaryPreviewConfig;