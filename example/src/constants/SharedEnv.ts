

export const SHARED_ENV = {
  enableReactNavigation: true,
  enableTabNavigation: false,
  shouldSetAppBackground: false
};

export const IS_USING_NEW_ARCH = 
  (global as any)?.nativeFabricUIManager != null;