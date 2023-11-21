
export type VerticalAnchorPositionMode = 
  | 'top'
  | 'bottom'
  | 'automatic';

export type HorizontalAlignmentPosition = 
  | 'stretch'
  | 'stretchTarget'
  | 'targetLeading'
  | 'targetTrailing'
  | 'targetCenter';

export type AuxiliaryPreviewSizeValue = {
  mode: 'constant';
  value: number;
} | {
  mode: 'percentRelativeToWindow';
  percent: number;
} | {
  mode: 'percentRelativeToPreview';
  percent: number;
} | {
  mode: 'multipleValues';
  values: [AuxiliaryPreviewSizeValue];
};

// Maps to: `UIView.AnimationCurve`
export type UIViewAnimationCurve = 
  | 'easeInOut'
  | 'easeIn'
  | 'easeOut'
  | 'linear';

export type CGPoint = {
  x: number;
  y: number;
};

export type CGVector = {
  dx: number;
  dy: number;
};

// Unsupported: 
// * animator: UIViewPropertyAnimator
export type AnimationConfig = {
  mode: 'presetCurve';
  duration: number;
  curve: UIViewAnimationCurve;
} | {
  mode: 'presetSpring';
  duration: number;
  dampingRatio: number;
} | {
  mode: 'bezierCurve';
  controlPoint1: CGPoint;
  controlPoint2: CGPoint;
} | {
  mode: 'springDamping';
  duration: number;
  dampingRatio: number;
  initialVelocity?: CGVector;
  maxVelocity?: number;
} | {
  mode: 'springPhysics';
  duration: number;
  mass: number;
  stiffness: number
  damping: number;
  initialVelocity?: CGVector;
  maxVelocity?: number;
};


export type AuxiliaryPreviewTransitionAnimationConfig = {
  delay: number;
  animatorConfig: AnimationConfig;
  transitionPreset: AuxiliaryPreviewTransitionPreset;
};

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

export type AuxiliaryPreviewTransitionPreset = {
  mode: 'none';
} | {
  mode: 'fade';
} | {
  mode: 'slide';
  slideOffset?: number;
} | {
  mode: 'zoom';
  zoomOffset?: number;
} | {
  mode: 'zoomAndSlide';
  slideOffset?: number;
  zoomOffset?: number;
} | {
  mode: 'custom';
  keyframeStart: AuxiliaryPreviewTransitionKeyframeConfig;
  keyframeEnd?: AuxiliaryPreviewTransitionKeyframeConfig;
};


export type Transform3D = {
  translateX?: number;
  translateY?: number;
  translateZ?: number;
  scaleX?: number;
  scaleY?: number;
  rotateX?: number;
  rotateY?: number;
  rotateZ?: number;
  perspective?: number;
  skewX?: number;
  skewY?: number;
};

export type AuxiliaryPreviewTransitionKeyframeConfig = {
  opacity?: number;
  transform?: Transform3D;
  auxiliaryPreviewPreferredWidth?: AuxiliaryPreviewSizeValue;
  auxiliaryPreviewPreferredHeight?: AuxiliaryPreviewSizeValue;
};

export type MenuAuxiliaryPreviewConfigNew = {
  verticalAnchorPosition: VerticalAnchorPositionMode;
  horizontalAlignment: HorizontalAlignmentPosition;
  preferredWidth: AuxiliaryPreviewSizeValue;
  preferredHeight: AuxiliaryPreviewSizeValue;

  marginInner: number;
  marginOuter: number;

  transitionConfigEntrance: AuxiliaryPreviewEntranceTransitionConfig;
  transitionExitPreset: AuxiliaryPreviewTransitionPreset;
};



