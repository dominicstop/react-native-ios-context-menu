
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