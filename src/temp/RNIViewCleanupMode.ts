import { RNIViewCleanupTrigger } from "./RNIViewCleanupTrigger";


export type RNIViewCleanupMode = {
  mode: 'default';
} | {
  mode: 'disabled';
} | {
  mode: 'enabled'
  triggers: Array<RNIViewCleanupTrigger>;
};