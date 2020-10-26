import { ActionSheetIOS } from 'react-native';


//wrapper func for setstate that returns a promise
export function setStateAsync(that, newState) {
  return new Promise((resolve) => {
      that.setState(newState, () => {
          resolve();
      });
  });
};

//wrapper for timeout that returns a promise
export function timeout(ms) {
  return new Promise(resolve => {
    const timeoutID = setTimeout(() => {
      clearTimeout(timeoutID);
      resolve();
    }, ms)
  });
};

export function pad(num, places = 2){
  return String(num).padStart(places, '0');
};

export function asyncActionSheet(config){
  return new Promise(resolve => {
    ActionSheetIOS.showActionSheetWithOptions(config, (buttonIndex) => {
      resolve(buttonIndex);
    });
  });
};

export function asyncActionSheetConfirm({title, message, confirmText, isDestructive = false}){
  return new Promise(resolve => {
    ActionSheetIOS.showActionSheetWithOptions({
      title, message,
      options: ['Cancel', confirmText],
      cancelButtonIndex: 0,
      ...(isDestructive && {
        destructiveButtonIndex: 1,
      }),
    }, (buttonIndex) => {
      resolve((buttonIndex === 1));
    });
  });
};
