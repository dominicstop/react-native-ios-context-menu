import type { NativeSyntheticEvent } from 'react-native';
import type { MenuActionConfig } from './MenuConfig';

// Event Object Types
// ------------------

export type OnMenuWillShowEventObject = NativeSyntheticEvent<{
}>;

export type OnMenuWillHideEventObject = NativeSyntheticEvent<{
}>;

export type OnMenuDidShowEventObject = NativeSyntheticEvent<{
}>;

export type OnMenuDidHideEventObject = NativeSyntheticEvent<{
}>;

export type OnMenuWillCancelEventObject = NativeSyntheticEvent<{
}>;

export type OnMenuDidCancelEventObject = NativeSyntheticEvent<{}> & {
  isUsingActionSheetFallback?: false;
} | { 
  isUsingActionSheetFallback: true;
};

export type OnMenuWillCreateEventObject = NativeSyntheticEvent<{
}>;

export type OnRequestDeferredElementObject = NativeSyntheticEvent<{
  deferredID: string;
}>;

export type OnPressMenuItemEventObject = NativeSyntheticEvent<MenuActionConfig>;

export type OnPressMenuPreviewEventObject = NativeSyntheticEvent<{
}>;

export type MenuAuxiliaryPreviewDetailsEventObject = {
  size: {
    width: number;
    height: number;
  };
  menuHasItems: boolean;
  menuItemsPlacement: 'top' | 'bottom' | 'unknown';
  previewPosition: 'top' | 'bottom';
  isAuxiliaryPreviewAttachedToTop: boolean;
}; 
      
export type OnMenuAuxiliaryPreviewWillShowEventObject =
  NativeSyntheticEvent<MenuAuxiliaryPreviewDetailsEventObject>;

export type OnMenuAuxiliaryPreviewDidShowEventObject = 
  NativeSyntheticEvent<MenuAuxiliaryPreviewDetailsEventObject>;

// Event Handler Types
// -------------------

export type OnMenuWillShowEvent = (
  event: OnMenuWillShowEventObject
) => void;

export type OnMenuWillHideEvent = (
  event: OnMenuWillHideEventObject
) => void;

export type OnMenuDidShowEvent = (
  event: OnMenuDidShowEventObject
) => void;

export type OnMenuDidHideEvent = (
  event: OnMenuDidHideEventObject
) => void;

export type OnMenuWillCancelEvent = (
  event: OnMenuWillCancelEventObject
) => void;

export type OnMenuDidCancelEvent = (
  event: OnMenuDidCancelEventObject
) => void;

export type OnMenuWillCreateEvent = (
  event: OnMenuWillCreateEventObject
) => void;

export type OnRequestDeferredElementEvent = (
  event: OnRequestDeferredElementObject
) => void;

export type OnPressMenuItemEvent = (
  event: OnPressMenuItemEventObject
) => void;

export type OnPressMenuPreviewEvent = (
  event: OnPressMenuPreviewEventObject
) => void;

export type OnMenuAuxiliaryPreviewWillShowEvent = (
  event: OnMenuAuxiliaryPreviewWillShowEventObject
) => void;

export type OnMenuAuxiliaryPreviewDidShowEvent = (
  event: OnMenuAuxiliaryPreviewDidShowEventObject
) => void;