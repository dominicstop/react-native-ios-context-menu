
export type KeyMapType
  <T extends string, K extends { [k in `${T}`]: any }> = K;