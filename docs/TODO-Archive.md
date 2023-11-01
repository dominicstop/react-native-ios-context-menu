# TODO - Archive

## Version History

## 

### Version: `1.15.0`

TBA

<br>

### Version: `1.14.0`

TBA

<br>

### Version: `1.13.0`

TBA

<br>

### Version: `1.12.2`

- [x] (Commit: `19b12d8`) **Implement**: `RNIContextMenuView.cleanupMode`.
- [x] (Commit: `8be50ac`) **Implement**: `RNIContextMenuButton.cleanupMode`.

<br>

### Version: `1.12.1`

- [x] (Commit: `77d532a`) **Bug**: `ContextMenuView.onPressMenuItem` timeout.
- [x] (Commit: `c7b24fa`) **Bug**: Aux. Preview - Layout Jank on Exit Transition
	* When the exit transition begins, the aux. preview jumps. This is especially noticeable when there's a custom preview.
	* During the exit transition, the aux. preview jumps to the target view because it's attached to the platter view. The platter view's contents changes from the custom preview, back to the target view.

<br>

### Version: `1.12.0`

- [x] (Commit: `b0a9cfb`) **Implement**:  `UIMenu.ElementSize`
	- [x] (Commit: `a657334`, `7920970`, `67d5145`) Example: Create example for  `menuPreferredElementSize`.
	- [x] (Commit: `4454f49`) Docs: Add documentation stubs for `menuPreferredElementSize` and `MenuElementSize`.
	- [x] (Commit: `1ed3f1c`) Docs: Add examples for `menuPreferredElementSize` to example section.

<br>

- [x] (Commit: `b1c048e`) Implement: `UIMenuElement.Attributes.keepsMenuPresented`.
	- [x] (Commit: `77ecb00`) Example: Create example for `menuAttributes: ['keepsMenuPresented']`.
	- [x] (Commit: `1ed3f1c`) Docs: Add documentation stubs for `keepsMenuPresented`.
	- [x] (Commit: `de92b52`) Docs: Add examples for `keepsMenuPresented` to example section.

<br>

- [x] (Commit: `34b64e6`) Make iOS 16 implemented features backwards compatible to prev. Xcode version.

- [x] (Commit: `82c3743`) Example: Menu Icons - Advanced SF Symbols customizations 
	- [x] (Commit: `Uncategorized/WIP`) Docs: Add example for "advanced SF Symbols customizations"  to example section.


<br>

- [x] (Commit: `ed32e8d`) Implement: `menuSubtitle`
	- [x] (Commit: `171a49a`) Docs: Add documentation stubs for `menuSubtitle`.

<br>

- [x] (Commit: `5e834e1`) Implement: Make `menuTitle` optional in `RNIMenuItem`.
	* Reverted in Commit: `030a716`.
	* Note: The type property must be required to make `menuTitle` optional.

<br>

- [x] (Commit: `7c3fa85`) Use subtitle for `discoverabilityTitle` on iOS 13 if there's no `discoverabilityTitle`.

- [x] **Task**: Test all context menu items.

	- Push screen, test items, pop screen, test items, and so on...
		- Simulator A: iPhone 8 - iOS 15.2
		- Simulator B: iPhone 8 - iOS 16.0
		- Device: iPhone XR - iOS 15.1

	<br>

	- [x] **Task**: Simulator A - Debug — Test all context menu view example items.
	- [x] **Task**: Simulator A - Debug — Test all context menu view test items.
	- [x] **Task**: Simulator A - Debug — Test all context button items.
		* Crash due to Commit: `8562755`. Revert in Commit: `983ec75`.

	<br>

	- [x] **Task**: Simulator A - Release — Test all context menu view example items.
	- [x] **Task**: Simulator A - Release — Test all context menu view test items.
	- [x] **Task**: Simulator A - Release — Test all context button items.

	<br>

	- [x] **Task**: Simulator B - Release — Test all context menu view example items.
	- [x] **Task**: Simulator B - Release — Test all context menu view test items.
	- [x] **Task**: Simulator B - Release — Test all context button items.

	<br>

	- [x] **Task**: Device - Release — Test all context menu view example items.
	- [x] **Task**: Device - Release — Test all context menu view test items.

	- [x] **Task**: Device - Release — Test all context button items.

<br>

### Version: `1.11.0`

- [x] **Refactor**:  `RNIContextMenu` and `RNIContextMenuViewController`

	- [x] (Commit: `821657d`) **Remove**: `RNIContextMenu.attachToParentVC` and `RNIContextMenu.detachFromParentVC`

		* Move these to `RNIContextMenuView` and `RNIContextMenuButton`.

		<br>

	- [x] (Commit: `82bcde4`) **Refactor**: Rename `RNIContextMenuViewController` to `RNINavigationEventsReportingViewController`.

	- [x] (Commit: `a6210ea`) **Refactor**: Rename `RNIContextMenu` to `RNINavigationEventsChildViewController`

		* Any classes that conform to this protocol means that it can be notified of navigation events (e.g. push, pop, etc).

			<br>

	- [x] (Commit: `821657d`) **Refactor**: `RNINavigationEventsNotifiable` — Separations of concerns - Remove unrelated methods (e.g. `attachToParentVC`, `detachFromParentVC`).

<br>

- [x] (Commit: `42653ae`) **Refactor**: Use `RNICleanable` Protocol

- [x] **Refactor**: Re-write `RNIWrapperView`

	- [x] (Commit: `5bcac3a`) **Refactor**: Extract Delegate to Own File

	- [x] (Commit: `97f73d1`) **Refactor**: Rename `RNIWrapperViewDelegate` to `RNIWrapperViewEventsNotifiable`.

	- [x] Refactor: `RNIWrapperView` - Initial Rewrite

		- [x] (Commit: `0dcff7a`) **Refactor**: Add `should` prefix to bool configs.
		- [x] (Commit: `21cc17b`) **Gloss**: Yakshaving - Re-arrange and group related properties into section .
		- [x] (Commit: `46f6509`) **Cleanup**: Rewrite `didMoveToWindow`.
		- [x] (Commit: `ff165b8`) **Refactor**: Replace `willChangeSuperview` and `didChangeSuperview` to `isMovingToParent`.
		- [x] (Commit: `68b068a`): **Update**:  Fix potential order of operations bug — Switch call order in `RNIWrapperView.onJSComponentWillUnmount`, i.e. trigger cleanup at the end.
		- [x] (Commit: `79a4be8`) **Update**: Change default values — Set all feature flags to false by default.

		<br>

		- [x] (Commit: `bac3096`) Fix: Re-Enable Cleanup - Fix `cleanup` Not Being Invoked.
		- [x] (Commit: `13c5236`) **Refactor**: `RNIWrapperView` - Convert Config Bools to React Props
			* Convert "config" bool props to react props.
		- [x] (Commit: `e505737`) **Implement**: `RNIWrapperView.shouldCreateTouchHandlerForSubviews`.
		- [x] (Commit: `d058bf4`) **Implement**: `RNIWrapperView.shouldCreateTouchHandlerForParentView`.
		- [x] (Commit: `3e2857b`) **Implement** `RNIWrapperView.isDummyView` bool config.
		- [x] Task: Check if  `RNIWrapperView` cleans up — Inspect for memory leaks

			* Push screen and open all context menu that either has a custom menu preview, or aux. preview, and then inspect memory.
				* N0: `RNIWrapperView` count: 0
				* N1: `RNIWrapperView` count: 19
				* N2: `RNIWrapperView` count: 38
				* N3: `RNIWrapperView` count: 55
				* N0: `RNIWrapperView` count: 0 — Go back to home/root.
				* Result: After going to the root/home, no `RNIWrapperView` instance remained in memory.

		<br>

		- [x] (Commit: `b56d516`) **Implement**: `RNIWrapperView.shouldAutoDetachSubviews`
	
	<br>
	
	- [x] (Commit: `b7a2ece`) **Implement**: `detachedViews` lookup table.
	
	- [x] (Commit: `2b86b47`) **Implement** `RNIWrapperView.shouldDelayAutoCleanupOnJSUnmount`.

<br>

- [x] (Commit: `5ab2e0f`) **Fix**: Memory Leak - Property Animators Retain Cycle.

- [x] (Commit: `406362d`) **Fix**: Memory Leak - `UIAction` Retain Cycle.

- [x] (Commit: `8be7831`) **Implement** `ContextMenuView.shouldEnableAggressiveCleanup` prop. 

- [x] **Task**: Test all context menu items — Check if the `RNIWrapperView` refactor + `shouldEnableAggressiveCleanup` is causing any problems.

	* Push screen, test items, pop screen, test items, and so on...

	- [x] **Task**: Test all context menu view items in debug mode.
	- [x] **Task**: Test all context menu button items in debug mode.
	- [x] **Task**: Test all context menu view items in release mode.
	- [x] **Task**: Test all context menu button items in release mode.
	- [x] **Task**: Inspect for memory leaks.
		* Results: 13 `RNIWrapperView` instances retained by `RNIContextMenuView`, but no memory leaks or retain cycles found. 

<br>

- [x] (Commit: `57f817a`) **Example**: Deferred Menu Items - Add alt. usage (i.e. state controller menu config).
- [x] (Commit: `c015098`) **Implement**: Cleanup orphaned deferred menu items.
- [x] Implement: Deferred Menu Elements - Context Menu Button

	- [x] (Commit: `5c02acf`) Implement: `RNIContextMenuButtonModule`
	- [x] (Commit: `de54124`) Refactor:  `ContextMenuButton` - Migrate to Native Modules — Replace view manager commands with native modules.
	- [x] (Commit: `a7b71a3`) Remove: `ContextMenuButton` - View Manager Commands — Remove `RNIContextMenuButtonCommands`.
	- [x] (Commit: `dda3e14`) Implement: `RNIContextMenuButton` -  `provideDeferredElements`
	- [x] (Commit: `30a9179`) Implement: `ContextMenuButton.onRequestDeferredElement`
	- [x] (Commit: `26526d0`) Example: Context Menu Button - Add example for deferred Menu elements.

<br>

- [x] **Task**: Test all context menu items.

	- Push screen, test items, pop screen, test items, and so on...
		- Simulator: iPhone 8 - iOS 15.2
		- Device: iPhone XR

	<br>

	- [x] **Task**: Simulator - Debug — Test all context menu view example items.
	- [x] **Task**: Simulator - Debug — Test all context menu view test items.
	- [x] **Task**: Simulator - Debug — Test all context button items.
	- [x] **Task**: Post Test — Inspect memory.
		* Result: No memory leaks.

	<br>

	- [x] **Task**: Simulator - Release — Test all context menu view example items.
	- [x] **Task**: Simulator - Release — Test all context menu view test items.
	- [x] **Task**: Simulator - Release — Test all context button items.

	- [x] **Task**: Post Test — Inspect memory.

	<br>

	- [x] **Task**: Device - Debug — Test all context menu view example items.
	- [x] **Task**: Device - Debug — Test all context menu view test items.
	- [x] **Task**: Device - Debug — Test all context button items.

	- [x] **Task**: Post Test — Inspect memory.

	<br>

	- [x] **Task**: Device - Release — Test all context menu view example items.
	- [x] **Task**: Device - Release — Test all context menu view test items.

	- [x] **Task**: Device - Release — Test all context button items.

<br>

### Version: ` 1.10.1`

- [x] (Commit: `cecf70c`) **Bugfix**: Types - `MenuAuxiliaryPreviewTransitionConfig`
- [x] (Commit: `3451290`) **Bugfix**: Layout Bug - Aux. Preview Margin
	* Fix aux. preview going out of bounds when near edges.

<br>

- [x] (Commit: `ffae806`) **Bugfix**: Aux. Preview Exit Transition
	* Fix bug where the aux. preview's exit transition is not triggered when tapping the menu preview.

<br>

- [x] (Commit: `3451290`) **Bugfix**: Deferred Elements - Memory Leak
	* Trigger cleanup for deferred elements

### Version: `1.9.2`

TBA

<br>

### Version: `1.9.1`

TBA

<br>

### Version: `1.9.0`

TBA

<br>

### Version: `1.8.1`

TBA

<br>

### Version: `1.8.0`

<br>

- [x] (Commit: d764364) **Bugfix**: Aux. Preview-Related (WIP) —  Touch Event Conflict
  * Touch events originating from the context menu still propagates down the responder chain — in other words, the touch event passes through the context menu, so its like your touching the background in addition to the context menu.
  * As such,  if you try to trigger a button in the aux. preview, it will also close the context menu since touching on the background triggers the dismissal of the context menu.
  	* This can be confirmed by creating a simple `UIButton` and setting it as the aux. view for the context menu.
  	* The `UIButton` captures the touch event and does not propagate it further — as such, pressing the `UIButton` will not close the context menu.
  * The `TouchableOpacity` button in aux. preview still receives the touch event but `UIKit` is not aware that the touch event has already been handled.
  * Possible fix could be to add a vanilla view to hold the aux. preview — the vanilla view will stop the touch event from propagating at the expense of bloat and memory.
  	* Wrapping the aux. preview inside another `UIView` does not work.
  	* Wrapping the aux. preview inside another `UIButton` does not work.
  	* Wrapping the aux. preview inside another `UIControl` does not work.
  * Maybe try making a `UIView` subclass that stops the propagation of the touch event?
  	* Overriding `next:UIResponder` and `gestureRecognizerShouldBegin` in `RNIWrapperView` does nothing.
  	* Overriding `point(inside point: CGPoint, with event: UIEvent?)` in `RNIWrapperView` does nothing.
  * Setting `isExclusiveTouch` to `false` on the aux. view wrapper, the aux. view container, and the aux. view itself does nothing.
  * Setting `pointerEvents` prop to `box-none` or `none` for `RNIWrapperView` does nothing.
  	* But setting `pointerEvents` prop to `none` for the root view component returned from the `renderAuxillaryPreview`  prop does stop the propagation.
  	* However setting it to `box-none` does not stop the propagation and still closes the context menu. 
  	* This suggests that the problem lies with react native's touch system (i.e. `RCTTouchHandler`) not stopping the touch propagation.
  * Disabling `touchHandler.attach` in `RNIWrapperView.insertReactSubview` does not stop the propagation of the touch event.
  	* `RCTTouchHandler` is a subclass of `UIGestureRecognizer`.
  	* Setting `requiresExclusiveTouchType` to `true`/`false` does nothing.
  	* Setting `cancelsTouchesInView` to `true`/`false` does nothing.
  	* Becoming the delegate and handling the touch events (e.g. the `gestureRecognizer` methods) does nothing whether you choose to return `true`/`false`.
  		* Overriding `var next: UIResponder?` and returning `nil` does nothing.
  * A custom `UIView` subclass that wraps the aux. preview with `hitTest` override returning `nil` or `self` stops the propagation from happening.
  	* However the the context menu items, its preview + background, and the aux. preview no longer responds to the touch events — as such it's impossible to close the menu.
  * The simplest solution is to just create a dummy gesture recognizer (i.e. dummy because it does not have a selector) and attach it to the aux. preview — the dummy gesture recognizer will handle any bubbling touch events from the aux. preview and stop it from propagating.

<br>

- [x] (Commit: `9f682a1`) **Implement**: Aux. Preview-Related (WIP) — Remove `transitionConfigExit` from aux. preview config.
- [x] (Commit: `303cd6f`) **Implement**: Aux. Preview-Related (WIP) — Make `MenuAuxiliaryPreviewConfig.height` optional.
- [x] (Commit: `1432ce9`) **Implement:** Aux. Preview-Related (WIP) —  Infer aux. preview height from root view when `MenuAuxiliaryPreviewConfig.height` is `null`.
- [x] (Commit: `8b25e6f`) **Refactor**: Aux. Preview-Related (WIP) —  Isolate aux. preview constraints logic to closure block.
- [x] (Commit: `22109e2`) **Implement**: Aux. Preview-Related (WIP) — Impl. logic for determining the aux. preview width.
- [x] (Commit: `a9651e3`) **Implement**: Aux. Preview-Related (WIP) — Adjust aux. preview width, i.e. re-impl. fix for sizing + layout bug.
- [x] (Commit: `562672d`) **Implement**: Aux. Preview-Related (WIP) — Update logic for aux. preview horizontal alignment, e.g. `previewTrailing`, `previewCenter`, and `stretchScreen`.
- [x] (Commit: `5cb72f5`) **Implement**: Example — Add env. flag for enabling/disabling `react-navigation`.
- [x] (Commit: `75e722e`) **Bugfix**: Re-Enable cleanup for context menu button.

<br>

- [x] (Commit: `75e722e`) **Bugfix**: Re-Enable cleanup for Context Menu Button.

<br>

### Version: `1.7.6`

- [x] (Commit: `0c7a91d`) **Test**: Example — Add test for react navigation tabs
- [x] (Commit: `5092dab`) **Bugfix**: Fix + re-enable cleanup logic
- [x] (Commit: `110dfe4`) **Refactor**: Fix iOS 16 deprecations 

<br>

### Version: `1.7.5`

- [x] (Commit: `cde5061`) **Bugfix**: Context menu auxiliary preview not sizing properly in yoga layout
	* Layout-Related Bug: The auxiliary preview is sized properly via  autolayout (confirmed via setting the background color of the view), but react-native uses the "old size" of the view, i.e. before it was resized via autolayout (e.g. the children of the view will act as if the view's size hasn't changed yet) — In other words, react-native is not aware of the new size of the view.
	* Attempts to fix:

		* **A**. Updating the size via `uiManager.setSize` works, but causes a temporary layout bug where the aux. preview gets pinned towards the top left part of the screen.
			* Likely due to the aux. view using it's parent view as the basis for it's layout — i.e. the parent view (`RNIWrapperView`) has a style of absolute positioning so it doesn't interfere with layout.
			* The layout position bug disappears when the context menu preview's position changes (e.g. via dragging the preview) — this likely due to autolayout triggering a layout update to its subviews when you start moving the preview around.
			* Unfortunately, manually triggering `layoutSubviews` method on the context menu preview (i.e. `morphingPlatterView`) does not fix the layout position bug.
			* Triggering `layoutSubviews` on the aux. preview also does not fix the  layout position bug.
			* Toggling `RNIWrapperView.autoSetSizeOnLayout` does nothing.
			* Triggering `UIManger.setNeedsLayout` does nothing.
			* Triggering `uiManager.setSize  ` at a later time (e.g. after the fade in transition) does nothing.
		* **B**. Updating the aux. view's size via it's shadow view's width and height does nothing (i.e. changing the yoga value for the its width and height does nothing, even after calling `UIManger.setNeedsLayout`).
			* Removing the shadow view for both the aux. view and it's wrapper does nothing and causes layout problems.
		* **C**. As a last resort, a possible temp. solution is to just manually change the size of the aux. view via the style prop in the JS side. This can be done via an event that gets triggered from the native side, whenever we want to change the size of the view.
		* **D**. It turns out, the reason for the aux. preview layout bug is due to the new size being too big — i.e. the new size for the aux. preview is bigger than it's current size, causing it to "overflow" and glitch.

<br>

### Version: `1.7.2`

- [x] **Bugfix**: Android error (importing/use of iOS-related native components on non-iOS platforms).
	- [x] (Commit: `ba00412`) Revert platform-specific extensions for `ContextMenuView`, and `ContextMenuButton`.
	- [x] (Commit: `5fe92e8`) Use platform specific exports for native components (i.e. `RNIContextMenuView`,  `RNIContextMenuButton`).

<br>

- [x] (Commit: `756514b`) **Implement**: Impl. `ContextMenuButton.dismissMenu`.

<br>

### Version: `1.7.1`

- [x] **Bugfix**: Android error (importing/use of iOS-related native components on non-iOS platforms).
	- [x] (Commit: `e57aabe`) Refactor `ContextMenuView` to use platform-specific extensions.
	- [x] (Commit: `0acea05`) Refactor `ContextMenuButton` to use platform-specific extensions.

<br>

### Version: `1.7.0`

- [x]  (Commit: `6b606da`) **Implement**: Impl. `ContextMenuView.isContextMenuEnabled` prop.

<br>

### Version: `1.6.2`

- [x] (Commit: `ce8dbac`) **Refactor**: Add compiler directives to support building using Xcode 12.

<br>

### Version: `1.6.1`

- [x] (Commit: `ca30678`) **Clenaup**: Remove `RNIMenuIcon.ImageLoader` 
	* Fix build error due to `RCTImageCache`.

<br>

- [x] Fix example not building when using "Release" configuration. 
	* (Commit: `ca30678`) **Cleanup**: Remove `RNIMenuIcon.ImageLoader`.
	* (Commit: `78a7e51`) **Refactor**: Example - Rename `index.js` to `index.ts`
	* (Commit: `8258328`) **Implement**: Create `.nvmrc` — Use specific node version.
	* (Commit: `9f6f895`) **Implement**: Update `build-ios.yml` to use `.nvmrc` for node version.

<br>

### Version: `1.6.0`

- [x] (Commit: `2c55fdb`) **Implement**: Implement `ContextMenuViewContext`
- [x] (Commit: `05f6c73`) **Implement**: Implement `useMenuContext` hook.
- [x] **Refactor**: Update example to use typescript.
	* Commits: `7ec95a5`, `51a50f6`, `2e3c05a`, `104d36d`, `b84a0db`, `73ff6f1`, `be6d40e`, `3bc8e2a`, `491874d`, `9596954`, `080d44f`, `497f032`, `de1f93c`, `e745dda`, `7b0c4f1`, `e714a1f`, `6483c79`, `447dd2b`, `ecd96fc`, `78a9c10`, `96877c2`, `bb3fff9`, `aea43db`, `0c5436a`, `ee446c3`, `bdee609`, `e3846d7`, `827f0bb`.

<br>

- [x] (Commit: `7045e61`) **Bugfix**: Fix types — Make `menuConfig` prop optional.
- [x] (Commit: `2310b7e`) **Bugfix**: Fix types — Fix wrong type for `MenuConfig.menuAttributes`.
- [x] (Commit: `52c0459`) **Bugfix**: Fix library exports — Export types from `MenuEvents`.
- [x] (Commit: `9f4e332`) **Refactor**: Remove `ContextMenuButton.wrapNativeComponent` Prop.
- [x] (Commit: `9caf7d7`) **Implement**: Implement `ContextMenuButtonContext`.
- [x] (Commit: `4d063f9`) **Implement**: Implement `useMenuButtonContext` hook.

<br>

### Version: `1.5.0`

- [x] **Bugfix**: Fix memory leak
	* (Commit: `6ddabae`) Partially fix memory leak by performing cleanup during reload + when the view is unmounted. 
	* (Commit: `19533b2`) Use `RNIWrapperView` for the menu preview.
	* (Commit: `c45c576`) Fix menu preview memory leak,

<br>

- [x] (Commit: `4c75563`) **Bugfix**: Fix menu action subtitles no longer working on iOS 15.

	* Example #13 — Setting `discoverabilityTitle` no longer does anything.

	- In iOS 13, this used to show a subtitle blurb below the menu item title. In iOS 15, it no longer displays the subtitle.
	- In iOS 15, there's a new property added called `UIMenuElement.subtitle`.

<br>

- [x] **Refactor**: Update to use `RNIImageItem` for the menu icons.
	* Update logic for handling images.
		* Copy over `RNIImageItem` impl. from `react-native-ios-navigator`.
		* Rename `IconConfig` type to  `IconConfigDeprecated`.
		* Make the `icon` property accept both `IconConfigDeprecated` and `ImageItemConfig`.
		* Then in native, map `IconConfigDeprecated` to `ImageItemConfig`.
		* Then use `RNIImageItem` to create the icon images for the context menu.
		* Import `RNIImageItem` and update `RCTMenuIcon` to use it.
	* (Commit: `836f0a3`) Copy over `RNIImageItem` impl. from `react-native-ios-navigator`.
	* (Commit: `97fa40c`) Refactor to use `RNIImageItem` for menu item icon.
	* (Commit: `e02d96e`) Copy over `ImageItemConfig` types from `react-native-ios-navigator`.
	* (Commit: `e176438`) Update types for menu config to accept `ImageItemConfig`.

<br>

### Version: `1.4.0`

- [x] (Commit: `a0b008c`) Migrate project to use the new template generated by `create-react-native-library` and `react-native-builder-bob`.
	* Example app no longer builds, but the library still works when installed on a newly created react-native app. The example project may be incompatible with Xcode 13.1.
	* After migrating the project to the new template, the example app now builds + run on iOS 15.

<br>

- [x] (Commit: `d1c8277`) **Sync**: Update `UIColor+Helpers.swift`  to use the newer code in `react-native-ios-context-menu`.
- [x] (Commit: `59d4faf`) **Refactor**: Migrate `Extension+Init`-related types to use failable initializers instead of static functions.
- [x] (Commit: `7bb8148`) **Cleanup**: Update `MARK` comments in native code.
- [x] (Commit: `873b61a`) **Cleanup**: Cleanup swift types (e.g. `NSString` -> `String`).
- [x] (Commit: `ebfa1cc`) **Cleanup**: Remove `RCTSwiftLog` + usage.
- [x] (Commit: `3702dfc`) **Refactor**: Replace `RCT` prefix with `RNI`.
- [x] (Commit: `2102840`) **Refactor**: Extract `RNIContextMenuView` native component to its own separate file.
- [x] (Commit: `3fb4faa`) **Refactor**: Extract `RNIContextMenuButton` native component to its own separate file.
- [x] (Commit: `023f8e7`) **Implement**: Types — Add type declaration for `MenuConfig` and related types.
- [x] (Commit: `6768b32`) **Implement**: Types — Add type declaration for `MenuPreviewConfig` and related types.
- [x] (Commit: `01089f0`) **Implement**: Types — Add type declaration for `IconConfig` and related types.
- [x] (Commit: `0d71080`) **Refactor**: Extract constants (e.g. `isContextMenuButtonSupported`, `isContextMenuViewSupported`) to their own separate file.

<br>

* **Implement**: Types — Add type declaration for `ContextMenuView`
	- [x] (Commit: `8c72054`) **Implement**: Types — Migrate `ContextMenuView` component to use typescript and partially added type declarations.
	- [x] (Commit: `348d2f9`) **Implement**: Types — Add type declaration for `ContextMenuView`  events.

<br>

- [ ] (Commit: `e0bc64f`) **Implement**: Types —  Add type declaration for `ContextMenuButton` 
- [ ] (Commit: `25bf0b2`) **Implement**: Types — Partially add type declaration for `ActionSheetFallback` 
- [ ] (Commit: `47a97bc`) **Implement**: Types — Add type declaration for `Helpers`

---

<br>

## Archived/Abandoned

- [ ] **Cleanup**: Remove print logs.

<br>

- [ ] **Docs**: Update documentation sections
  * Remove numbered subsections.

  * Move links to files out of the section title.
  * Temporarily strip out links to section (i.e. replace with `PLACEHOLDER_LINK`).
  * Add versions table.
  * Remove collapsable sections.

<br>

- [ ] **Implement**: Add support for targeted previews on text (i.e. similar to safari). 
- [ ] **Implement**: Subscribe to `ContextMenuView` events via event emitter from context.

<br>

- [ ] **Task**: Read apple documentation to find any new changes added.

- [ ] **Refactor**: Make classes public and accessible outside the library.

  <br>

- [ ] **Refactor**: Extract types/components from `RNIWrapperView` to separate files.

- [ ] **Docs**: Add documentation for "Context Menu Preview Auxiliary View".

- [ ] **Refactor**: Move event-related types to their respective files where they're first used.

- [ ] **Refactor**: Update Access Modifiers for Classes/Structs — Make classes/structs public so they can be imported by other code.

- [ ] **Docs**: Update version history.

- [ ] **Refactor**: Use `react-native-ios-utilities`. 

<br>

- [ ] **Test**: Try to re-produce the bug where the context menu no longer works after a certain period of time

  * React Native Version: `0.63.4`

  * Hide app, wait 1 minute,  reopen app, then test context menu
    * Test on production mode + simulator: OK
    * Test on production mode + Debug Off + simulator: OK
    * Test on Production + No Xcode + Simulator: OK

  * Hide app, open contacts, wait 1 minute, reopen app, then test context menu
    * Test on production mode + simulator: OK
      * Test  on production mode + Debug Off + simulator: OK
      * Test on Production + No Xcode + Simulator: OK

<br>

- [ ] **Bugfix**: Running on device + production crashes immediately when context menu is invoked.
  * Might be a problem with Xcode beta — Running on iOS 16 simulator works fine on both production mode and debug mode.
  * Xcode beta + running on device (iPhone XR + iOS 15.1) causes crashes when the context menu is being created (i.e. `UIContextMenuConfiguration`).
  * Xcode 13 + running on device (iPhone XR + iOS 15.1) works fine.
  * Maybe the constructor for `UIContextMenuConfiguration` was changed?
    * Still crashes when `nil` is provided as an argument to all the parameters in the constructor.
    * Using the constructor that takes no arguments doesn't trigger a crash.

<br>

- [ ] **Implement**: Provide a default config for `previewConfig` when a `renderPreview` prop is given a value so that there's a default behavior.
- [ ] Expose `location(in:)`
- [ ] Implement: Re-write image loading logic for `IMAGE_REQUIRE`.
  * Move image loading in the background.
  * Add option for: lazy loading.
  * Add option for: synchronous loading.
  * Add option for: image caching.

<br>

- [ ] Implement: iOS 16

  - [ ] `UIMenuLeaf`
  - [ ] Maybe: `UIEditMenu`

<br>

- [ ] **Refactor**: Fabric re-write

  - [ ] **Task**: Create a test library — Playground for making a C++ turbo native module.

    - [x] **Task**: Figure out how to install `react-native-codegen`.

      * **Note**: For some weird reason, spaces and special characters in the working directory results in the CLI not finding the module location.

    - [x] **Task**: Figure out how to setup "code gen" in the library package, i.e. `codegenConfig`.

    - [x] **Task**: Create a turbo native module function.

      * Run the codegen script: `node ./example/node_modules/react-native/scripts/generate-artifacts.js --path ./example --outputPath ./example/ios`
        * Error: `[Codegen] >>>>> Searching for codegen-enabled libraries in react-native.config.js`
          * `Cannot find module 'example/react-native.config.js'` — The react-native codegen script cannot locate the `react-native.config.js` file.
          * The `example/react-native.config.js` file exists. Could this be a bug?
          * The `example/node_modules/react-native/scripts/generate-artifacts.js` executes  `example/node_modules/react-native/scripts/codegen/generate-artifacts-executor.js`
          * Line 219: `const rnConfigFilePath = path.join(appRootDir, rnConfigFileName);` — change `path.join` to `path.resolve`, i.e. `const rnConfigFilePath = path.resolve(appRootDir, rnConfigFileName);`.
          * Script now runs. It now generates a `build/generated/ios` directory containing the dependencies for fabric + turbomodules, as well as c++ artifact generated from our js spec — i.e. `RNIosCxxTestSpec`.
            * The directory contains a header file: `RNIosCxxTestSpec.h`, and an impl. file: `RNIosCxxTestSpec-generated.mm`.

      - Build Error: No member named `RNIosCxxTestSpec` in namespace `facebook::react`

        * The corresponding module spec in `React-Codegen` was created properly.

        * Could possibly be a naming issue?

          * The js module file is named: `NativeIosCxxTest` — it follows the `Native<MODULE_NAME>` naming convention.
          * The module is named: `IosCxxTest`

        * Fixed by importing the codegen module header, e.g.: `#import <RNIosCxxTestSpec/RNIosCxxTestSpec.h>`.

        * `RCT_EXPORT_MODULE` —  The `getTurboModule` function expects an instance of `facebook::react::TurboModule`. 

          * In this function, we must return the corresponding `RCTTurboModule` instance generated via codegen based on our JS spec.
          * For this project, it is in `React-Codegen/RNIosCxxTestSpec`.

          

    - [ ] **Task**: Call swif

    - [ ] **Task**: Make TNM function iOS-only

      *  What is the best way to do this? One way is to create a dummy no-op/empty implementation for android.
         * What happens when there is a mismatch with the TNM declaration between iOS and Android? 
         * Will the "codegen" CLI care if the "autolinking" configuration is set to only support iOS? In other words, if we set the library to only "autolink" on the iOS platform, will the project importing the library ignore the "codegen" for android side, and not compile it.

<br>

- [ ] **Cleanup**: <u>Breaking Change</u> — Remove legacy support for icon config shorthand/shortcut that was added temporarily when migrating between an older version of this library.
- [ ] **Refactor**: `findNodeHandle` has been deprecated due to fabric support.

<br>

- [ ] Docs: In the `MenuAction` Object section, add example object with comments.
- [ ] Docs: In the `MenuConfig` Object section, add example object with comments.
- [ ] Docs: Create collapsable "Table of Contents"
- [ ] Docs: Add `README.md` in example directory

<br>

- [ ] `ContextMenuButton`: Add `SystemImage` component for creating a `UIImage` that uses SF Icons (Research first if the built-in image component already supports this).
- [ ] `ContextMenuButton`: Add example for `wrapNativeComponent` prop, i.e. example for using a different "button" component.

<br>

- [ ] `ContextMenuView`: Custom Preview - Add support for setting an image as the custom preview. Use the built-in `Image` react native component to handle setting the image source + sizing. Receive the image as a child from `RCTContextMenuView` and cast it to `RCTImage` if necessary. The image will then be wrapped inside a view controller and is set as the `UIMenu`'s preview target. The view should be resized to fit the screen.

<br>

- [ ] Test: `ContextMenuView` and `ContextMenuButton` on different react native versions
	- [ ] Test on **0.60**
	- [ ] Test on **0.61**
	- [ ] Test on **0.62**
	- [x] Test on **0.63.3**
	- [x] Test on **0.63.4**
- [ ] Test: `react-native-context-menu` uses autolinking for installation. Check if this library will work on older react-native versions prior to 0.60 i.e test `ContextMenuView` and `ContextMenuButton` on react native versions older than 0.60
	- [ ] Test on **0.59**
	- [ ] Test on **0.58**

<br>

- [ ] Submit a PR to the RN repo — Update RN template to fix `Undefined Symbol`
- [ ] Update `PreviewConfig.previewSize` to support passing in a size object, e.g. `{width: 100, height: 100}`
- [ ] Docs: Fix grammar/spelling errors
- [ ] Docs: Test/Fix jump links
- [ ] Attach RN touch handler to context menu
- [ ] Impl. support for icon weight

<br>

- [ ] Implement: `ActionSheetModule` to display an "Action Sheet" menu via [`UIAlertController`](https://developer.apple.com/documentation/uikit/uialertcontroller).

	* **Reference**: [Article](https://developer.apple.com/documentation/uikit/windows_and_screens/getting_the_user_s_attention_with_alerts_and_action_sheets) in the apple developer about "Alerts and Action Sheets"

	* **Reference**: [￼`ActionSheetIOS`￼](https://github.com/facebook/react-native/blob/9c353b5ab060be9392a7aaf437bba4ffc56d78ca/Libraries/ActionSheetIOS/ActionSheetIOS.js) JS code. The native module is called `RCTActionSheetManager`  ([link](https://github.com/facebook/react-native/blob/9c353b5ab060be9392a7aaf437bba4ffc56d78ca/Libraries/ActionSheetIOS/NativeActionSheetManager.js) to JS native module, and [link](https://github.com/facebook/react-native/blob/9c353b5ab060be9392a7aaf437bba4ffc56d78ca/React/CoreModules/RCTActionSheetManager.mm) to native code)

	* **Reference**: [@react-native-menu/menu](https://github.com/react-native-menu/menu) library has a very good looking `ActionSheet` fallback with icons and disabled menu actions. 

<br>

- [ ] `ContextMenu` : Add support for `UIDefferedElement`

	* In `MenuConfig.menuItems` property or in the `menuConfig` prop, if an object has a property called `defferedKey`, then it means we want to create a `UIDefferedElement` element.

	* Impl. `onRequestDefferedElement` function. This function is called whenever a `UIDefferedElement` item needs to be loaded.
		* This function will receive a `defferedKey`. This function must return a promise, i.e. either a `MenuConfig` or `MenuAction` object. 
		* If the returned promise is a `MenuAction` object, it will use `defferedKey` for the `actionKey` property.
		* In this function, based on the `defferedKey` it must return a corresponding `MenuConfig`/`MenuAction` object. If `null` is returned, then it means it failed.
		* This function is invoked from the native side. Native UI component `NativeCommands` don't natively support promises, so a workaround must be used based on `request` callbacks (like the one i used on `react-native-ios-modal`). But `NativeModule` functions has support for proimises built in. 
			* We can use `findNodeHandle(this.nativeCompRef)` to get a node handle. Then we can use `self.bridge.uiManager.view(forReactTag: node)` to get a ref to the component. Then we cast it to the correct type: `component as? RCTContextMenuView` and then call the completion function for the corresponding `UIDefferedElement`,  something like: `contextMenuView.resolveDefferedMenuElement(for: defferedKey, item: menuElementDict)`
		* We need to create a class to create a `UIDeferredMenuElement`. It will extend `RNIMenuElement` and can be init from a dictionary. Probably name it something like: `RCTMenuDefferedItem`. It will have one property: `defferedKey`
			* `RNIMenuItem.createMenu` function must be updated to also handle creating a `RCTMenuDefferedItem` item.
		* On the native side when we create a `UIDeferredMenuElement` we do this:  `UIDeferredMenuElement { completion in self.completionDict[defferedKey] = completion }`, and then invoke a RN event: `self.onRequestDefferedElement([defferedKey: defferedKey])`.
			* `onRequestDefferedElement` event prop will be invoked. We wait for the promise to return some value and then call  a `NativeModule` function.
			* The `NativeModule` function will probably look like this: `ContextMenuViewModule.resolveDefferedMenuElement({nodeHandle, defferedKey, menuItem});`
			* Completion handlers will be stored in a dictionary. I'm not sure if I can use `NSMapTable`. I can use a plain `NSDictionary` but if I accidentally forget to cleanup (i.e. remove the completion handler from the dict) then that completion handler will be retained, causing a memory leak.
				* Completion handlers, i.e. closures, are reference types. If I assign it to `NSMapTable` with `valueOptions: .weakMemory`, will it be automatically be released when it's no longer used? Will it be retained while it's in use or will it be released the moment i add it to `NSMapTable` because nothing is using it? Technically, it is in use because it's in `UIDeferredMenuElement` argument (so the ref count  should increase?)

<br>

- [ ] **Refactor**: Use structs instead of classes for holding configuration for making the menu items.
	* Cannot be completed due to protocol class requirement.

---

<br><br>

## Completed Archive

- [x] Docs: First remove all the links that point to the examples directory or links to different section. Highlight them in yellow then replace the highlighted text in the documentation with the new/updated section/examples links.
	- [x] Move `ContextMenuView` examples + tests in `examples/src` to `examples/src/ContextMenuView` then update documentation links
	- [x] In the "Examples" section add section for `ContextMenuView` and `ContextMenuButton`, then update the documentation "jump to" heading links
	- [x] Update and rename Images/Gifs
		- [x] Move gifs for `ContextMenuView` in `/assets` to `assets/ContextMenuView/`
		- [x] Rename `ContextMenuView` gifs i.e. prefix them with "ContextMenuView" e.g. `SimpleExample-1-2-3-4.gif` becomes `ContextMenuView-SimpleExample-1-2-3-4.gif`, etc.
		- [x] In the `/assets/example-screenshots` folder, prefix images with "ContextMenuView", e.g. `SimpleExample01.png` becomes `ContextMenuView-SimpleExample01.png`, etc.
- [x] Docs: Add images to steps: Undefined Symbol
- [x] Docs: Make sections collapsabe
- [x] Docs: Fix table layout
- [x] In the "Documentation" section, add `ContextMenuButton` props.
- [x] Finish `onPressMenuItem` `nativeEvent` Object section.
- [x] Add section for `useActionSheetFallback` prop.

<br>

- [x] `ContextMenuView`: Export `ActionSheetFallback` function and add it to the docs.
- [x] `ContextMenuView`: Rename `RCTContextMenuManager` to `RCTContextMenuViewManager` and update corresponding js native component
- [x] `ContextMenuView`: Impl. iOS 14 specific feature: `UpdateVisibleMenu`
- [x] `ContextMenuView`:  Impl. iOS 14 specific feature: `dismissMenu`
	* Try implementing this via `NativeModule`

- [x] `ContextMenuView`: Custom Preview - Add support for custom previews, i.e by passing a child component to `RCTContextMenuView`, and wrapping that child inside a view controller and passing it as the preview target in `UIMenu` config. The first child of the `RCTContextMenuView` will be reserved for the custom menu preview. If no child is passed, i.e no custom preview is configured, then the preview target is not set for the `UIMenu`. The preview view should only be mounted when the menu is visible, and thus, it should support setting the preferred size of the preview target. Test if the preview target can be changed when it's already visible.

<br>

- [x] `ContextMenuButton`: Finish initial impl. with 1 working simple example
- [x] `ContextMenuButton`: Add documentation for `ContextMenuButton`

<br>

- [x] General: Implement targeted previews
- [x] General: Implement tinted/colored menu icons + config for line weight etc.
- [x] Refactor: Change "ImageType" to "IconType", and "imageValue" to "imageType"
- [x] General: Move menu icon related properties to "icon": `{ icon: { iconType: '', iconValue: '', tint: ''} }` 
- [x] `ContextMenu` — Add `discoverabilityTitle` to `UIAction`

<br>


- [x] Implement `ImageType.ASSET` to support: "create an image from an image asset or image file located in your app’s main bundle"
	* The `imageValue` string from `MenuAction`/`MenuConfig` will be used to init a `UIImage`, like: `UIImage(named: imageValue)`

<br>

- [x] Implement `ImageType.REQUIRE` to support using images via `require(path/to/image)`

	* One way to implement is to use `Image.resolveAssetSource(source);` from the RN [docs](https://reactnative.dev/docs/image#resolveassetsource). So we have something like: `{ imageType: 'REQUIRE', imageValue: require('path/to/image.png') }`. 
		* **Reference**: [Medium Article](https://medium.com/swlh/how-to-obtain-a-uri-for-an-image-asset-in-react-native-with-expo-88dfbe1023b8). Explains how `Image.resolveAssetSource` works.

	* Attempted to impl. this but ran into problems: when in debug mode, assets are provided via a local URL via the metro bundler.

