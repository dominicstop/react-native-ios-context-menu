# TODO - `react-native-ios-context-menu`

See [TODO-Archive](./TODO-Archive.md) for the old completed tasks + version history.

<br><br>

## WIP

- [ ] `TODO:2023-11-02-05-21-36` - Implement: Prop - `shouldPreventLongPressGestureFromPropagating`
  * Related to: `TODO:2023-11-02-03-06-06` - `issue:#73`: Item: 01 - Pressables inside of a context menu firing navigation in a native stack cause a crash.

<br><br>

## Version: `next`

- [x] `TODO:2023-11-02-03-06-06` - `issue:#73`: Item: 01 - Pressables inside of a context menu firing navigation in a native stack cause a crash
  * Possible cause: Issue w/ long press touch propagation - `react-native` (`RCTTouchHandler`) is not aware that the long press is being handled by `UIContextMenuInteraction`/`UIInteraction`.
    * Possible Fix - 01: Patch `react-native` to recognize `UIInteraction` via swizzling - `RCTTouchHandler` only works with `UIGestureRecognizer`
    * Possible Fix - 02: Prevent "long press touch events" from propagating down.