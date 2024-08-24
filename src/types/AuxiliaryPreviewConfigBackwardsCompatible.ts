import { AuxiliaryPreviewConfig } from "./AuxiliaryPreviewConfig/AuxiliaryPreviewConfig";
import { AuxiliaryPreviewConfigDeprecated } from "./AuxiliaryPreviewConfigDeprecated";

export type AuxiliaryPreviewConfigBackwardsCompatible = 
  | AuxiliaryPreviewConfigDeprecated
  | AuxiliaryPreviewConfig;