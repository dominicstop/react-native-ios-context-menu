# TODO - `react-native-ios-context-menu`

See [TODO-Archive](./TODO-Archive.md) for the old completed tasks + version history.

<br><br>

## WIP

- [ ] `TODO:2023-11-02-08-04-13` - Impl: Auto close context menu when view controller is pushed, popped, or presented.

<br><br>

## Version: `next`

- [x] `TODO:2023-11-03-02-34-19` - `issue#77–02` - Fix: Auxiliary view isn't pressable.
  * Is the swizzling applied? Yes.
  * Is the detached view able to receive touch events? No.
  * Fix `RNIDetachedView`

<br>

- [x] `TODO:2023-11-02-10-01-30` - Deps: Move `RCTView` to `react-native-ios-utilities`, and update dependencies.
- [x] `TODO:2023-11-02-10-03-20` - Deps: Move `UIView+Helpers` + `UIGestureRecognizer+Helpers` to `DGSwiftUtilities`, and update dependencies.
- [x] `TODO:2023-11-02-03-06-06` - `issue:#73`: Item: 01 - Pressables inside of a context menu firing navigation in a native stack cause a crash
  * Possible cause: Issue w/ long press touch propagation - `react-native` (`RCTTouchHandler`) is not aware that the long press is being handled by `UIContextMenuInteraction`/`UIInteraction`.
    * Possible Fix - 01: Patch `react-native` to recognize `UIInteraction` via swizzling - `RCTTouchHandler` only works with `UIGestureRecognizer`
    * Possible Fix - 02: Prevent "long press touch events" from propagating down.
      * Unable to stop touch propagation via adding a long press gesture recognizer.
      * Unable to stop touch propagation via `UIGestureRecognizerDelegate` + `shouldRecognizeSimultaneouslyWith`.
      * Was able to stop propagation via `RCTTouchHandler`.

<br>

- [x] `TODO:2023-11-02-05-21-36` - Implement: Prop - `shouldPreventLongPressGestureFromPropagating`
  * Related to: `TODO:2023-11-02-03-06-06` - `issue:#73`: Item: 01 - Pressables inside of a context menu firing navigation in a native stack cause a crash.