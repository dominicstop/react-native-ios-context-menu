# TODO

See [TODO-Archive](./TODO-Archive.md) for the old completed tasks + version history.

<br>

- [ ] **Refactor**: Use structs instead of classes for holding configuration for making the menu items.

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

- [ ] Read apple documentation to find any new changes added.

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





## Uncategorized/WIP

- [ ] Implement: iOS 16

  - [ ] `UIMenuLeaf`
  - [ ] Maybe: `UIEditMenu`




---

<br><br>

## For Next Major Version

- [ ] **Cleanup**: <u>Breaking Change</u> — Remove legacy support for icon config shorthand/shortcut that was added temporarily when migrating between an older version of this library.
- [ ] **Refactor**: `findNodeHandle` has been deprecated due to fabric support.

---

<br>

## Completed

### Version: `next`