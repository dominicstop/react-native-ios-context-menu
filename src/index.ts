import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to ReactNativeIosContextMenu.web.ts
// and on native platforms to ReactNativeIosContextMenu.ts
import ReactNativeIosContextMenuModule from './ReactNativeIosContextMenuModule';
import ReactNativeIosContextMenuView from './ReactNativeIosContextMenuView';
import { ChangeEventPayload, ReactNativeIosContextMenuViewProps } from './ReactNativeIosContextMenu.types';

// Get the native constant value.
export const PI = ReactNativeIosContextMenuModule.PI;

export function hello(): string {
  return ReactNativeIosContextMenuModule.hello();
}

export async function setValueAsync(value: string) {
  return await ReactNativeIosContextMenuModule.setValueAsync(value);
}

const emitter = new EventEmitter(ReactNativeIosContextMenuModule ?? NativeModulesProxy.ReactNativeIosContextMenu);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { ReactNativeIosContextMenuView, ReactNativeIosContextMenuViewProps, ChangeEventPayload };
