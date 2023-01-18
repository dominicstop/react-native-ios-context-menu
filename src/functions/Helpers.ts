import { ActionSheetIOS, ActionSheetIOSOptions, findNodeHandle } from 'react-native';


/** wrapper func for setState that returns a promise */
// eslint-disable-next-line consistent-this
export function setStateAsync<T extends {} >(
  that: React.Component,
  newState: T | ((prevState: T) => T)
) {
  return new Promise<void>((resolve) => {
    that.setState(newState, () => {
      resolve();
    });
  });
};

/** wrapper for timeout that returns a promise */
export function timeout(ms: number) {
  return new Promise<void>(resolve => {
    const timeoutID = setTimeout(() => {
      clearTimeout(timeoutID);
      resolve();
    }, ms)
  });
};

/** Wraps a promise that will reject if not not resolved in <ms> milliseconds */
export function promiseWithTimeout<T>(ms: number, promise: Promise<T>){
  // Create a promise that rejects in <ms> milliseconds
  const timeoutPromise = new Promise<T>((_, reject) => {
    const timeoutID = setTimeout(() => {
      clearTimeout(timeoutID);
      reject(`Promise timed out in ${ms} ms.`)
    }, ms);
  });

  // Returns a race between our timeout and the passed in promise
  return Promise.race([promise, timeoutPromise]);
};

export function pad(num: number | string, places = 2){
  return String(num).padStart(places, '0');
};

export function asyncActionSheet(config: ActionSheetIOSOptions){
  return new Promise(resolve => {
    ActionSheetIOS.showActionSheetWithOptions(config, (buttonIndex) => {
      resolve(buttonIndex);
    });
  });
};

export function asyncActionSheetConfirm(config: {
  title        : string; 
  message      : string; 
  confirmText  : string; 
  isDestructive?: boolean;
}){
  const isDestructive = config.isDestructive ?? false;

  return new Promise(resolve => {
    ActionSheetIOS.showActionSheetWithOptions({
      title  : config.title,
      message: config.message,

      options: ['Cancel', config.confirmText],
      cancelButtonIndex: 0,
      ...(isDestructive && {
        destructiveButtonIndex: 1,
      }),
    }, (buttonIndex) => {
      resolve((buttonIndex === 1));
    });
  });
};
export function getNativeNodeHandle(nativeRef: React.Component){
  const nodeHandle = findNodeHandle(nativeRef);

  if(nodeHandle == null){
    throw new Error('Unable to get the node handle for the native ref.');
  };

  return nodeHandle;
};