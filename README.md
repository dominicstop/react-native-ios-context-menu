# react-native-ios-context-menu

<p>
  <img src="https://github.com/dominicstop/react-native-ios-context-menu/workflows/Build%20Example/badge.svg" />
</p>

<br>

## 🚧⚠️ Library + Documentation Re-Write WIP ⚠️🚧

📝 Check [`TODO.md`](docs/TODO.md) for progress on re-write.

* ❤️ Support the new API's introduced in iOS 15.
* 🧡 New `SFSymbols` + menu icon config API.
* 💛 Support for use with [Mac Catalyst](https://developer.apple.com/documentation/uikit/uicommand/adding_menus_and_shortcuts_to_the_menu_bar_and_user_interface) (e.g. configuring the mac's menu bar + the iPad's [shortcuts/menu bar](https://twitter.com/stroughtonsmith/status/1440344820577226752?s=20)). 
* 💚 Typescript re-write (for better autocomplete).
* 💙 Documentation re-write (so its actually usable + better examples).
* 💜 ...and fixing all the bugs + issues so far 😅

<br>

- The documentation is incomplete (some parts/sections are marked as **TBA** i.e. "to be added"). 
- Some of the links in the documentation are broken (i.e. the URL points to `PLACE_HOLDER_LINK`).
- For now, please see the [Usage And Examples](#e-usage-and-examples) section for information on how to use this library.

<br>

<br>

| Notice                                                       |
| ------------------------------------------------------------ |
| 📝 **Note** #1: A future major version of this library will introduce breaking changes to the API (mainly just renaming some of the properties) in order to add new features (and better types). <br><br>However, the next minor version of this library will not introduce any breaking changes but will instead focus on adding typescript annotations and fixing the existing bugs. |
| 📝 **Note** #2: The documentation + examples are currently being rewritten.<br><br>💅 [`README-old.md`](./README-old.md) — The old version of the documentation (archived).<br>💖 [`example/src/examples`](./example/src/examples) — The typescript rewrite of the examples (WIP). |

 <br>

### Versions

| Library Version | Compatibility                 |
| :-------------- | ----------------------------- |
| `1.6.2`         | iOS 10 to iOS 15<br>Xcode 12+ |
| `1.4`           | iOS 10 to iOS 15<br>Xcode 13+ |
| `1.3` and Below | iOS 10 to 14<br>Xcode 12+     |

📝 **Note**: Supports projects targeting iOS 10 but will use the action sheet fallback when running on iOS 12 and older.

<br><br>

## A. Introduction

A react native component to use [`UIMenu`](https://developer.apple.com/documentation/uikit/uimenu) on iOS 13 and later.

<br>

### A.1. Gifs and Demos

📝 **Note**: These gifs are from an older version of the library running on iOS 13 (see [Usage And Examples](#e-usage-and-examples) section for updated example gifs).<br>

`ContextMenuView` Examples, **Left**: [Example 1](#ContextMenuView-Example-01), [Example 2](#ContextMenuView-Example-02), and **Right**: [Example 3](#ContextMenuView-Example-03), [Example 4](#ContextMenuView-Example-04)
![Simple Example 1 to 4 Gifs](./assets/montage-ContextMenuView-Example-old-1-2-3-4.gif)

`ContextMenuView` examples, **Left**: [Example 5](#ContextMenuView-Example-05), [Example 6](#ContextMenuView-Example-06), and **Right**: [Example 7](#ContextMenuView-Example-07), [Example 8](#ContextMenuView-Example-08)
![Simple Example 5 to 8 Gifs](./assets/montage-ContextMenuView-Example-old-5-6-7-8.gif)

`ContextMenuView` example, **Left**: [Example 9](#ContextMenuView-Example-09), and **Right**: [Example 10](#ContextMenuView-Example-10)
![Simple Example 9 and 8 Gifs](./assets/montage-ContextMenuView-Example-old-9-10.gif)

`ContextMenuView` examples, **Left**: [Example 11](#ContextMenuView-Example-11), [Example 12](#ContextMenuView-Example-12), and **Right**: [Example 13](#ContextMenuView-Example-13), [	Example 14](#ContextMenuView-Example-14)
![Simple Example 11 to 14 Gifs](./assets/montage-ContextMenuView-Example-old-11-12-13-14.gif)

`ContextMenuView` examples, **Left**: [Example 15](#ContextMenuView-Example-15), [Example 16](#ContextMenuView-Example-16), and **Right**: [Example 17](#ContextMenuView-Example-17), [Example 18](#ContextMenuView-Example-18)
![Simple Example 11 to 14 Gifs](./assets/montage-ContextMenuView-Example-old-15-16-17-18.gif)

`ContextMenuView` tests, **Left**: [Test 1](PLACE_HOLDER_LINK), and **Right**: [Test 2](PLACE_HOLDER_LINK)
![Context Menu View Test 1 and 2 Gifs](./assets/montage-ContextMenuView-Test-old-01-02.gif)

`ContextMenuView` tests, **Left**: [Test 3](PLACE_HOLDER_LINK), and **Right**: [Test 4](PLACE_HOLDER_LINK)
![Context Menu View Test 3 and 4 Gifs](./assets/montage-ContextMenuView-Test-old-03-04.gif)

`ContextMenuView` tests, **Left**: [Test 5](PLACE_HOLDER_LINK), and **Right**: [Test 6](PLACE_HOLDER_LINK)
![Context Menu View Test 5 and 6 Gifs](./assets/montage-ContextMenuView-Test-old-05-06.gif)

`ContextMenuView` tests, **Left/Right:** [Test 7](PLACE_HOLDER_LINK)
![Context Menu View 7 Gifs](./assets/montage-ContextMenuView-Test-old-07.gif)

`ContextMenuView` `ActionSheetIOS` fallback for simple example 1 to 9
![Action Sheet Fallback for Simple Example 1 to 9 Gifs](./assets/montage-ContextMenuView-ActionSheetFallback-Example-old-1-to-9.gif)

`ContextMenuView` `ActionSheetIOS` fallback for context menu view test 1 to 6
![Action Sheet Fallback for Context Menu View Test 1 to 6 Gifs](./assets/montage-ContextMenuView-ActionSheetFallback-Test-old-1-to-6.gif)

`ContextMenuButton` examples, **Left**: [Example 1](#ContextMenuButton-Example-01), and **Right**: [Example 2](#ContextMenuButton-Example-02)
![Simple Example 1 and 2 Gifs](./assets/montage-ContextMenuButton-Example-old-1-2.gif)

<br>

### A.2. Feautures

* Support for creating menu actions and submenus (i.e. nested and in-line menus)
* Support for customizing the menu icons (i.e. support for SF Symbols, `require(image)`, and `xcasset` icons, icon tint, etc.)
* Support for iOS 14 functionality (like the `UIButton` context menu, updating the menu while its visible, etc.)
* Support for setting (almost) all of the native [`UIMenu`](https://developer.apple.com/documentation/uikit/uimenu) and ￼[`UIAction`](https://developer.apple.com/documentation/uikit/uiaction) properties (e.g. `UIMenuElementState`,  `MenuElementAtrributes`, `discoverabilityTitle`, etc.)
* Basic `ActionSheetIOS` menu fallback for iOS 12 and below.
* Support for creating custom context menu previews (with support for dynamic or fixed preview sizes, setting the [`UIPreviewParameters`](https://developer.apple.com/documentation/uikit/uipreviewparameters), specifying a [`UITargetedPreview`](https://developer.apple.com/documentation/uikit/uitargetedpreview), etc.)

<br><br>

## B. Installation

```sh
# 1A) install via NPM
npm install react-native-ios-context-menu

# 1B) or install via yarn
yarn add react-native-ios-context-menu

# 2) then run pod install (uses auto-linking)
cd ios && pod install
```

<br>

📝 **Note**: You will encounter some build errors since this library is written in swift, so there's some extra step involved to use this library (see table below for reference).

| Additional Steps                                             |
| :----------------------------------------------------------- |
| 1️⃣ [Add an empty swift file to your project](#troubleshooting-xcode-build-error-swift) |
| 2️⃣ [Update the project's "Library Search Paths" build settings](#troubleshooting-xcode-build-error-undefined-symbol) |

<br>

### Expo

- ✅ You can use this library with [Development Builds](https://docs.expo.dev/development/introduction/). No config plugin is required.
- ❌ This library can't be used in the "Expo Go" app because it [requires custom native code](https://docs.expo.dev/workflow/customizing/).

<br>

### Troubleshooting

If you encounter any errors/bugs while using this library, or want a particular feature implemented, please create an issue! ✨

<br>

#### Troubleshooting: Xcode Build Error (Swift)

📝 **Note**: This library is written in swift. If you are having trouble building your app after installing this library, try adding an empty swift file to your project:

1. Open up your `ios/project.xcworkspace` project
2. On the project navigator panel (located on the right side of Xcode), right click on your project group (or another folder/group i.e the blue or yellow icons) and select the "*New File...*" option
3. In the popup sheet, select "Swift" as the template and then click the "*Next*" button
4. A "*Save As*" popup sheet should appear and then click "*Create*" (you can rename the file first if you want to)
5. If Xcode asks you to create a "*Objective-C Bridging Header*" choose *"Create Objective-C Bridging Header"*

<br>

#### Troubleshooting: Xcode Build Error (Undefined symbol)

When installing this library on Xcode 12+, you'll get the following error in Xcode:

![Xcode linking build error](assets/installation-troubleshooting-00.png)

```
Undefined symbol: (extension in UIKit):
__C.UIMenu.init(title: Swift.String, image: __C.UIImage?, identifier: __C.UIMenuIdentifier?, options: __C.UIMenuOptions, children: [__C.UIMenuElement]) -> __C.UIMenu

Undefined symbol: (extension in UIKit):
__C.UIAction.init(title: Swift.String, image: __C.UIImage?, identifier: __C.UIActionIdentifier?, discoverabilityTitle: Swift.String?, attributes: __C.UIMenuElementAttributes, state: __C.UIMenuElementState, handler: (__C.UIAction) -> ()) -> __C.UIAction
```

<br>

To fix this, see screenshot + follow the steps below:

![Xcode - Remove library search paths](assets/installation-troubleshooting-01-A.png)

<br>

1. Open your `ios/project.xcworkspace` project.
2. In the project navigator panel (located on the right side of Xcode), select your project group (i.e. the item with the blueprint icon).
3. The Xcode project editor should appear. In the left panel, under the "Project" section, select your project (if it isn't already selected).
4. In the project section's top tab bar, select the "Build Settings" tab (also make sure the "All" and "Combined" tabs are selected).
5. In the project navigator list, under the "Search Path" section, there should be a "Library Search Paths" setting (alternatively, you can search for "Library Search Paths" in the search bar).
6.  According to this [issue comment](https://github.com/facebook/react-native/issues/29246#issuecomment-667518920), you can clear all the items listed in the "Library Search Paths" setting by selecting the items in the list, and pressing the "-" button in the popover. 
	* **TLDR**: Xcode automatically manages this setting, and the RN template hardcodes it to use Swift 5.0.
	* Alternatively, you can change the entry `"$(TOOLCHAIN_DIR)/usr/lib/swift-5.0/$(PLATFORM_NAME)"` to `"$(TOOLCHAIN_DIR)/usr/lib/swift-5.3/$(PLATFORM_NAME)"` i.e. change `swift-5.0` to `swift-5.3`, or whatever the newest version of swift that comes with your Xcode installation (to show the popup dialog, double click the value/item).
7. If you haven't already, make sure to create an empty swift file. Then clean the build folder (the option is in the menu bar under: "Product" -> "Clean Build Folder") and try building your project again.
8. If you are still having problems building the app, try the following and build your project again:
  * Try clearing out Xcode's `derivedData` directory: `rm -rf ~/Library/Developer/Xcode/DerivedData/*` (check out this [gist](https://gist.github.com/maciekish/66b6deaa7bc979d0a16c50784e16d697) for instructions on how to clean up Xcode)
  * Try clearing out the `Cocoapods` cache: `rm -rf "${HOME}/Library/Caches/CocoaPods"` (and then try running `pod install` again).

<br>

![Xcode - Remove library search paths](assets/installation-troubleshooting-01-B.png)

<br>

**Explanation**: Some versions of the react-native template hard codes the swift library search paths to use swift `5.0` (which causes the linker to mismatch the swift system libraries bundled with your Xcode + iOS/Simulator installation).

Here are some related issues in the RN repo: [Issue 30202](https://github.com/facebook/react-native/pull/30202) and [Issue 29178](https://github.com/facebook/react-native/pull/29178). 

<br><br>

## C. Basic Usage

For more examples, check out the [Usage And Examples](#e-usage-and-examples) section.

<br>

[🔗 Full Example](example/src/examples/BasicUsageExample01.tsx)

```jsx
import * as React from 'react';
import { StyleSheet, Text } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

export function BasicUsageExample01() {
  return (
    <ContextMenuView
      style={styles.container}
      menuConfig={{
        menuTitle: 'BasicUsageExample01',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
        }],
      }}
    >
      <Text style={styles.text}>
        Press And Hold To Show Context Menu
      </Text>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  container: {
    margin: 10,
    padding: 10,
  },
  text: {
    fontSize: 16,
  },
});
```

<br><br>

## D. Documentation

💡 **Tip**: Most of the time, when a type or component is mentioned, you can click it to jump to that item in the README (or its declaration in the source code).

<br>

### D.1. Components

#### `ContextMenuView` Component

##### `ContextMenuView` Component: Props

| Prop Name and Type                                           | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ⚛️ `ViewProps`                                                | This component supports all the standard props from a `<View/>` component. |
| 🔤  `menuConfig`<br/><br/>⚛️ [`MenuConfig`](PLACE_HOLDER_LINK) | This prop configures the context menu, along with what menu actions to show.<br><br>This prop accepts a `MenuConfig` object. This object is used to configure various aspects of the context menu. Here are some relevant properties:<br>1️⃣  `MenuConfig.menuTitle`: the context menu title (required),<br><br/>2️⃣  `MenuConfig.menuItems`: the actions to show (E.g. the title, icons, subtitle, etc) — Accepts either an array of `MenuActionConfig` or `MenuConfig` objects.,<br><br/>3️⃣  `MenuConfig.menuOptions`: the attributes of the context menu (e.g. destructive) — Accepts an array of  `UIMenuOptions` string items, and any nested menus or submenus to show (see "**Note A**"). <br><br>📝 **Note A**: Passing a `MenuConfig` object inside of the `MenuConfig.menuItems` property will result in a nested context menu or submenu. In this scenario, the `MenuConfig.menuOptions` and `MenuConfig.icon` can be used to configure the appearance of the submenu. For usage examples regarding nested menus, see [Example 06](contextmenuview-example06)<br><br>📝 **Note B**: Passing a value of `null` (or `undefined`) to this prop will not disable the context menu. Use the `isContextMenuEnabled` prop instead to disable the context menu. <br><br/>📝 **Note C**: You can put `MenuConfig` in  state if you want to dynamically change the menu configuration. If the context menu is currently visible, changing/updating the `MenuConfig` value passed to this prop will cause the context menu to change in real-time. This behavior is only supported on iOS 14+.<br><br>📌 Some example links to get you started:<br>• For basic usage examples regarding `MenuConfig`, see: [Example 1](#contextmenuview-example-06),<br><br/>• For examples on creating + configuring the menu action items (i.e `MenuActionConfig`), see: [Example 2](#contextmenuview-example-02),<br><br/>• For menu action attributes + menu state, and action subtitles, see: [Example 4](#contextmenuview-example-04), [Example 8](#contextmenuview-example-08), and [Example 13](#contextmenuview-example-13),<br><br/>• For examples regarding the usage of icons (i.e `ImageItemConfig`), see: [Example 16](#contextmenuview-example-16), [Example 17](#contextmenuview-example-17), and [Example 18](#contextmenuview-example-18). |
| 🔤  `previewConfig`<br/><br/>⚛️ [`MenuPreviewConfig`](PLACE_HOLDER_LINK) | Configures the context menu's preview.<br><br>If no configuration is provided then it will default to using the context menu component itself as the preview.<br/><br/>📝 **Note**: If you do not want to show a preview (i.e only show the context menu itself), consider using a [`ContextMenuButton`](PLACE_HOLDER_LINK) component instead.<br/><br/>📌 Some example links to get you started:<br/>• For examples regarding the configuration of the context menu preview (e.g. custom previews), see: [Example 11](#contextmenuview-example-11), [Example 12](#contextmenuview-example-12), [Example 14](#contextmenuview-example-14), and [Example 15](#contextmenuview-example-15). |
| 🔤  `shouldUseDiscoverability`<br>`TitleAsFallbackValueForSubtitle`<br/><br>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | On iOS 15+, the value passed to the  `MenuActionConfig.discoverabilityTitle` property is no longer displayed as a subtitle under the menu action.<br><br>Instead you need to set a different property called `MenuActionConfig.subtitle`.<br><br>The `discoverabilityTitle` property is now used for the "discoverability heads-up display" (e.g when an app supports keyboard shortcuts, holding down the command key presents a list of shortcuts; the `discoverabilityTitle` is then used as the title for the shortcut).<br><br>If this prop is set to true, it will then uses the value passed on to the `discoverabilityTitle` value as the subtitle for the menu action, preserving the old behavior. In other words, this prop exists for backwards-compatibility reasons.<br><br>📝 **Note**: This prop is set to `true` by default; set this to `false` if you don't want this automatic behaviour to happen. |
| 🔤  `shouldWaitForMenuToHide`<br/>`BeforeFiringOnPressMenuItem`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | If set to `true`, the `onPressMenuItem` event will be triggered after the context menu has been hidden (i.e. after `onMenuDidHide` event is triggered).<br><br>Set this to `false` if you want `onPressMenuItem` to trigger as soon as an item has been pressed in the context menu.<br><br>📝 **Note**: Layout updates while the context menu is transitioning from it's open to hidden state might cause layout flickering (e.g. [Issue #43](https://github.com/dominicstop/react-native-ios-context-menu/issues/43)). |
| 🔤  `isContextMenuEnabled`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Enables or disables the context menu. Useful if you want to temporarily disable the context menu. |
| 🔤  `lazyPreview`<br/><br/>⚛️ `boolean`<br><br>✳️ **Default**: `true` | If set to `true` (which it is by default), the custom context menu preview (i.e the component returned from the `ContextMenuView.renderPreview` prop) will only be mounted/rendered when the context menu interaction begins (i.e when the context menu is about to be shown).<br><br>Set this to `false` if you want the preview content to be always mounted. |
| 🔤  `useActionSheetFallback`<br><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Context menus are only supported on iOS 13+ (i.e context menus are not supported on iOS 12, and below).<br><br>On iOS 12 and below, a long press on a `ContextMenuView` will show a [`ActionSheetIOS`](https://reactnative.dev/docs/actionsheetios#docsNav) menu based on the current `menuConfig` prop.<br><br> If you want to disable this behavior, set this  prop to false.<br><br>📝 **Note**: Default value is `false` on iOS 13+, and `true` on iOS 12 and below. |
| 🔤  `renderPreview`<br/><br/>⚛️ [`() => React.ReactElement`](PLACE_HOLDER_LINK) | This prop is a "render" prop, i.e it accepts a function that returns a react component.<br><br>The returned component will displayed in the context menu preview. |
| 🔤  `isAuxiliaryPreviewEnabled`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `false` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `auxiliaryPreviewConfig`<br/><br/>⚛️ `MenuAuxiliaryPreviewConfig` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `renderAuxillaryPreview`<br/><br/>⚛️ `() => React.ReactElement` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |

<br>

##### `ContextMenuView` Component: Event Props

| Prop Name and Type                                           | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| 🔤  `onMenuWillShow`<br/><br/>⚛️ [`OnMenuWillShowEvent`](./src/types/MenuEvents.ts) | Event that gets called **before** the context menu is shown, i.e this event is immediately invoked when the menu is <u>about to become visible</u>. |
| 🔤  `onMenuDidShow`<br/><br/>⚛️ [`OnMenuDidShowEvent`](./src/types/MenuEvents.ts) | Event that gets called **after** the context menu is shown, i.e this event is invoked <u>after the menu entrance animation</u> is finished. |
| 🔤  `onMenuWillHide`<br/><br/>⚛️ [`OnMenuWillHideEvent`](./src/types/MenuEvents.ts) | Event that gets called **before** the context menu is  hidden, i.e this event is immediately invoked when the menu is <u>about to become hidden</u>. |
| 🔤  `onMenuDidHide`<br/><br/>⚛️ [`OnMenuDidHideEvent`](./src/types/MenuEvents.ts) | Event that gets called **after** the context menu is hidden, i.e this event is invoked <u>after the menu exit animation</u> is finished. |
| 🔤  `onMenuWillCancel`<br/><br/>⚛️ [`OnMenuWillCancelEvent`](./src/types/MenuEvents.ts) | Event that gets called when the menu is **cancelled and about to be hidden**, i.e this event is immediately invoked when the context menu interaction is cancelled. |
| 🔤  `onMenuDidCancel`<br/><br/>⚛️ [`OnMenuDidCancelEvent`](./src/types/MenuEvents.ts) | Event that gets called when the menu is **cancelled and hidden**, i.e. this event is invoked when the context menu is cancelled, and the menu exit transition is finished. |
| 🔤  `onPressMenuItem`<br/><br/>⚛️ [`OnPressMenuItemEvent`](./src/types/MenuEvents.ts) | Event that gets called when a menu action is pressed.<br><br/> You can identify which action was pressed via `nativeEvent.actionKey ` property in the `nativeEvent` object. <br/><br/>Check out [Example 1](#contextmenuview-example-01), and [Example 9](#contextmenuview-example-09) for examples regarding the `onPressMenuItem` event prop.<br><br> 📝 **Note**: If `shouldWaitForMenuToHide`<br/>`BeforeFiringOnPressMenuItem` prop is set to `true` (which it is by default), then this event will fire after `onMenuDidHide` is triggered. |
| 🔤  `onPressMenuPreview`<br/><br/>⚛️ [`OnPressMenuPreviewEvent`](./src/types/MenuEvents.ts) | Event that gets called when the menu's preview is pressed.   |
| 🔤  `onMenuAuxiliaryPreviewWillShow`<br/><br/>⚛️ [`OnMenuAuxiliaryPreviewWillShowEvent`](./src/types/MenuEvents.ts) | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `onMenuAuxiliaryPreviewDidShow`<br/><br/>⚛️ [`OnMenuAuxiliaryPreviewDidShowEvent`](./src/types/MenuEvents.ts) | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |

<br>

##### `ContextMenuView` Component: Properties/Methods

| Prop Name and Type                          | Description                                                  |
| :------------------------------------------ | :----------------------------------------------------------- |
| 🔤  `dismissMenu`<br/><br/>⚛️ `Promise<Void>` | Allows you to  programmatically dismiss the context menu. Only available on iOS 14 and above. |

<br>

##### `ContextMenuView` Component: Experimental - Auxiliary Preview

The context menu auxiliary preview is an experimental feature, and is not officially part of `UIKit`'s "Menu and Shortcuts" API. 

This is just a feature that I've implemented myself and added to the library — as such official support is limited and might break in a future iOS version. Please use at your own risk.

<br>

#### `ContextMenuButton` Component

For basic usage, please see [Example 1](#contextmenubutton-example-01) section.

* The `ContextMenuButton` component is almost the same as the `ContextMenuView` component (It supports the same kind of props and events). <br><br>

* The only difference between them is that the `ContextMenuButton` component does not have a preview, and it can be immediately shown when its tapped instead of having to do a long press. See [Example 2](#422-contextmenubutton-simple-example-2) for more details.<br><br>

* Note that `ContextMenuButton` is only available on iOS 14 and above. On iOS 13, it will use a `ContextMenuButton`, and on iOS 12 and below, it will use the `ActionSheetFallback` module to present a `ActionSheetIOS` menu.<br><br>

* If you want to add additional touch events, you can wrap this component inside a button component (e.g. `TouchableOpacity`). <br><br>
	* When wrapping this component inside a button, please make sure to set the `useActionSheetFallback` prop to `false`.

<br>

##### `ContextMenuButton` Component: Props

| Prop Name and Type                                           | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ⚛️ `ViewProps`                                                | This component supports all the standard props from a `<View/>` component. |
| 🔤  `menuConfig`<br/><br/>⚛️ [`MenuConfig`](PLACE_HOLDER_LINK) | Same as `ContextMenuView.menuConfig` prop.                   |
| 🔤  `isMenuPrimaryAction`<br/><br/>⚛️ `boolean`                | When set to true, the context menu will be shown when its tapped instead of a long press. |
| 🔤  `shouldUseDiscoverability`<br>`TitleAsFallbackValueForSubtitle`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | TBA / Not Implented                                          |
| 🔤  `enableContextMenu`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Same as `ContextMenuView.enableContextMenu` prop.            |
| 🔤  `useActionSheetFallback`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Same as `ContextMenuView.useActionSheetFallback` prop.       |

<br>

##### `ContextMenuButton` Component: Event Props

| Prop Name and Type                                           | Description                                       |
| :----------------------------------------------------------- | :------------------------------------------------ |
| 🔤  `onMenuWillShow`<br/><br/>⚛️ [`OnMenuWillShowEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuWillShow` event.   |
| 🔤  `onMenuDidShow`<br/><br/>⚛️ [`OnMenuDidShowEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuDidShow` event.    |
| 🔤  `onMenuWillHide`<br/><br/>⚛️ [`OnMenuWillHideEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuWillHide` event.   |
| 🔤  `onMenuDidHide`<br/><br/>⚛️ [`OnMenuDidHideEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuDidHide` event.    |
| 🔤  `onMenuWillCancel`<br/><br/>⚛️ [`OnMenuWillCancelEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuWillCancel` event. |
| 🔤  `onMenuDidCancel`<br/><br/>⚛️ [`OnMenuDidCancelEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuDidCancel` event.  |
| 🔤  `onMenuWillCreate`<br/><br/>⚛️ [`OnMenuWillCreateEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onMenuWillCreate` event. |
| 🔤  `onPressMenuItem`<br/><br/>⚛️ [`OnPressMenuItemEvent`](./src/types/MenuEvents.ts) | Same as `ContextMenuView.onPressMenuItem` event.  |

<br>

##### `ContextMenuButton` Component: Properties/Methods

| Prop Name and Type                          | Description                                   |
| :------------------------------------------ | :-------------------------------------------- |
| 🔤  `dismissMenu`<br/><br/>⚛️ `Promise<Void>` | Same as `ContextMenuView.dismissMenu` method. |

<br>

#### `ActionSheetFallback` Module

A module to show a `ActionSheetIOS` menu based on a `MenuConfig` object. 

This module attempts to approximate `UIMenu` behavior using `ActionSheetIOS`, so it's very limited (i.e. it does not support menu/action icons, etc.), but it does support things like submenu's, destructive actions/menu's, inline submenu's, and hidden actions.

<br>

* Import the module like this: `import { ActionSheetFallback } from "react-native-ios-context-menu";`<br><br>

* To present a ￼￼`ActionSheetIOS` menu, call `const selectedAction = await ActionSheetFallback.show(menuConfig)`

<br>


| Function                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 🔤 `show` <br/><br/>⚛️ `(menuConfig: MenuConfig):`<br/>`Promise<MenuAction ¦ null>` | This function accepts a `MenuConfig` object and returns the selected `MenuAction` object or null if cancelled. |

<br>

### D.2. Context

#### `ContextMenuViewContext` Context

TBA

| Property                                                     | Description |
| ------------------------------------------------------------ | ----------- |
| 🔤  `isMenuVisible`<br/><br/>⚛️ `boolean`                      | TBA         |
| 🔤  `getRefToContextMenuView`<br/><br/>⚛️ `() => ContextMenuView`<br>📌 [`ContextMenuView`](PLACE_HOLDER_LINK) | TBA         |

<br>

#### `ContextMenuButtonContext` Context

TBA

| Property                                                     | Description |
| ------------------------------------------------------------ | ----------- |
| 🔤  `isMenuVisible`<br/><br/>⚛️ `boolean`                      | TBA         |
| 🔤  `getRefToContextMenuButton`<br/><br/>⚛️ `() => ContextMenuView`<br>📌 [`ContextMenuButton`](PLACE_HOLDER_LINK) | TBA         |

<br>

### D.3. Hooks

####  `useMenuContext` Hook

A hook to use the `ContextMenuViewContext` context.

TBA

<br>

####  `useMenuButtonContext` Hook

A hook to use the `ContextMenuButtonContext` context.

TBA

<br>

### D.4. Objects and Types

#### 📄 `MenuConfig.ts`

* 📌 **Declaration**: [`MenuConfig.ts`](src/types/MenuConfig.ts)

##### Object Type: `MenuConfig`

> A container for grouping related menu elements in an app menu or contextual menu.

An object that is used to create and configure a context menu. Internally, this object is used to create a `UIMenu` instance (see [apple docs](https://developer.apple.com/documentation/uikit/uimenu/) for more information).

<br>

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| 🔤  `type`<br/><br/>⚛️ `string`, i.e`"menu"`                   | TBA                                                          |
| 🔤  `menuTitle`<br/><br/>⚛️ `string`                           | TBA<br><br>📝 **Note**: If you don't want a menu title to appear for your context menu, just pass in an empty string to this property. |
| 🔤  `menuOptions`<br/><br/>⚛️ `Array<UIMenuOptions>`<br>📌 [`UIMenuOptions`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `menuItems`<br/><br/>⚛️ `Array<MenuConfig ¦ MenuActionConfig `<br/>📌 [`MenuConfig`](PLACE_HOLDER_LINK)<br/>📌 [`MenuActionConfig`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `icon`<br/><br/>⚛️ `IconConfig ¦ ImageItemConfig`<br/>📌 [`IconConfig`](PLACE_HOLDER_LINK) (deprecated)<br/>📌 [`ImageItemConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

##### Object Type: `MenuActionConfig`

An object that is used to create a menu action item in the context menu. Internally, this object is used to create a `UIAction` instance (see [apple docs](https://developer.apple.com/documentation/uikit/uiaction) for more information),

<br>

| Name and Type                                                | Description |
| :----------------------------------------------------------- | :---------- |
| 🔤  `type`<br/><br/>⚛️ `string`, i.e `"action"`                | TBA         |
| 🔤 **Required**: `actionKey`<br/><br/>⚛️ `string`              | TBA         |
| 🔤 **Required**:  `actionTitle`<br/><br/>⚛️ `string`           | TBA         |
| 🔤  `actionSubtitle`<br/><br/>⚛️ `string`                      | TBA         |
| 🔤  `menuState`<br/><br/>⚛️ [`MenuState`](PLACE_HOLDER_LINK)   | TBA         |
| 🔤  `menuAttributes`<br/><br/>⚛️ `Array<MenuAttributes>`<br>📌 [`MenuAtrributes`](PLACE_HOLDER_LINK) | TBA         |
| 🔤  `discoverabilityTitle`<br/><br/>⚛️ `string`                | TBA         |
| 🔤  `icon`<br/><br/>⚛️ `IconConfig ¦ ImageItemConfig`<br/>📌 [`IconConfig`](PLACE_HOLDER_LINK) (deprecated)<br/>📌 [`ImageItemConfig`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `MenuAttributes`

> Attributes that determine the style of the menu element.

A union string type that maps to `UIMenuElement.Attributes` enum (see [apple docs](https://developer.apple.com/documentation/uikit/uimenuelement/attributes) for more information).

<br>

| Type             | Description |
| :--------------- | :---------- |
| ⚛️  `hidden`      | TBA         |
| ⚛️  `disabled`    | TBA         |
| ⚛️  `destructive` | TBA         |

<br>

##### String Union: `MenuState`

> Constants that indicate the state of an action- or command-based menu element.

A union string type that maps to `UIMenuElement.State` enum (see [apple docs](https://developer.apple.com/documentation/uikit/uimenuelement/state) for more information).

<br>

| Type       | Description |
| :--------- | :---------- |
| ⚛️  `on`    | TBA         |
| ⚛️  `off`   | TBA         |
| ⚛️  `mixed` | TBA         |

<br>

##### String Union: `UIMenuOptions`

> Options for configuring a menu's appearance. 

A union string type that maps to `UIMenu.Options` option set (see [apple docs](https://developer.apple.com/documentation/uikit/uimenu/options/) for more information).

<br>

| Type               | Description |
| :----------------- | :---------- |
| ⚛️  `destructive`   | TBA         |
| ⚛️  `displayInline` | TBA         |

<br>

#### 📄 `MenuPreviewConfig.ts`

* 📌 **Declaration**: [`MenuPreviewConfig.ts`](src/types/MenuPreviewConfig.ts)

##### Object Type: `MenuPreviewConfig`

| Name and Type                                                | Description |
| :----------------------------------------------------------- | :---------- |
| 🔤  `previewType`<br/><br/>⚛️ [`MenuPreviewType`](PLACE_HOLDER_LINK)<br/><br/>✳️ **Default**: `DEFAULT` | TBA         |
| 🔤  `previewSize`<br/><br/>⚛️ [`MenuPreviewSize`](PLACE_HOLDER_LINK)<br/><br/>✳️ **Default**: `INHERIT` | TBA         |
| 🔤  `isResizeAnimated`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | TBA         |
| 🔤  `borderRadius`<br/><br/>⚛️ `number`                        | TBA         |
| 🔤  `backgroundColor`<br/><br/>⚛️ `DynamicColor ¦ string`<br>📌 [`DynamicColor`](PLACE_HOLDER_LINK) | TBA         |
| 🔤  `previewSize`<br/><br/>⚛️ [`ContextMenuInteractionCommitStyle`](PLACE_HOLDER_LINK)<br/><br/>✳️ **Default**: `dismiss` | TBA         |
| 🔤  `targetViewNode`<br/><br/>⚛️ `number`                      | TBA         |

<br>

##### String Union: `ContextMenuInteractionCommitStyle`

| Name and Type | Description |
| :------------ | :---------- |
| ⚛️  `dismiss`  | TBA         |
| ⚛️  `pop`      | TBA         |

<br>

##### String Union: `MenuPreviewSize`

| Name and Type | Description |
| :------------ | :---------- |
| ⚛️  `INHERIT`  | TBA         |
| ⚛️  `STRETCH`  | TBA         |

<br>

##### String Union: `MenuPreviewType`

| Name and Type | Description |
| :------------ | :---------- |
| ⚛️  `DEFAULT`  | TBA         |
| ⚛️  `CUSTOM`   | TBA         |

<br>

#### 📄 `MenuAuxiliaryPreviewConfig.ts`

* 📌 **Declaration**: [`MenuAuxiliaryPreviewConfig.ts`](src/types/MenuAuxiliaryPreviewConfig.ts)

<br>

##### Object Type: `MenuAuxiliaryPreviewConfig`

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  `height`<br/><br/>⚛️ `number`                              | TBA         |
| 🔤  `anchorPosition`<br/><br/>⚛️ `MenuAuxiliaryPreviewAnchorPosition`<br/><br/>✳️ **Default**: `automatic` | TBA         |
| 🔤  `alignmentHorizontal`<br/><br/>⚛️ `MenuAuxiliaryPreviewHorizontalAlignment`<br/><br/>✳️ **Default**: `stretchPreview` | TBA         |
| 🔤  `marginPreview`<br/><br/>⚛️ `number`                       | TBA         |
| 🔤  `marginAuxiliaryPreview`<br/><br/>⚛️ `number`              | TBA         |
| 🔤  `transitionConfigEntrance`<br/><br/>⚛️ `MenuAuxiliaryPreviewTransitionConfig` | TBA         |
| 🔤  `transitionEntranceDelay`<br/><br/>⚛️ `MenuAuxiliaryPreviewTransitionEntranceDelay` | TBA         |

<br>

##### String Union Type: `MenuAuxiliaryPreviewAnchorPosition`

| Name and Type  | Description |
| :------------- | ----------- |
| ⚛️  `top`       | TBA         |
| ⚛️  `bottom`    | TBA         |
| ⚛️  `automatic` | TBA         |

<br>

##### String Union Type: `MenuAuxiliaryPreviewHorizontalAlignment`

| Name and Type        | Description |
| -------------------- | ----------- |
| ⚛️  `stretchScreen`   | TBA         |
| ⚛️  `stretchPreview`  | TBA         |
| ⚛️  `previewLeading`  | TBA         |
| ⚛️  `previewTrailing` | TBA         |
| ⚛️  `previewCenter`   | TBA         |

<br>

##### String Union Type: `UIViewAnimateOptions`

| Name and Type       | Description |
| :------------------ | ----------- |
| ⚛️  `curveEaseIn`    | TBA         |
| ⚛️  `curveEaseOut`   | TBA         |
| ⚛️  `curveEaseInOut` | TBA         |
| ⚛️  `curveLinear`    | TBA         |

<br>

##### Object Type: `UIViewAnimateConfig`

| Name and Type                                    | Description |
| :----------------------------------------------- | ----------- |
| 🔤  `duration`<br/><br/>⚛️ `number`                | TBA         |
| 🔤  `delay`<br/><br/>⚛️ `number`                   | TBA         |
| 🔤  `options`<br/><br/>⚛️ `UIViewAnimateOptions[]` | TBA         |

<br>

##### Object Union Type: `MenuAuxiliaryPreviewTransitionConfig`

This type is extends/union-ed with `UIViewAnimateConfig` object type, and such is not listed in this section. Please see `UIViewAnimateConfig` type for the other object properties.<br><br>This type is an object tagged union type, with the `transition` property being the tag that separates the unions. The table below defines the possible valid values that can be assigned to the `type` property (the subsequent tables are the different possible unions).

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  `transition `<br/><br/>⚛️ `string` i.e. `'none' ¦  'fade'`<br>`'slide' ¦ 'zoom' ¦ 'zoomAndSlide'` | TBA         |

<br>

| Name and Type                                   | Description |
| :---------------------------------------------- | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `none` | TBA         |

<br>

| Name and Type                                   | Description |
| :---------------------------------------------- | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `fade` | TBA         |

<br>

| Name and Type                                    | Description |
| :----------------------------------------------- | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `slide` | TBA         |

<br>

| Name and Type                                   | Description |
| :---------------------------------------------- | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `zoom` | TBA         |

<br>

| Name and Type                                           | Description |
| :------------------------------------------------------ | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `zoomAndSlide` | TBA         |

<br>

##### Mixed Union Type: `MenuAuxiliaryPreviewTransitionEntranceDelay`.

| Name and Type     | Description |
| :---------------- | ----------- |
| ⚛️ `number`        | TBA         |
| ⚛️ `RECOMMENDED`   | TBA         |
| ⚛️ `AFTER_PREVIEW` | TBA         |

<br>

#### 📄 `MenuIconConfig.ts`

* 📌 **Declaration**: [`MenuIconConfig.ts`](src/types/MenuIconConfig.ts)

<br>

##### Object Type: `IconConfig`

This has been deprecated and will be removed in a future version. Use [`ImageItemConfig`](PLACE_HOLDER_LINK) instead. For documentation regarding `IconConfig`, please see the documentation in the [old README](./README-old.md).

<br>

#### 📄 `ImageItemConfig.ts`

* 📌 **Declaration**: [`ImageItemConfig.ts`](src/types/ImageItemConfig.ts)

<br>

##### Object Type: `ImageItemConfig`

This type is an object tagged union type, with the `type` property being the tag that separates the unions. The table below defines the possible valid values that can be assigned to the `type` property.

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `ImageItemConfigType` string union, i.e `'IMAGE_ASSET' ¦ 'IMAGE_SYSTEM' ¦ 'IMAGE_REQUIRE' ¦ 'IMAGE_EMPTY' ¦ 'IMAGE_RECT' ¦ 'IMAGE_GRADIENT' ` | TBA         |

<br>

###### `ImageItemConfig`: `IMAGE_ASSET`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_ASSET' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(named:)`](https://developer.apple.com/documentation/uikit/uiimage/1624146-init) constructor in the apple docs. |
| 🔤  **Required**: `imageValue`<br/><br/>⚛️  `string`           | TBA                                                          |
| 🔤  `imageOptions?`<br/><br/>⚛️  [`UIImageConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_SYSTEM`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_SYSTEM' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤  **Required**:  `imageValue`<br/><br/>⚛️  [`ImageSystemConfig`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to the `withConfiguration` argument label in the  [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤  `imageOptions?`<br/><br/>⚛️  [`UIImageConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_EMPTY`

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_EMPTY' ` | TBA         |

<br>

###### `ImageItemConfig`: `IMAGE_RECT`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_RECT' ` | TBA<br/><br/>📝 **Note**: Programmatically creates an image using [`UIGraphicsImageRenderer`](https://developer.apple.com/documentation/uikit/uigraphicsrenderer). |
| 🔤  **Required**: `imageValue`<br/><br/>⚛️  [`ImageRectConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_GRADIENT`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_GRADIENT' ` | TBA<br/><br/>📝 **Note**: Programmatically creates an image using [`UIGraphicsImageRenderer`](https://developer.apple.com/documentation/uikit/uigraphicsrenderer). |
| 🔤  `imageValue`<br/><br/>⚛️  [`ImageGradientConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

#####  Object Type: `ImageResolvedAssetSource`

TBA

| Name and Type                    | Description |
| :------------------------------- | ----------- |
| 🔤  `height`<br/><br/>⚛️  `number` | TBA         |
| 🔤  `width`<br/><br/>⚛️  `number`  | TBA         |
| 🔤  `scale`<br/><br/>⚛️  `number`  | TBA         |
| 🔤  `uri`<br/><br/>⚛️  `string`    | TBA         |

<br>

#####  Object Type: `ImageRectConfig`

TBA

| Name and Type                                    | Description |
| :----------------------------------------------- | ----------- |
| 🔤 **Required**:  `width`<br/><br/>⚛️  `number`    | TBA         |
| 🔤 **Required**: `height`<br/><br/>⚛️  `number`    | TBA         |
| 🔤 **Required**: `fillColor`<br/><br/>⚛️  `string` | TBA         |
| 🔤  `borderRadius?`<br/><br/>⚛️  `number`          | TBA         |

<br>

#####  Object Type: `ImageGradientConfig`

TBA

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤 **Required**:  `width`<br/><br/>⚛️  `number`                | TBA                                                          |
| 🔤 **Required**: `height`<br/><br/>⚛️  `number`                | TBA                                                          |
| 🔤  `borderRadius?`<br/><br/>⚛️  `number`                      | TBA                                                          |
| 🔤  **Required**:  `colors`<br/><br/>⚛️  `Array<string>`       | TBA<br/><br/>📌 Maps to [`CAGradientLayer.colors`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462403-colors) property in the apple docs. |
| 🔤  `locations?`<br/><br/>⚛️  `Array<number>`                  | TBA<br/><br/>📌 Maps to [`CAGradientLayer.locations`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462410-locations) property in the apple docs. |
| 🔤  `startPoint?`<br/><br/>⚛️  `Point ¦ PointPreset`<br><br>📌 [`Point`](PLACE_HOLDER_LINK)<br>📌 [`PointPreset`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to [`CAGradientLayer.startPoint`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462408-startpoint) property in the apple docs. |
| 🔤  `endPoint?`<br/><br/>⚛️  `Point ¦ PointPreset`<br>📌 [`Point`](PLACE_HOLDER_LINK)<br/>📌 [`PointPreset`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to [`CAGradientLayer.endPoint`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462412-endpoint) property in the apple docs. |
| 🔤  `type?`<br/><br/>⚛️  `string` i.e `'axial' ¦ 'conic' ¦ 'radial'` | TBA<br/><br/>📌 Maps to [`CAGradientLayer.type`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462413-type) property in the apple docs. |

<br>

#####  Object Type: `ImageSystemConfig`

TBA

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤 **Required**:  `systemName`<br/><br/>⚛️  `string`           | TBA<br/><br/>📌 Maps to the `systemName` argument label in the [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤 `pointSize?`<br/><br/>⚛️  `number`                          | TBA<br/><br/>📌 Maps to [`UIImage.SymbolConfiguration.init(pointSize:)`](https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration/3294241-init) constructor in the apple docs. |
| 🔤  `weight?`<br/><br/>⚛️  [`ImageSymbolWeight`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to [`UIImage.SymbolConfiguration.init(weight:)`](https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration/3294247-init) constructor in the apple docs. |
| 🔤  `scale?`<br/><br/>⚛️  [`ImageSymbolScale`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to [`UIImage.SymbolConfiguration.init(scale:)`](https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration/3294244-init) constructor in the apple docs. |
| 🔤  `hierarchicalColor?`<br/><br/>⚛️  `Array<string>`          | TBA<br/><br/>📝 **Note A**: Cannot be used at the same time with `paletteColors`  (it's either one or the other).<br><br>📝 **Note B**: Requires iOS 15+.<br/><br/>📌 Maps to [`UIImage.SymbolConfiguration.init(hierarchicalColor:)`](https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration/3810053-init) constructor in the apple docs. |
| 🔤  `paletteColors?`<br/><br/>⚛️  `string`                     | TBA<br/><br/>📝 **Note A**: Cannot be used at the same time with `hierarchicalColor`  (it's either one or the other).<br/><br/>📝 **Note B**: Requires iOS 15+.<br/><br/>📌 Maps to [`UIImage.SymbolConfiguration.init(paletteColors:)`](https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration/3810054-init) constructor in the apple docs. |

<br>

#### Undocumented Types

TBA

| Type                                                        | Description                                                  |
| :---------------------------------------------------------- | ------------------------------------------------------------ |
| 📌 **Declaration**: [`MenuEvents`](src/types/MenuEvents.ts)  | This file contains all the menu-related events and event objects. |
| 📌 **Declaration**: [`MiscTypes.ts`](src/types/MiscTypes.ts) | This file contains a bunch of types that haven't been categorized yet.<br><br>Contains: `PointPreset`, `Point`, `DynamicColor`, etc. |

<br>

### D.5. Constants

#### Object: `LIB_ENV`

TBA

<br>

| Type                                                    | Description |
| :------------------------------------------------------ | :---------- |
| 🔤  `isContextMenuButtonSupported`<br/><br/>⚛️  `boolean` | TBA         |
| 🔤  `isContextMenuViewSupported`<br/><br/>⚛️  `boolean`   | TBA         |

<br>

<br><br>

## E. Usage And Examples

### `ContextMenuView` Example 01

A basic context menu that has 3 menu action items (e.g. "Action #1", "Action #2", and "Action #3").

<br>

* The `ContextMenuView.menuConfig` prop accepts an optional `MenuConfig` object. The object will be used to create and configure the context menu<br><br>
	* You can set the context menu title via passing a string value to the `MenuConfig.menuTitle` property.<br><br>
	* To populate the context menu with items, you can pass a `MenuActionConfig` object to the `MenuConfig.menuItems` property.


<br>

* A `MenuActionConfig` object represents an action item in the context menu (e.g. copy, paste, delete, etc).<br><br>
	* The `MenuActionConfig.actionKey` property serves as a unique identifier for your menu action.


<br>

* You will receive the value you passed in `MenuActionConfig.actionKey` in the `ContextMenuView.onPressMenuItem` event (i.e. via the  `nativeEvent` object).<br><br>
	* In other words, the `actionKey` allows you to identify which menu action item was selected/pressed.<br><br>
	* 📝 **Note**: Make sure that the `actionKey` is unique for each instance of the `ContextMenuView` component.


<br>

* You can use the `ContextMenuView.onPressMenuItem` event prop to get notified whenever a menu action item has been selected.<br><br>
	* The function you pass to the `onPressMenuItem` prop receives a `OnPressMenuItemEventObject` object.<br><br>
	* Details about the selected menu action item can be accessed via the `OnPressMenuItemEventObject.nativeEvent` object.<br><br>
	* E.g. `OnPressMenuItemEventObject.nativeEvent.actionKey`.

<br>

-  📝 **Note**: If `shouldWaitForMenuToHide`<br/>`BeforeFiringOnPressMenuItem` prop is set to `true` (which it is by default), then this event will fire after `onMenuDidHide` is triggered.

<br>

[🔗 Full Example](example/src/examples/ContextMenuViewExample01.tsx)

```jsx
// 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample01(props) {
  return (
    <ContextMenuView
      menuConfig={{
        // Note: If you don't want a menu title to appear for your 
        // context menu, you can just pass in an empty string
        menuTitle: 'ContextMenuViewExample01',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample01-old.png)

![Gif](assets/example-ContextMenuViewExample01.gif)

<br>

### `ContextMenuView` Example 02

A basic context menu that has 3 menu action items, each with a different "SF Symbols" icon. This examples shows how to add a system icon in the context menu action.

<br>

* A `MenuActionConfig` object can be configured to show an icon via the `MenuActionConfig.icon` property.<br><br>
	* The `icon` property accepts a `ImageItemConfig` object.<br><br>
	* A `ImageItemConfig` object is used to describe images/assets (e.g. SF Symbols icons, images, xcasset images, programmatic images, etc).


<br>

* In this example, we want to use a "SF Symbols" icon for the menu action. <br><br>
	* In order to do this, the `ImageItemConfig.type` property must be set to `"IMAGE_SYSTEM"`.<br><br>

	* Passing in a value of `"IMAGE_SYSTEM"` to the `type` property means that we want to create a "SF Symbols" system icon.<br><br>
	* Using a "SF Symbols" icon requires iOS 13+.


<br>

* In order to configure what kind of "SF Symbols" icon we want to use for the menu action, we need to pass in a `ImageSystemConfig` object to the  `ImageItemConfig.imageValue` property.<br><br>
	* We set what kind of icon to use via passing a string value to the `ImageSystemConfig.systemName` property.<br><br>
	* The string value passed to the `systemName` property must be a valid SF Symbols name.<br><br>
	* To view the list of SF Symbols icons (along with their corresponding icon names), you'll need to download the SF Symbols Mac app from [this page](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/).


<br>

[🔗 Full Example](example/src/examples/ContextMenuViewExample02.tsx)

```jsx
// 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample02(props) {
  return (
    <ContextMenuView
      menuConfig={{
          menuTitle: 'ContextMenuViewExample02',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'folder',
              },
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'dial.fill',
              },
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'archivebox.fill',
              },
            }
          }],
        }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample02-old.png)

![Gif](assets/example-ContextMenuViewExample02.gif)

<br>

### `ContextMenuView` Example 03

This example shows a context menu that has a submenu item inside its list of menu actions.

* A context menu supports having nested menu's (i.e. submenu's).<br><br>

	* A submenu is basically just another menu with it's own separate list of menu actions.<br><br>
	* Tapping/selecting a submenu will show another context menu,


<br>

* The `MenuConfig.menuItems` property can accept a `MenuActionConfig` object, or a `MenuConfig` object.<br><br>

  * Passing in a `MenuActionConfig` object to `MenuConfig.menuItems`  makes a menu action, conversely passing in a  `MenuConfig` object will create a submenu item.<br><br>
  * In other words, to make a submenu, you just need to pass a `MenuConfig` item in the `MenuConfig.menuItems` property.<br><br>
  	* 📝 **Note**: You can nest as many submenu's you want (but just remember that having more than 3 nested submenus is considered bad UX).

<br>

[🔗 Full Example](example/src/examples/ContextMenuViewExample03.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample03(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample03',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          menuTitle: 'Submenu...',
          menuItems: [{
            actionKey  : 'key-01-01',
            actionTitle: 'Submenu Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star',
              },
            }
          }, {
            actionKey  : 'key-01-02',
            actionTitle: 'Submenu Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.lefthalf.fill',
              },
            }
          }, {
            actionKey  : 'key-01-03',
            actionTitle: 'Submenu Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.fill',
              },
            }
          }]
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample03-old.png)

![Gif](assets/example-ContextMenuViewExample03.gif)

<br>

### `ContextMenuView` Example 04

This example context menu showcases the `MenuActionConfig.menuAttributes` property.

<br>

* The `MenuActionConfig.menuAttributes` property accepts an array of strings (i.e. an array of `MenuAttributes` items).

<br>

* In this example, the context menu has 3 actions, each with a different menu attribute assigned to it.<br><br>
	* The first menu action is a "disabled" action. It has it's `menuAttributes` set to `[disabled]`.<br><br>
	* The action title text and icon becomes grey out.


<br>

* The second menu action is a destructive action. It has it's `menuAttributes` set to `[destructive]`.<br><br>
  * The action title text and icon becomes red.

<br>

* The third menu action is a "hidden" action. It has it's `menuAttributes` set to `[hidden]`.<br><br>
  * The menu action is not visible in the menu's list of actions. This is useful for temporarily hiding a menu action item.

<br>

* The fourth menu action is a "disabled" + "destructive"  action. <br><br>
	* Visually, it looks very similar to the `disabled` action. 

<br>

[🔗 Full Example](example/src/examples/ContextMenuViewExample04.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample04(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample04',
        menuItems: [{
          actionKey     : 'key-01',
          actionTitle   : 'Disabled Action',
          menuAttributes: ['disabled'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey     : 'key-02'   ,
          actionTitle   : 'Destructive Action',
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }, {
          actionKey     : 'key-03'   ,
          actionTitle   : 'Hidden Action',
          menuAttributes: ['hidden'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }, {
          actionKey     : 'key-04'   ,
          actionTitle   : 'Disabled/Destructive',
          menuAttributes: ['disabled', 'destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash.fill',
            },
          }
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample04-old.png)

![Gif](assets/example-ContextMenuViewExample04.gif)

<br>

### `ContextMenuView` Example 05

[🔗 Full Example](example/src/examples/ContextMenuViewExample05.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample05(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample03',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          menuTitle: 'Submenu...',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey  : 'key-01-01',
            actionTitle: 'Submenu Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star',
              },
            }
          }, {
            actionKey  : 'key-01-02',
            actionTitle: 'Submenu Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.lefthalf.fill',
              },
            }
          }, {
            actionKey  : 'key-01-03',
            actionTitle: 'Submenu Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.fill',
              },
            }
          }]
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample05-old.png)

![Gif](assets/example-ContextMenuViewExample05.gif)

<br>

### `ContextMenuView` Example 06

[🔗 Full Example](example/src/examples/ContextMenuViewExample06.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample06(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample06',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          menuTitle: 'Submenu...',
          menuOptions: ['destructive'],
          menuItems: [{
            actionKey  : 'key-01-01',
            actionTitle: 'Submenu Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star',
              },
            }
          }, {
            actionKey  : 'key-01-02',
            actionTitle: 'Submenu Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.lefthalf.fill',
              },
            }
          }, {
            actionKey  : 'key-01-03',
            actionTitle: 'Submenu Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.fill',
              },
            }
          }]
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample06-old.png)

![Gif](assets/example-ContextMenuViewExample06.gif)

<br>

### `ContextMenuView` Example 07

[🔗 Full Example](example/src/examples/ContextMenuViewExample07.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample07(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample07',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          menuTitle: 'Submenu...',
          menuOptions: ['displayInline', 'destructive'],
          menuItems: [{
            actionKey  : 'key-01-01',
            actionTitle: 'Submenu Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star',
              },
            }
          }, {
            actionKey  : 'key-01-02',
            actionTitle: 'Submenu Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.lefthalf.fill',
              },
            }
          }, {
            actionKey  : 'key-01-03',
            actionTitle: 'Submenu Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.fill',
              },
            }
          }]
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample07-old.png)

![Gif](assets/example-ContextMenuViewExample07.gif)

<br>

### `ContextMenuView` Example 08

[🔗 Full Example](example/src/examples/ContextMenuViewExample08.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample08(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample08',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'menuState: on',
          menuState  : 'on',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'menuState: off',
          menuState  : 'off',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'dial',
            },
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'menuState: mixed',
          menuState  : 'mixed',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'archivebox',
            },
          }
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample08-old.png)

![Gif](assets/example-ContextMenuViewExample08.gif)

<br>

### `ContextMenuView` Example 09

[🔗 Full Example](example/src/examples/ContextMenuViewExample09.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample09(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample09',
        menuItems: [{
          actionKey  : 'save',
          actionTitle: 'Save',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'square.and.arrow.down',
            },
          }
        }, {
          actionKey  : 'like',
          actionTitle: 'Like',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'hand.thumbsup',
            },
          }
        }, {
          actionKey  : 'play',
          actionTitle: 'Play',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'play',
            },
          }
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'save':
            Alert.alert('saving...');
            break;

          case 'like':
            Alert.alert('liking...');
            break;

          case 'play':
            Alert.alert('playing...');
            break;
        };
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample09-old.png)

![Gif](assets/example-ContextMenuViewExample09.gif)

<br>

### `ContextMenuView` Example 10

[🔗 Full Example](example/src/examples/ContextMenuViewExample10.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample10(props) {
  const [timer, setTimer] = React.useState(0);
  const increment = React.useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((prevTimer) => prevTimer + 1);
    }, 1000);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return (
    <ContextMenuView
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleReset()}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample10',
        menuItems: [{
          actionKey  : 'key-00',
          actionTitle: `Static Action`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'square.and.arrow.down',
            },
          }
        }, {
          actionKey  : 'key-01',
          actionTitle: `timer: ${timer}`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: ((timer % 2 === 0)
                ? 'heart'
                : 'heart.fill'
              ),
            },
          }
        }, (timer % 3 === 0) && {
          actionKey  : 'key-02',
          actionTitle: `Dynamic Action`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'scissors.badge.ellipsis',
            },
          }
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample10-old.png)

![Gif](assets/example-ContextMenuViewExample10.gif)

<br>

### `ContextMenuView` Example 11

[🔗 Full Example](example/src/examples/ContextMenuViewExampleXX.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample11(props) {
  return (
    <ContextMenuView
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
        </View>
      )}
      onPressMenuPreview={() => {
        Alert.alert(
          'onPressMenuPreview Event',
          `Menu preview was pressed...`
        );
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample11-old.png)

![Gif](assets/example-ContextMenuViewExample11.gif)

<br>

### `ContextMenuView` Example 12

[🔗 Full Example](example/src/examples/ContextMenuViewExample12.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample12(props) {
    const [timer, setTimer] = React.useState(0);
  const increment = React.useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((prevTimer) => prevTimer + 1);
    }, 1000);
  };

  const handleStop = () => {
    clearInterval(increment.current);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample12',
        menuItems: [{
          actionKey     : 'add',
          actionTitle   : `Add 100`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'plus',
            },
          }
        }, (timer > 0) && {
          actionKey     : 'reset',
          actionTitle   : `Reset Counter`,
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }],
      }}
      previewConfig={{
        previewType: 'CUSTOM',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={{ padding: 20 }}>
          <Text style={{fontSize: 32}}>
            {`Counter: ${timer}`}
          </Text>
          <Text style={{fontSize: 32}}>
            {(timer % 2 === 0)? 'EVEN' : 'The number is: ODD'}
          </Text>
        </View>
      )}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleStop()}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'add':
            setTimer((prevTimer) => prevTimer + 100);
            break;

          case 'reset':
            handleReset();
            break;
        };
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample12-old.png)

![Gif](assets/example-ContextMenuViewExample12.gif)

<br>

### `ContextMenuView` Example 13

[🔗 Full Example](example/src/examples/ContextMenuViewExample13.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample13(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample13',
        menuItems: [{
          actionKey: 'key-01',
          actionTitle: 'Action #1',
          // iOS 13 to 14 (still works on iOS 15+)
          actionSubtitle: 'Action subtitle',
        }, {
          actionKey: 'key-02'   ,
          actionTitle: 'Action #2',
          // iOS 15+ only
          actionSubtitle: 'Lorum ipsum sit amit dolor aspicing',
        }, {
          actionKey: 'key-03'   ,
          actionTitle: 'Action #3',
          actionSubtitle: 'Very long `discoverabilityTitle` lorum ipsum sit amit',
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample13-old.png)

![Gif](assets/example-ContextMenuViewExample13.gif)

<br>

### `ContextMenuView` Example 14

[🔗 Full Example](example/src/examples/ContextMenuViewExample14.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample14(props) {
  return (
    <ContextMenuView
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'rgba(255,255,255,0.75)',
        preferredCommitStyle: 'pop',
      }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
        </View>
      )}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample14-old.png)

![Gif](assets/example-ContextMenuViewExample14.gif)

<br>

### `ContextMenuView` Example 15

[🔗 Full Example](example/src/examples/ContextMenuViewExample15.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample15(props) {
  const [targetViewNode, setTargetViewNode] = React.useState(null);

  const viewRef = React.useRef();

  React.useEffect(() => {
    setTargetViewNode(
      findNodeHandle(viewRef.current)
    );
  }, []);

  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample15',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }],
      }}
      previewConfig={{
        targetViewNode: targetViewNode,
      }}
    >
      <View
        style={styles.targetContainer}
        ref={viewRef}
      >
        <Text style={styles.text}>
          {`Hello! Target Node: ${targetViewNode}`}
        </Text>
      </View>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  targetContainer: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    alignSelf: 'flex-start',
    padding: 10,
    borderRadius: 10,
    marginTop: 10,
  },
  text: {
    fontSize: 16,
  }
});
```

![screenshot](assets/example-ContextMenuViewExample15-old.png)

![Gif](assets/example-ContextMenuViewExample15.gif)

<br>

### `ContextMenuView` Example 16

[🔗 Full Example](example/src/examples/ContextMenuViewExample16.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample16(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample16',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'No Icon',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Use "IMAGE_SYSTEM" icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'dial.fill',
            },
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Use "ASSET" icon',
          icon: {
            type: 'IMAGE_ASSET',
            imageValue: 'icon-rainbow-flag',
          }
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample16-old.png)

![Gif](assets/example-ContextMenuViewExample16.gif)

<br>

### `ContextMenuView` Example 17

[🔗 Full Example](example/src/examples/ContextMenuViewExample17.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewExample17(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample17',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'Blue Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'cloud.heavyrain.fill',
            },
            imageOptions: {
              tint: 'blue',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-02',
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Orange Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'exclamationmark.triangle.fill',
            },
            imageOptions: {
              tint: 'rgb(218,165,32)',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-03',
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Pink Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'heart.fill',
            },
            imageOptions: {
              tint: '#FF1493',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-04',
          actionTitle: 'Action #4',
          discoverabilityTitle: 'Green Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'bubble.right.fill',
            },
            imageOptions: {
              tint: 'rgba(124,252,0,0.5)',
              renderingMode: 'alwaysOriginal',
            },
          },
        }]
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample17-old.png)

![Gif](assets/example-ContextMenuViewExample17.gif)

<br>

### `ContextMenuView` Example 18

[🔗 Full Example](example/src/examples/ContextMenuViewExample18.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuView } from 'react-native-ios-context-menu';

const iconA = Image.resolveAssetSource(
  require('../assets/emoji-pleading-face.png')
);

const iconB = Image.resolveAssetSource(
  require('../assets/emoji-smiling-face-with-hearts.png')
);

const iconC = Image.resolveAssetSource(
  require('../assets/emoji-sparkling-heart.png')
);

export function ContextMenuViewExample18(props) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample18',
        menuItems: [{
          actionKey  : 'key-01'   ,
          actionTitle: 'Action #1',
          discoverabilityTitle: 'Use "REQUIRE" icon',
          // `IconConfig` has been deprecated, please use 
          // `ImageItemConfig` instead (but it'll still work for now).
          // 
          // The other two menu actions in this example 
          // uses `ImageItemConfig` to set the menu action icons. 
          icon: {
            iconType: 'REQUIRE',
            iconValue: iconA,
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Use "IMAGE_REQUIRE" icon',
          icon: {
            type: 'IMAGE_REQUIRE',
            imageValue: iconB,
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Use "IMAGE_REQUIRE" icon',
          icon: {
            type: 'IMAGE_REQUIRE',
            imageValue: iconC,
          }
        }],
      }}
    >
      {/** Components */}
    </ContextMenuView>
  );
};
```

![screenshot](assets/example-ContextMenuViewExample18-old.png)

![Gif](assets/example-ContextMenuViewExample18.gif)

<br>

### `ContextMenuView` Auxiliary Preview - Example 01

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample01.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 02

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample02.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 03

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample03.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 04

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample04.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 05

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample05.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 06

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample06.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 07

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample07.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 08

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample08.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 09

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample09.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 10

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample10.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 11

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample11.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 12

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample12.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 13

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample13.tsx)

```jsx
TBA
```

<br>

### `ContextMenuView` Auxiliary Preview Example 14

[🔗 Full Example](example/src/examples/ContextMenuAuxPreviewExample14.tsx)

```jsx
TBA
```

<br>

### `ContextMenuButton` Example 01

[🔗 Full Example](example/src/examples/ContextMenuButtonExample01.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...

import { ContextMenuButton } from 'react-native-ios-context-menu';

export function ContextMenuButtonExample01() {
  return (
    <ContextMenuButton
      menuConfig={{
        menuTitle: 'ContextMenuButtonSimpleExample01',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
          }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      {/** Components */}
    </ContextMenuButton>
  );
};
```

![screenshot](assets/example-ContextMenuButtonExample01-old.png)

![Gif](assets/example-ContextMenuButtonExample01.gif)

<br>

### `ContextMenuButton` Example 02

[🔗 Full Example](example/src/examples/ContextMenuButtonExample02.tsx)

```jsx
 // 📝 Note: for the sake of brevity, some of the code is omitted...
import { ContextMenuButton } from 'react-native-ios-context-menu';

export function ContextMenuButtonExample02(props) {
  return (
    <ContextMenuButton
      isMenuPrimaryAction={true}
      menuConfig={{
        menuTitle: 'ContextMenuButtonSimpleExample02',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'dial.fill',
            },
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'archivebox.fill',
            },
          }
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      {/** Components */}
    </ContextMenuButton>
  );
};
```

![screenshot](assets/example-ContextMenuButtonExample02-old.png)

![Gif](assets/example-ContextMenuButtonExample02.gif)

<br><br>

## F. Showcase, Tests and Demos

<br><br>

## G. Meta

<br><br>

## H. Licence

MIT