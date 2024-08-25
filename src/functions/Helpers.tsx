import { type RNIUtilitiesModule } from "react-native-ios-utilities";


export function getRNIUtilitiesModule(): typeof RNIUtilitiesModule{
  // @ts-ignore
  return global.RNIUtilitiesModule;
};

// eslint-disable-next-line consistent-this
export function setStateAsync<T extends {}>(
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
export function timeout(ms: number) {
  return new Promise<void>(resolve => {
    const timeoutID = setTimeout(() => {
      clearTimeout(timeoutID);
      resolve();
    }, ms);
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