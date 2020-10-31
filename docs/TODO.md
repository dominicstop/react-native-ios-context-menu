# TODO

## General
- [ ] `ContextMenu` — Add support for `UIDefferedElement`
- [ ] Test `ContextMenuView` and `ContextMenuButton` on different react native versions
	- [ ] Test on **0.60**
	- [ ] Test on **0.61**
	- [ ] Test on **0.62**
	- [ ] Test on **0.63**
- [ ] `react-native-context-menu` uses autolinking for installation. Checki if this library will work on older react-native versions prior to 0.60 i.e test `ContextMenuView` and `ContextMenuButton` on react native versions older than 0.60
	- [ ] Test on **0.59**
	- [ ] Test on **0.58**

<br>

## `ContextMenuView`
- [ ] ⭐️ Export `ActionSheetFallback` function and add it to the docs.
- [ ] 🛠 Rename `RCTContextMenuManager` to `RCTContextMenuViewManager` and update corresponding js native component
- [ ] ⭐️ Impl. iOS 14 specific feature: `UpdateVisibleMenu`
- [ ] ⭐️ Impl. iOS 14 specific feature: `dismissMenu`
- [ ] ⭐️ Custom Preview - Add support for custom previews, i.e by passing a child component to `RCTContextMenuView`, and wrapping that child inside a view controller and passing it as the preview target in `UIMenu` config. The first child of the `RCTContextMenuView` will be reserved for the custom menu preview. If no child is passed, i.e no custom preview is configured, then the preview target is not set for the `UIMenu`. The preview view should only be mounted when the menu is visible, and thus, it should support setting the preferred size of the preview target. Test if the preview target can be changed when it's already visible.
	- [ ] ⭐️ Custom Preview - Add support for setting an image as the custom preview. Use the built-in `Image` react native component to handle setting the image source + sizing. Receive the image as a child from `RCTContextMenuView` and cast it to `RCTImage` if necessary. The image will then be wrapped inside a view controller and is set as the `UIMenu`'s preview target. The view should be resized to fit the screen.

<br>

## `ContextMenuButton`
- [x] Finish initial impl. with 1 working simple example
- [ ] Add documentation for `ContextMenuButton`
- [ ] Add `SystemImage` component for creating a `UIImage` that uses SF Icons (Research first if the built-in image component already supports this).

<br>

## Documentation
- [x] First remove all the links that point to the examples directory or links to different section. Highlight them in yellow then replace the highlighted text in the documentation with the new/updated section/examples links.
	- [x] Move `ContextMenuView` examples + tests in `examples/src` to `examples/src/ContextMenuView` then update documentation links
	- [ ] In the "Examples" section add section for `ContextMenuView` and `ContextMenuButton`, then update the documentation "jump to" heading links
	- [x] Update and rename Images/Gifs
		- [x] Move gifs for `ContextMenuView` in `/assets` to `assets/ContextMenuView/`
		- [x] Rename `ContextMenuView` gifs i.e. prefix them with "ContextMenuView" e.g. `SimpleExample-1-2-3-4.gif` becomes `ContextMenuView-SimpleExample-1-2-3-4.gif`, etc.
		- [x] In the `/assets/example-screenshots` folder, prefix images with "ContextMenuView", e.g. `SimpleExample01.png` becomes `ContextMenuView-SimpleExample01.png`, etc.

- [x] In the "Documentation" section, add `ContextMenuButton` props.
- [ ] In the `MenuAction` Object section, add example object with comments.
- [ ] In the `MenuConfig` Object section, add example object with comments.
- [ ] Finish `onPressMenuItem` `nativeEvent` Object section.
- [ ] Create collapsable "Table of Contents"
- [ ] Make examples content collapsable
- [x] Add section for `useActionSheetFallback` prop
- [ ] Add `README.md` in example directory