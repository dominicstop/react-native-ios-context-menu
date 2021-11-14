import { ActionSheetIOS, ActionSheetIOSOptions } from 'react-native';


/** wrapper func for setState that returns a promise */
// eslint-disable-next-line consistent-this
export function setStateAsync<T>(
  that: React.Component,
  newState: T | ((prevState: T) => T)
){
  return new Promise<void>((resolve) => {
    that.setState(newState, () => {
      resolve();
    });
  });
};

/** wrapper for timeout that returns a promise */
export function timeout(ms: Number) {
  return new Promise<void>(resolve => {
    const timeoutID = setTimeout(() => {
      clearTimeout(timeoutID);
      resolve();
    }, ms)
  });
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
