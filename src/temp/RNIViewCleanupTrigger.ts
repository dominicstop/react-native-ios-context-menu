

export type RNIViewCleanupTrigger = 
  | 'instanceDeinit'
  | 'reactComponentWillUnmount'
  | 'viewControllerLifecycle'
  | 'didMoveToNilWindow';