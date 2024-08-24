import type { AnimationConfig } from "react-native-ios-utilities";


export const AnimationConfigPresets: Array<AnimationConfig | undefined> = [
  undefined,
  {
    mode: 'presetCurve',
    curve: 'linear',
    duration: 0.3,
  },
  {
    mode: 'presetCurve',
    curve: 'linear',
    duration: 1,
  },
  {
    mode: 'presetCurve',
    curve: 'linear',
    duration: 2,
  },
  {
    mode: 'presetCurve',
    curve: 'easeIn',
    duration: 0.3,
  },
  {
    mode: 'presetCurve',
    curve: 'easeIn',
    duration: 1,
  },
  {
    mode: 'presetCurve',
    curve: 'easeOut',
    duration: 0.3,
  },
  {
    mode: 'presetCurve',
    curve: 'easeOut',
    duration: 1,
  },
];