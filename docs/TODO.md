# TODO - `react-native-ios-context-menu`

See [TODO-Archive](./TODO-Archive.md) for the old completed tasks + version history.

<br><br>

## WIP

- [ ] `TODO:2023-11-20-18-29-21` - Impl: Support accepting `AuxiliaryPreviewConfig` via `ContextMenuView.auxiliaryPreviewConfig` prop.
  * Add `deprecated` suffix to old type for the `auxiliaryPreviewConfig` prop. 

<br>

- [ ] `TODO:2023-11-20-16-06-46` - Fix: Aux. Preview Menu - Entrance Transition + Sizingiz - Fix bug where the size of the aux. preview is wrong for a split second during the entrance transition, and will not occur after that. 
  * Repro: `ContextMenuAuxPreviewExample01` - Happens when `ContextMenuAuxPreviewExample01` is the first context menu to be shown.
  * Observation: Happens only once, when no other context menu has been shown yet, e.g. if you show any context menu before `ContextMenuAuxPreviewExample01`, the bug will not occur anymore until the app is restarted.
  * `timestamp:2023-11-20-17-28-56` - Debugging: Might be caused by decoding the strings inside the entrance transition animation block?
    *  Tried caching all the `HashedStringDecodable` encoded strings (e.g. `ContextMenuInteractionWrapper`, `ContextMenuPlatterTransitionViewWrapper`, `ContextMenuViewWrapper`, `MorphingPlatterViewWrapper`), but the bug still occurs.
    * Log: `decodedStrings` - `["_presentMenuAtLocation:", "_UIContextMenuPlatterTransitionView", "_UIContextMenuView", "_UIMorphingPlatterView"]`
  * `timestamp:2023-11-20-17-44-54` - Debugging: Calling `attachAndAnimateInAuxiliaryPreviewTogetherWithContextMenu` inside `DispatchQueue.main.async` removes the initial size stutter (the aux. preview now just appear w/o animation in the correct size when shown for the first time), but the entrance transition animations (e.g. fade, scale transform) no longer play.

<br>

- [ ] `TODO:2023-11-20-16-08-31` - Fix:  Aux. Preview Menu - Exit Transition + Sizing - Fix bug where the after the exit transition of the aux. preview, it's size suddenly becomes wrong, i.e. it turns into a small box.
  * Repro: `ContextMenuAuxPreviewExample06`

<br>

- [ ] `TODO:2023-11-02-08-04-13` - Impl: Auto close context menu when view controller is pushed, popped, or presented.

<br><br>

## Version: `next`

<br><br>

## Version: `2.2.0`

- [x] `TODO:2023-11-20-18-26-20` - Impl: `ContextMenuView.showAuxiliaryPreviewAsPopover`
- [x] `TODO:2023-11-19-19-56-16` - Fix: Aux. Preview Menu - Entrance Transition Bug - Entrance transitions that uses "zoom"/scale causes the animation to be stutter.
  * Repro: `ContextMenuAuxPreviewExample12`, `ContextMenuAuxPreviewExample13`

<br>

- [x] `TODO:2023-11-19-17-44-20` - Fix: Aux. Preview Exit Transition Bug - Fix bug where the aux. preview exit transition sometimes doesn't start.
  * The bug happens in every other time the context menu is shown/hidden.

<br>

- [x] `TODO:2023-11-19-19-48-44` - Fix: Aux. Preview Menu - Entrance Transition Bug - Fix bug where the size of the aux. preview is wrong,
  * Repro: `ContextMenuAuxPreviewExample01`, `ContextMenuAuxPreviewExample06`, 
  * Only occurs when no context menu has been shown yet, and the aux. preview has to be resized.

<br>

- [x] `TODO:2023-11-19-10-20-25` Fix: Aux. Preview Resizing - Resizing for the aux. preview is not working, so horizontal alignment `stretch`, `stretchScreen` is not working, as well as explicitly defining the width + height of the aux. preview via the config.
  * Debugging `ContextMenuAuxPreviewExample01` 
    * Showing aux. preview and inspecting the view hierarchy...
      * `RNIDetachedView.frame` = `0 -59 374 47`
      * `RCTView` = `0 0 87 47`
      * This is the root view returned from `ContextMenuView.renderAuxiliaryPreview`
    * The size of `renderAuxiliaryPreview` does not match its parent view `RNIDetachedView`.
    * Adding `flex: 1` to `renderAuxiliaryPreview` does nothing.
    * Removing all styles to `renderAuxiliaryPreview` does nothing.

<br><br>

## Version: `2.0.5` and Older

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