# react-native-ios-context-menu
A react native component to use [￼`UIMenu`￼](https://developer.apple.com/documentation/uikit/uimenu) on iOS 13 and later.
* Support for creating menu actions and submenu's (nested menu's)
* Support for the iOS 14 functionality (like the `UIButton` menu, and updating the menu while its visible).
* Support for setting (almost) all of the native [￼`UIMenu`￼](https://developer.apple.com/documentation/uikit/uimenu) and ￼[￼`UIAction`￼￼](https://developer.apple.com/documentation/uikit/uiaction) properties,
* `ActionSheetIOS` menu fallback for unsupported iOS versions.
* Support for custom context menu previews.

<br>

<details open>
  <summary>Show/Hide Gifs</summary>

`ContextMenuView` **Left**: [Example 1](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample01.js), [Example 2](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample02.js), and **Right**: [Example 3](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample03.js), [Example 4](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample04.js)
![Simple Example 1 to 4 Gifs](./assets/context-menu-view-gifs/ContextMenuView-SimpleExample-1-2-3-4.gif)

`ContextMenuView` **Left**: [Example 5](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample05.js), [Example 6](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample06.js), and **Right**: [Example 7](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample07.js), [Example 8](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample08.js)
![Simple Example 5 to 8 Gifs](./assets/context-menu-view-gifs/ContextMenuView-SimpleExample-5-6-7-8.gif)

`ContextMenuView` **Left**: [Example 9](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample09.js), and **Right**: [Example 10](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample10.js)
![Simple Example 9 and 8 Gifs](./assets/context-menu-view-gifs/ContextMenuView-SimpleExample-9-10.gif)

`ContextMenuView` **Left**: [Test 1](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest01.js), and **Right**: [Test 2](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest02.js)
![Context Menu View Test 1 and 2 Gifs](./assets/context-menu-view-gifs/ContextMenuView-Test-01-02.gif)

`ContextMenuView` **Left**: [Test 3](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest03.js), and **Right**: [Test 4](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest04.js)
![Context Menu View Test 3 and 4 Gifs](./assets/context-menu-view-gifs/ContextMenuView-Test-03-04.gif)

`ContextMenuView` **Left**: [Test 5](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest05.js), and **Right**: [Test 6](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest06.js)
![Context Menu View Test 5 and 6 Gifs](./assets/context-menu-view-gifs/ContextMenuView-Test-05-06.gif)

`ContextMenuView` `ActionSheetIOS` fallback for simple example 1 to 9
![Action Sheet Fallback for Simple Example 1 to 9 Gifs](./assets/context-menu-view-gifs/ContextMenuView-ActionSheetFallback-SimpleExample-1-to-9.gif)

`ContextMenuView` `ActionSheetIOS` fallback for context menu view test 1 to 6
![Action Sheet Fallback for Context Menu View Test 1 to 6 Gifs](./assets/context-menu-view-gifs/ContextMenuView-ActionSheetFallback-Test-1-to-6.gif)

`ContextMenuButton` **Left**: [Example 1](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuButton/ContextMenuButtonSimpleExample01.js), and **Right**: [Example 2](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuButton/ContextMenuButtonSimpleExample02.js)
![Simple Example 1 and 2 Gifs](./assets/context-menu-button-gifs/ContextMenuButton-SimpleExample-1-2.gif)

</details>

---
### 🚧⚠️ Documentation WIP 🚧⚠️
(iOS 14 specific features also in WIP — Check [TODO](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/docs/TODO.md) for progress)
<br>

## 1. Installation

```sh
# install via NPM
npm install react-native-ios-context-menu

# or install via yarn
yarn add react-native-ios-context-menu

# then run pod install (uses autolinking)
cd ios && pod install
```

<br>

### 1.1 Installation Notes
This library is written in Swift. If you are having trouble building your app after installing this library, try adding an empty swift file:
1. Open up your `ios/project.xcworkspace` project
2. On the project navigator panel (located on the right side of Xcode), right click on your project group (or another folder/group i.e the blue or yellow icons) and select the "*New File...*" option
3. In the popup sheet, select "Swift" as the template and then click the "*Next*" button
4. A "*Save As*" popup sheet should appear and then click "*Create*" (you can rename the file first if you want to)
5. If Xcode asks you to create a "*Objective-C Bridging Header*" choose *"Create Objective-C Bridging Header"*

<br>

## 2. Usage
### 2.1 `ContextMenuView` Usage
Please check out the [examples section](#41-contextmenuview-examples) or the [examples directory](https://github.com/dominicstop/react-native-ios-context-menu/tree/master/example/src/components/ContextMenuView) for more on how to use it.
* See  [Example 1](#411-contextmenuview-simple-example-1) section for the basic `menuConfig` configuration, and [Example 9](#419-contextmenuview-simple-example-9) for basic menu-related events usage.
* See [Example 11](#4111-contextmenuview-simple-example-11), and [Example 12](#4112-contextmenuview-simple-example-12) for details on how to show a custom context menu preview.
* See [`MenuConfig`](#332-menuconfig-object) and [￼`MenuAction`￼](h#331-menuaction-object) section for the list of properties you can use on the `menuConfig` prop.

```jsx
import { ContextMenuView } from "react-native-ios-context-menu";

<ContextMenuView
  onPressMenuItem={({nativeEvent}) => {
    alert(`${nativeEvent.actionKey} was pressed`);
  }}
  menuConfig={{
    menuTitle: 'Context Menu Example',
    menuItems: [{
      actionKey  : 'action-key',
      actionTitle: 'Action #1' ,
    }]
  }}
>
  <Text> Hello World </Text>
</ContextMenuView>
```

<br>

**Note**: This component is only available on iOS 13+. Use the [￼`Platform`￼](https://reactnative.dev/docs/platform-specific-code#platform-module) module to handle logic if `ContextMenuView` is not available i.e. by adding your own `onLongPress` handler. 
* By default, on iOS 12 and below, a long press on a `ContextMenuView` will show a `ActionSheetIOS` menu based on the `menuConfig` prop. If you want to disable this behavior, set `useActionSheetFallback` prop to false.
* This component is just a regular view on Android, so a long press will do nothing on Android.

<br>

### 2.2 `ContextMenuButton` Usage
Please check out the [examples section](#42-contextmenubutton-examples) or the [examples directory](https://github.com/dominicstop/react-native-ios-context-menu/tree/master/example/src/components/ContextMenuButton) for more on how to use it. See  [Example 1](#421-contextmenubutton-simple-example-1) section for the basic `menuConfig` configuration. 
* The `ContextMenuButton` component is almost the same as the `ContextMenuView` component (It supports the same kind of props and events). 
* The only difference between them is that the `ContextMenuButton` component does not have a preview, and it can be immediately shown when its tapped instead of having to do a long press. See [Simple Example 2](#422-contextmenubutton-simple-example-2) for more details.
* Note that `ContextMenuButton` is only available on iOS 14 and above. On iOS 13, it will use a `ContextMenuButton`, and on iOS 12 and below, it will use the `ActionSheetFallback` module to present a `ActionSheetIOS` menu.

```jsx
import { ContextMenuButton } from "react-native-ios-context-menu";

<ContextMenuButton
  onPressMenuItem={({nativeEvent}) => {
    alert(`${nativeEvent.actionKey} was pressed`);
  }}
  menuConfig={{
    menuTitle: 'Context Menu Example',
    menuItems: [{
      actionKey  : 'action-key',
      actionTitle: 'Action #1' ,
    }]
  }}
>
  <Text> Hello World </Text>
</ContextMenuView>
```

<br>

## 3. Documentation
### 3.1 Modules/Components
#### 3.1.1 `ContextMenuView` Component Props

| Prop                     | Type                                                         | Description                                                  |
|--------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| `menuConfig`             | **Required**:  [￼`MenuConfig`￼](#332-menuconfig-object) Object | An object that represents the menu to display. You can use state if you want to dynamically change the menu configuration: See `ContextMenuView` [Test 3](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest03.js), [Test 4](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest04.js) and [Test 6](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewTest06.js) for examples. Check the [`MenuConfig`](#332-menuconfig-object) section for the object's structure/properties. On iOS 14+ the menu config can be updated while it's visible. |
| `useActionSheetFallback` | **Optional**: `Bool`                                         | If set to true, a long press will show a [￼`ActionSheetIOS`](https://reactnative.dev/docs/actionsheetios#docsNav) menu based on the `menuConfig` prop. Default value is `false` on iOS 13+ and true on android, and on iOS 12 and below. |
| `previewType`            | **Optional**: `String` i.e. a `PreviewType` enum value       | **Default**: `DEFAULT` — Configures what to use for the context menu preview. |
| `previewSize`            | **Optional**: `{width: Number, height: Number} Object`       | **Default**: `null` — The size of the context meu preview. By default, it wil try to fill the entire screen. |
| `lazyPreview`            | **Optional**: `Bool`                                         | **Default**: `true` — By default, the context mrenu preview is only mounted/rendered when the context menu is visible. Set this to `false` if you want the preview to be always mounted. |
| `renderPreview`          | **Optional**: `Function`                                     | Accepts a function that returns a react component. The returned component will displayed in the context menu preview. See  section [Example #11](#4111-contextmenuview-simple-example-11) and [Example #12](#4112-contextmenuview-simple-example-12) for more details. |
| `onMenuWillShow`         | **Event**: Function                                          | Event that gets called **before** the context menu is  shown, i.e. this event is immediently invoked when the menu is about to become visible. |
| `onMenuDidShow`          | **Event**: Function                                          | Event that gets called **after** the context menu is completely shown, i.e. this event is invoked after the menu entrance animation is finished. |
| `onMenuWillHide`         | **Event**: Function                                          | Event that gets called **before** the context menu is  hidden, i.e. this event is immediently invoked when the menu is about to become hidden. |
| `onMenuDidHide`          | **Event**: Function                                          | Event that gets called **after** the context menu is completely hidden, i.e. this event is invoked after the menu exit animation is finished. |
| `onMenuWillCancel`       | **Event**: Function                                          | Event that gets called when the menu is cancelled and **before** the context menu is  hidden, i.e. this event is immediently invoked when the menu is cancelled and about to become hidden. |
| `onMenuDidCancel`        | **Event**: Function                                          | Event that gets called when the menu is cancelled and **after** the context menu is completely hidden, i.e. this event is invoked when the menu is cancelled and the menu exit animation is finished. |
| `onPressMenuItem`        | **Event**: Function: `onPressMenuItem({nativeEvent})`        | Event that gets called when a menu action is pressed. You can identify which action was pressed via `nativeEvent.actionKey `. Check out the [onPressMenuItem Object](#333-onpressmenuitem-nativeevent-object) section for more details or [Simple Example #9](#419-contextmenuview-simple-example-9) section. |
| `onPressMenuPreview`     | **Event**: Function                                          | Event that gets called when the menu's preview is pressed.   |

<br>

#### 3.1.2 `ContextMenuButton` Component Props

| Prop                     | Type                                                 | Description                                                  |
|--------------------------|------------------------------------------------------|--------------------------------------------------------------|
| `menuConfig`             | **Required**:  `MenuConfig` Object                   | Same as `ContextMenuView`                                    |
| `enableContextMenu`      | **Optional**: `Bool`                                 | Default: `true` — Whether or not the context menu is enabled. |
| `isMenuPrimaryAction`    | **Optional**: `Bool`                                 | Default: `false` — When set to true, the context menu will be shown when its tapped instead of a long press. |
| `wrapNativeComponent`    | **Optional**: `Bool`                                 | Default: `true` — When true, the `ContextMenuButton` component is wrapped inside a `TouchableOpacity` component and it handles all of the `onPress` and `onLongPress` events. If you want to use a different "button" component, set this prop to false first and wrap the `ContextMenuButton` in your own custom button component. |
| `useActionSheetFallback` | **Optional**: `Bool`                                 | Same as `ContextMenuView`                                    |
| `onMenuWillShow`         | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onMenuDidShow`          | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onMenuWillHide`         | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onMenuDidHide`          | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onMenuWillCancel`       | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onMenuDidCancel`        | **Event**: Function                                  | Same as `ContextMenuView`                                    |
| `onPressMenuItem`        | **Event**: Function `onPressMenuItem({nativeEvent})` | Same as `ContextMenuView`                                    |
<br>

#### 3.1.2 `ActionSheetFallback` Module
A module to show a `ActionSheetIOS` menu based on a `MenuConfig` object. This module attempts to approximate `UIMenu` behavior using `ActionSheetIOS`, so it's very limited (i.e. it does not support menu/action icons, etc.) but it does support things like submenu's, destructive actions/menu's, inline submenu's, and hidden actions.
* Import the module like this: `import { ActionSheetFallback } from "react-native-ios-context-menu";`
* To present a ￼￼`ActionSheetIOS` menu, call `const selectedAction = await ActionSheetFallback.show(menuConfig)`


| Function                                    | Returns                       | Description                                                  |
|---------------------------------------------|-------------------------------|--------------------------------------------------------------|
| `async show(menuConfig: MenuConfig Object)` | `MenuAction Object` or `null` | This function accepts a `MenuConfig` object and returns the selected `MenuAction` object or null if cancelled. |

<br>

### 3.2 Enum Values
#### 3.2.1 `ImageTypes` Enum
Enum values of strings you can use for `MenuConfig.imageType` or `MenuAction.imageType`.
* Import the enum like this: `import { ImageTypes } from "react-native-ios-context-menu";`
* And use it  like this: `imageType: ImageTypes.SYSTEM` 
* Or you can directly pass a string like this: `imageType: 'SYSTEM'`
* Check out the [￼`ContextMenuView`￼ Simple Example #2](#412-contextmenuview-simple-example-2) section for example usage.

<br>

| Value  | Description                                                  |
|--------|--------------------------------------------------------------|
| NONE   | The default value for the `imageType` property. Specifies to not use an icon. Since this is the default value, you don't have to explicitly specify: `imageType: 'NONE'` in the `MenuConfig` or `MenuAction` object if you don't want to use an icon. |
| SYSTEM | Specifies that we want to a system image (i.e. like a  [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) icon). Internally, it passes the `imageValue` string from the `MenuConfig` or `MenuAction` object like this: `UIImage(systemName: imageValue)` |
<br>

#### 3.2.2 `MenuOptions` Enum
Enum values of strings you can use in a `MenuConfig` object (i.e. in the `MenuConfig.menuOptions` property). These string values corresponds to the swift/objc-c  `UIMenu.Options` struct, please check the [Apple Docs](https://developer.apple.com/documentation/uikit/uimenu/options) for more info. 
* Import the enum like this: `import { MenuOptions } from "react-native-ios-context-menu";`
* And use it  like this: `menuOptions: [MenuOptions.destructive`] 
* Or you can directly pass a string like this: `menuOptions: ['destructive']`
* Check out `ContextMenuView` [Simple Example #5](#415-contextmenuview-simple-example-5) and [Simple Example #6](#416-contextmenuview-simple-example-6) section for example usage.

<br>

| Value           | Description                                                  |
|-----------------|--------------------------------------------------------------|
| `destructive`   | An option indicating the menu's appearance represents a destructive action. This will tint the submenu title and it's icon to red (the submenu's elements will be unaffected). |
| `displayInline` | An option indicating the menu displays inline with its parent menu instead of displaying as a submenu. If you set a submenu to `menuOptions: 'displayInline'`, it will create a "section" in the parent menu. |

<br>

#### 3.2.3 `MenuElementAtrributes` Enum
Enum values of strings you can use in a `MenuAction` object (i.e. in the `MenuAction.menuAttributes` property). These string values corresponds to the swift/obj-c `UIMenuElement.Attributes` struct, please check the [Apple Docs](https://developer.apple.com/documentation/uikit/uimenuelement/attributes) for more info.
* Import the enum like this: `import { MenuElementAtrributes } from "react-native-ios-context-menu";`
* And use it  like this: `menuAttributes: [MenuElementAtrributes.destructive]` 
* Or you can directly pass a string like this: `menuAttributes: ['destructive']`
* Check out [Simple Example #4](#414-contextmenuview-simple-example-4) section for example usage.

<br>

| Value         | Description                                                  |
|---------------|--------------------------------------------------------------|
| `hidden`      | An attribute indicating the hidden style. This will hide the menu action i.e the menu action will no longer be visible in the menu. You can use this to temporarily hide a menu action (via state). |
| `disabled`    | An attribute indicating the disabled style. This will tint the menu action's title and icon to grey, and will also prevent the user from selecting/pressing the menu action. |
| `destructive` | An attribute indicating the destructive style. This will tint the menu action's title and icon to red. |

<br>

#### 3.2.4 `UIMenuElementState` Enum
Enum values of strings you can use in a `MenuAction` object (i.e. in the `MenuAction.menuState` property). These string values corresponds to the swift/obj-c  `UIMenuElementState ` struct, please check the [Apple Docs](https://developer.apple.com/documentation/uikit/uimenuelement/state) for more info.
* Import the enum like this: `import { UIMenuElementState } from "react-native-ios-context-menu";`
* And use it  like this: `menuState: UIMenuElementState.on` 
* Or you can directly pass a string like this: `menuState: 'on'`
* Check out [￼`ContextMenuView`￼ Simple Example #8](#418-contextmenuview-simple-example-8) section for example usage.

<br>

| Value   | Description                                                  |
|---------|--------------------------------------------------------------|
| `on`    | Indicates that the menu element is in the “on” state. Visually, on iOS 13 it will replace the menu action's icon with a checkmark, meanwhile on iOS 14 it will show a checkmark on the left of the menu label. |
| `off`   | Indicates that the menu element is in the “off” state.       |
| `mixed` | Indicates that the menu element is in the “mixed” state. Visually, (at least on iOS 13) it will replace the menu action's icon with a checkmark (same as the `on` state). |
<br>

#### 3.2.4 `PreviewType` Enum
Enum values of strings you can use in the `ContextMenuView` `PreviewType` prop.
* Import the enum like this: `import { PreviewType } from "react-native-ios-context-menu";`
* And use it  like this: `previewSize={PreviewType.CUSTOM}` 
* Or you can directly pass a string like this: `previewSize={'CUSTOM'}` 

| Value     | Description                                                  |
|-----------|--------------------------------------------------------------|
| `DEFAULT` | The default value for the `previewSize` prop. Indicates that we don't want to use a custom context menu preview. |
| `CUSTOM`  | Indicates that we want to use a custom context menu preview. |
<br>

### 3.3 Object Types
#### 3.3.1 `MenuAction` Object
An object that is used to display/create a context menu action or a submenu action. This object represents a [￼￼`UIAction`￼￼](https://developer.apple.com/documentation/uikit/uiaction) instance. This object is used inside a `MenuConfig` object's `menuItems` property.

<br>

| Key/Property           | Type                                                         | Description                                                  |
|------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| `actionKey`            | **Required**: `String`                                       | A string that is used to identify a menu action. You will receive this value in the `onPressMenuItem({nativeEvent})` event. |
| `actionTitle`          | **Required**: `String`                                       | The text to display in the menu action.                      |
| `imageType`            | **Optional**: `String` (`ImageTypes` value)                  | Configures the menu action's icon. Check out  the [￼￼`ImageTypes`￼￼](#321-imagetypes-enum) section. |
| `imageValue`           | **Optional**: `String`                                       | String value used to for the menu actions's icon.            |
| `menuState`            | **Optional**: `String` (`UIMenuElementState` value)          | Check the [￼`UIMenuElementState`￼](#324-uimenuelementstate-enum) section for the list of values to use. |
| `menuAttributes`       | **Optional**: `[String]` (Array of `MenuElementAtrributes` values) | Options to change the look/behaviour of the menu action. Check out  the ￼[￼`MenuOptions`￼](#322-menuoptions-enum) section for the list of values to use. |
| `discoverabilityTitle` | **Optional**: `String`                                       | A string that is used to set a `UIAction`'s [`discoverabilityTitle`](https://developer.apple.com/documentation/uikit/uiaction) property. Visually, this property shows a subtitle for the menu action. See [Example 13](#4113-contextmenuview-simple-example-13) |
<br>

#### 3.3.2 `MenuConfig` Object
An object that is used to display/create a context menu or a submenu. This object represents  a [￼`UIMenu`￼](https://developer.apple.com/documentation/uikit/uimenu) instance.

<br>

| Key/Property  | Type                                                         | Description                                                  |
|---------------|--------------------------------------------------------------|--------------------------------------------------------------|
| `menuTitle`   | **Required**: `String`                                       | The title of the menu.                                       |
| `menuOptions` | **Optional**: `[String]` (Array of `MenuOptions` values)     | Options to change the look/behaviour of the menu. Check out  the [￼`MenuOptions`￼](#322-menuoptions-enum) section for the list of values to use. |
| `imageType`   | **Optional**: `String` (`ImageTypes` value)                  | Configures the menu action's icon. Check out  the [￼￼`ImageTypes`￼￼](#321-imagetypes-enum) section. |
| `imageValue`  | **Optional**: `String`                                       | String value used to for the menu's icon.                    |
| `menuItems`   | **Optional**: `[Object]` (An array of either `MenuAction` object or `MenuConfig`) | The items to display in a menu. if you pass a `MenuAction` it will create a menu action element, and if you pass a `MenuConfig` object, it will create a submenu. |

<br>

#### 3.3.3 `onPressMenuItem` `nativeEvent` Object
The `nativeEvent` object that you receive inside the `onPressMenuItem` event. The `nativeEvent` object basically just contain the `MenuAction` object that was selected in the context menu. Use the `actionKey` property to identify which action was selected.

<br>

```js
{
  "actionKey": "key-01",
  "imageType": 'SYSTEM',
  "actionTitle": "Action #1",
  "imageValue": "folder",
  "menuAttributes": [],
  "target": 1175
}
```

<br>

## 4 Examples
Check out the [examples](https://github.com/dominicstop/react-native-ios-context-menu/tree/master/example) directory. The example app contains a bunch of demos that showcases the different `ContextMenuView` configurations, props and events you can use. The [assets](https://github.com/dominicstop/react-native-ios-context-menu/tree/master/assets) directory contains gifs and screenshots for every example/test demoed in the example app.

1. Clone the repository: `git clone https://github.com/dominicstop/react-native-ios-context-menu.git`
2. `cd react-native-ios-context-menu && yarn bootstrap`
3. Go to the `react-native-ios-context-menu/example` directory and run `yarn ios` to build/launch the example app in the iOS simulator.

<br>

### 4.1 `ContextMenuView` Examples
#### 4.1.1 `ContextMenuView` [Simple Example #1](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample01.js)
A plain context menu configured with 3 actions (no icons, just text).

<br>

```jsx
<ContextMenuView
  // `menuConfig` prop accepts a `MenuConfig` object
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample01', // title of our menu
    // a `MenuConfig` object has `menuItems` property
    // which is an array of `MenuConfig` or `MenuAction` object
    // these are the items we want to show in our menu
    menuItems: [{
	   // a menu action config item  - `MenuAction` object
      // represents an menu item that we want to show in our menu
      actionKey  : 'key-01'   , // an id for your action
      actionTitle: 'Action #1', // text to display in your menu action
    }, {
      // another `MenuAction` object item
      actionKey  : 'key-02'   ,
      actionTitle: 'Action #2',
    }, {
      // and another `MenuAction` object item
      actionKey  : 'key-03'   ,
      actionTitle: 'Action #3',
    }],
  }}
/>
```

![Simple Example 1](./assets/example-screenshots/ContextMenuView-SimpleExample01.png)

<br>

#### 4.1.2 `ContextMenuView` [Simple Example #2](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample02.js)
A menu configured with 3 actions with "system" [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) icons.

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample02',
    menuItems: [{
      // a menu action config item (i.e. a `MenuAction` object)
      actionKey  : 'key-01'   ,
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM'   , // indicates that we want to use SF Symbols
      imageValue : 'folder'   , // the icon string of SF Symbols icon
    }, {
      // another `MenuAction` object item
      actionKey  : 'key-02'   ,
      actionTitle: 'Action #2',
      imageType  : 'SYSTEM'   , // don't forget to add this property/key
      imageValue : 'dial.fill', // a SF symbol has other variants for an icon
    }, {
      // and another `MenuAction` object item
      actionKey  : 'key-03'   ,
      actionTitle: 'Action #3',
      imageType  : 'SYSTEM'   , // <- set `imageType` to "SYSTEM"
      imageValue : 'archivebox.fill', // <- provide a SF Symbols icon string
    }],
  }}
/>
```

![Simple Example 2](./assets/example-screenshots/ContextMenuView-SimpleExample02.png)

<br>

#### 4.1.3 `ContextMenuView` [Simple Example #3](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample03.js)
A context menu  configured with 1 action, and a submenu (with 3 submenu actions)
* A  `MenuConfig` object has a property called `menuItems` which accepts an array of objects. Those objects can either be a  `MenuAction` item or another `MenuConfig` item.
* If you pass a `MenuConfig` object to `menuItems`, it will make a submenu. 

<br>

```js
<ContextMenuView
  // `menuConfig` prop accepts a `MenuConfig` object
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample03', // title of our menu
    // a `MenuConfig` object has `menuItems` property
    // which is an array of `MenuConfig` or `MenuAction` object
    // these are the items we want to show in our menu
    menuItems: [{
      // a menu action config item - `MenuAction` object
      actionKey  : 'key-01',
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
    }, {
      // a menu config item, i.e. a submenu - `MenuConfig` object
      // the `menuItems` property can accept an array of both a `MenuAction`
      // object and a `MenuConfig` object. If we pass a `MenuConfig` object
      // this means that we want to show another menu i.e. a submenu
      menuTitle: 'Submenu...', // the title of submenu

      // Since this is a `MenuConfig` object, we have a `menuItems` property.
      // This represents the items that we want to show in our submenu.
      // An array of `MenuAction` or `MenuConfig` object. If you want another 
      // submenu in your submenu, pass a `MenuConfig` object.
      menuItems: [{
        // a menu action config item - `MenuAction` object
        actionKey  : 'key-01-01',
        actionTitle: 'Submenu Action #1',
        imageType  : 'SYSTEM',
        imageValue : 'star',
      }, {
        // another `MenuAction` object item
        actionKey  : 'key-01-02',
        actionTitle: 'Submenu Action #2',
        imageType  : 'SYSTEM',
        imageValue : 'star.lefthalf.fill',
      }, {
        // and another `MenuAction` object item
        actionKey  : 'key-01-03',
        actionTitle: 'Submenu Action #3',
        imageType  : 'SYSTEM',
        imageValue : 'star.fill',
      }]
    }],
  }}
/>
```

![Simple Example 3](./assets/example-screenshots/ContextMenuView-SimpleExample03.png)

<br>

#### 4.1.4 `ContextMenuView` [Simple Example #4](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample04.js)
A example context menu with a "*disabled*" action, a "*destructive*" action, a "*hidden*" action (which is not visible in the context menu), and a "*disabled + destructive*" action.
* A  `MenuAction` object can have an optional `menuAttributes` property. The `menuAttributes` property accepts an array of strings (i.e a `MenuElementAtrributes` item).

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample04',
    menuItems: [{
      // a menu action config item (i.e. a `MenuAction` object)
      // but we set an optional property called `menuAttributes`
      // we set the `menuAttributes` to `disabled` which will prevent
      // this menu action item to selected/pressed
      actionKey     : 'key-01',
      actionTitle   : 'Disabled Action',
      imageType     : 'SYSTEM',
      imageValue    : 'folder',
      menuAttributes: ['disabled'] // disable this menu action
    }, {
      // another `MenuAction` object item
      // but this time we make the action "destructive"
      // will tint the menu action item's text/icon bright red
      actionKey     : 'key-02'   ,
      actionTitle   : 'Destructive Action',
      imageType     : 'SYSTEM',
      imageValue    : 'trash',
      menuAttributes: ['destructive'] // make menu action "destructive"
    }, {
      // and another `MenuAction` object item
      // but this time we make the action "hidden"
      // will make the menu action item not appear in the menu
      actionKey     : 'key-03',
      actionTitle   : 'Hidden Action',
      imageType     : 'SYSTEM',
      imageValue    : 'trash',
      menuAttributes: ['hidden'] // make menu action "hidden"
    }, {
      // and yet another `MenuAction` object item
      // but this time we make the action both "hidden" and "disabled"
      // looks the same as `menuAttributes: ['disabled']`
      actionKey     : 'key-04',
      actionTitle   : 'Disabled/Destructive',
      imageType     : 'SYSTEM',
      imageValue    : 'trash.fill',
      menuAttributes: ['disabled', 'destructive'] // <- set `menuAttributes`
    }],
  }}
/>
```

![Simple Example 4](./assets/example-screenshots/ContextMenuView-SimpleExample04.png)

<br>

#### 4.1.5 `ContextMenuView` [Simple Example #5](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample05.js)
A context menu that has a "*displayInline*" submenu. This is the same as [Simple Example #3](https://github.com/dominicstop/react-native-ios-context-menu#413-contextmenuview-simple-example-3) but we set the `MenuConfig`'s optional `menuOptions` property to `["displayInline"]`. Visually, this creates a "section" in the parent menu (i.e it add top and bottom separators).

<br>

```jsx
<ContextMenuView
  // `menuConfig` prop accepts a `MenuConfig` object
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample05',
    menuItems: [{
      // a menu action config item (i.e. a `MenuAction` object)
      actionKey  : 'key-01',
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
    }, {
      // a menu config item, i.e. a submenu - `MenuConfig` object
      // but this time we make it an inline submenu.
      // A `MenuConfig` object has an optional `menuOptions` property.
      menuTitle: 'Submenu...',
      menuOptions: ['displayInline'], // <- set the `menuOptions` property
      menuItems: [{
        // a `MenuAction` object
        actionKey  : 'key-01-01',
        actionTitle: 'Submenu Action #1',
        imageType  : 'SYSTEM',
        imageValue : 'star',
      }, {
        // another `MenuAction` object
        actionKey  : 'key-01-02',
        actionTitle: 'Submenu Action #2',
        imageType  : 'SYSTEM',
        imageValue : 'star.lefthalf.fill',
      }, {
        // yet another `MenuAction` object
        actionKey  : 'key-01-03',
        actionTitle: 'Submenu Action #3',
        imageType  : 'SYSTEM',
        imageValue : 'star.fill',
      }]
    }]
  }}
/>
```

![Simple Example 5](./assets/example-screenshots/ContextMenuView-SimpleExample05.png)

<br>

#### 4.1.6 `ContextMenuView` [Simple Example #6](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample06.js)
A context menu that has a "*destructive*" submenu. This is the same as [Simple Example #3](#413-contextmenuview-simple-example-3) but we set the `MenuConfig`'s optional `menuOptions` property to `['destructive']`

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample06',
    menuItems: [{
      // a `MenuAction` object
      actionKey  : 'key-01',
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
    }, {
      // a `MenuConfig` object i.e a submenu
      menuTitle: 'Submenu...',
      menuOptions: ['destructive'], // <- set the `menuOptions` property
      menuItems: [{
        // a submenu action i.e `MenuAction` object
        actionKey  : 'key-01-01',
        actionTitle: 'Submenu Action #1',
        imageType  : 'SYSTEM',
        imageValue : 'star',
      }, {
        // another submenu `MenuAction` object
        actionKey  : 'key-01-02',
        actionTitle: 'Submenu Action #2',
        imageType  : 'SYSTEM',
        imageValue : 'star.lefthalf.fill',
      }, {
        // and another submenu `MenuAction` object
        actionKey  : 'key-01-03',
        actionTitle: 'Submenu Action #3',
        imageType  : 'SYSTEM',
        imageValue : 'star.fill',
      }]
    }],
  }}
/>
```

![Simple Example 6](./assets/example-screenshots/ContextMenuView-SimpleExample06.png)

<br>

#### 4.1.7 `ContextMenuView` [Simple Example #7](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample07.js)
A context menu that has a "*displayInline*" and "*destructive*" submenu. This is the same as [Simple Example #3](#413-contextmenuview-simple-example-3) but we set the `MenuConfig`'s optional `menuOptions` property to `['displayInline', 'destructive']`
* **Note**: Visually, this looks the same as an "*displayInline*" submenu (i.e. [Example #5](#415-contextmenuview-simple-example-5))

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample07',
    menuItems: [{
      actionKey  : 'key-01',
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
    }, {
      menuTitle: 'Submenu...',
	   // set the optional `menuOptions` property
      menuOptions: ['displayInline', 'destructive'],
      menuItems: [{
        actionKey  : 'key-01-01',
        actionTitle: 'Submenu Action #1',
        imageType  : 'SYSTEM',
        imageValue : 'star',
      }, {
        actionKey  : 'key-01-02',
        actionTitle: 'Submenu Action #2',
        imageType  : 'SYSTEM',
        imageValue : 'star.lefthalf.fill',
      }, {
        actionKey  : 'key-01-03',
        actionTitle: 'Submenu Action #3',
        imageType  : 'SYSTEM',
        imageValue : 'star.fill',
      }]
    }],
  }}
/>
```

![Simple Example 7](./assets/example-screenshots/ContextMenuView-SimpleExample07.png)

<br>

#### 4.1.8 `ContextMenuView` [Simple Example #8](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample08.js)
A context menu with 3 actions that has "on", "off", and "mixed" `menuState`
* A  `MenuAction` object can have an optional property called `menuState`.
* `menuState` accepts a string which is a `MenuElementState` item, namely: "*on*", "*off*" and "*mixed*"

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample08',
    menuItems: [{
      // a menu action config item - `MenuAction` object
      // we set the optional `menuState` property to: "on"
      actionKey  : 'key-01',
      actionTitle: 'menuState: on',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
      menuState  : 'on', // <- set the `menuState` property
    }, {
      // another `MenuAction` object
      // but this time we set the optional `menuState` property to: "off"
      actionKey  : 'key-02',
      actionTitle: 'menuState: off',
      imageType  : 'SYSTEM',
      imageValue : 'dial',
      menuState  : 'off', // <- set `menuState` property
    }, {
      // and another `MenuAction` object
      // but this time we set the optional `menuState` property to: "mixed"
      // note: visually, appears the same as `menuState: "on"`
      actionKey  : 'key-03',
      actionTitle: 'menuState: mixed',
      imageType  : 'SYSTEM',
      imageValue : 'archivebox',
      menuState  : 'mixed', // <- set `menuState` property
    }],
  }}
/>
```

<br>

**Left Image**: iOS 13, and **Right Image**: iOS 14
![Simple Example 8](./assets/example-screenshots/ContextMenuView-SimpleExample08.png)

<br>

#### 4.1.9 `ContextMenuView` [Simple Example #9](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample09.js)
A example context menu that uses the `ContextMenuView`'s `onPressMenuItem` and `onPressMenuPreview` event props.

<br>

```jsx
<ContextMenuView
  onPressMenuItem={({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'save':
        alert('saving...');
        break;

      case 'like':
        alert('liking...');
        break;

      case 'play':
        alert('playing...');
        break;
    };
  }}
  onPressMenuPreview={() => alert('onPressMenuPreview')}
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample09',
    menuItems: [{
      actionKey  : 'save',
      actionTitle: 'Save',
      imageType  : 'SYSTEM',
      imageValue : 'square.and.arrow.down',
    }, {
      actionKey  : 'like'         ,
      actionTitle: 'Like'         ,
      imageType  : 'SYSTEM'       ,
      imageValue : 'hand.thumbsup',
    }, {
      actionKey  : 'play'  ,
      actionTitle: 'Play'  ,
      imageType  : 'SYSTEM',
      imageValue : 'play'  ,
    }],
  }}
/>
```

![Simple Example 9](./assets/example-screenshots/ContextMenuView-SimpleExample09.png)

<br>

#### 4.1.10 `ContextMenuView` [Simple Example #10](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample10.js)
On iOS 14 and above, you can update the menu while it's visible. You can update the menu while its open by updating the `menuConfig` prop via state. This is a simple demo with a counter state incrementing every second when the menu is open.

<br>

```jsx
function ContextMenuViewSimpleExample10(props) {
  const [timer, setTimer] = useState(0);
  const increment = useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((timer) => timer + 1);
    }, 1000);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return(
    <ContextMenuView
      onMenuDidShow={handleStart}
      onMenuDidHide={handleReset}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample10',
        menuItems: [{
          actionKey  : 'key-00',
          actionTitle: `Static Action`,
          imageType  : 'SYSTEM',
          imageValue : 'square.and.arrow.down',
        }, {
          actionKey  : 'key-01',
          actionTitle: `timer: ${timer}`, // <- the action title should update
          imageType  : 'SYSTEM',
          imageValue : ((timer % 2 == 0) // <- will show/hide
            ? 'heart'
            : 'heart.fill'
          ),
        }, (timer % 3 == 0) && {
          actionKey  : 'key-02',
          actionTitle: `Dynamic Action`,
          imageType  : 'SYSTEM',
          imageValue : 'scissors.badge.ellipsis',
        }],
      }}
    />
  );
};
```

![Simple Example 10](./assets/example-screenshots/ContextMenuView-SimpleExample10.png)

<br>

#### 4.1.11 `ContextMenuView` [Simple Example #11](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample11.js)
A context menu configured to have a custom preview.
* To show a custom preview, first set the `previewType` prop to `CUSTOM`. Then pass a "render" function in the `renderPreview` prop. The `renderPreview` prop must return a react component.
* The `previewSize` prop is an optional property that sets the preview size. If you don't set the `previewSize` prop, the preview will stretch to fill the screen. 
* The `previewSize` prop accepts an object: `{ width: Number, height: Number }`. If the `width`  property is omitted or null, then it it's default value will be the screen width. Conversely, If the `height`  property is omitted or null, then it it's default value will be the screen height.
* Note, `UIContextMenu` will automatically resize/scale the preview to fit the screen, but it will try to match the values you pass to `previewSize`.

<br>

```jsx
<ContextMenuView
  previewType={'CUSTOM'}
  previewSize={{ height: 200 }}
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
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample11',
  }}
/>
```

![Simple Example 11](./assets/example-screenshots/ContextMenuView-SimpleExample11.png)

<br>

#### 4.1.12 `ContextMenuView` [Simple Example #12](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample12.js)
Another context menu with custom preview example. This example shows a counter in the context menu preview that increments every half a second. The context menu is also configured with a menu action to add 100 to the counter, and an action to reset the counter.

<br>

```jsx
function ContextMenuViewSimpleExample12(props) {
  const [timer, setTimer] = useState(0);
  const increment = useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((timer) => timer + 1);
    }, 500);
  };

  const handleStop = () => {
    clearInterval(increment.current);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return(
    <ContextMenuView
      previewType={'CUSTOM'}
      previewSize={{ height: 200 }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Text style={{fontSize: 32}}>
            {`Counter: ${timer}`}
          </Text>
        </View>
      )}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleStop()}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'add':
            setTimer((timer) => timer + 100);
            break;

          case 'reset':
            handleReset();
            break;
        };
      }}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample12',
        menuItems: [{
          actionKey     : 'add',
          actionTitle   : `Add 100`,
          imageType     : 'SYSTEM',
          imageValue    : 'plus',
        }, (timer > 0) && {
          actionKey     : 'reset',
          actionTitle   : `Reset Counter`,
          imageType     : 'SYSTEM',
          imageValue    : 'trash',
          menuAttributes: ['destructive']
        }],
      }}
    />
  );
};
```

![Simple Example 12](./assets/example-screenshots/ContextMenuView-SimpleExample12.png)

<br>

#### 4.1.13 `ContextMenuView` [Simple Example #13](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuView/ContextMenuViewSimpleExample13.js)
A context menu configured with 3 menu actions with each having a `discoverabilityTitle` value. Visually, this will show 3 menu actions with subtitles below them.

<br>

```jsx
<ContextMenuView
  menuConfig={{
    menuTitle: 'ContextMenuViewSimpleExample13',
    menuItems: [{
      actionKey           : 'key-01',
      actionTitle         : 'Action #1',
      discoverabilityTitle: 'Action subtitle', // <- set the property
    }, {
      actionKey           : 'key-02'   ,
      actionTitle         : 'Action #2',
      discoverabilityTitle: 'Lorum ipsum sit amit dolor aspicing',
    }, {
      actionKey           : 'key-03'   ,
      actionTitle         : 'Action #3',
      discoverabilityTitle: 'Very long `discoverabilityTitle` lorum ipsum sit amit',
    }],
  }}
/>
```

![Simple Example 13](./assets/example-screenshots/ContextMenuView-SimpleExample13.png)

<br>

### 4.2 `ContextMenuButton` Examples
Most of the examples in the `ContextMenuView` section also applies here. The props in `ContextMenuView` (like the `menuConfig` and `useActionSheetFallback` props) as well as most of the events behave the same. So the examples in this section are only for `ContextMenuButton`.

<br>

#### 4.2.1 `ContextMenuButton` [Simple Example #1](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuButton/ContextMenuButtonSimpleExample01.js)
A plain context menu button configured with 3 actions (no icons, just text). A long press on the `ContextMenuButton` component will show the context menu.

<br>

```jsx
<ContextMenuButton
  onPress={() => alert('TouchableOpacity - OnPress')}
  onPressMenuItem={({nativeEvent}) => {
    alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)
  }}
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
/>
```

![Simple Example 1](./assets/example-screenshots/ContextMenuButton-SimpleExample01.png)

<br>

#### 4.2.2 `ContextMenuButton` [Simple Example #2](https://github.com/dominicstop/react-native-ios-context-menu/blob/master/example/src/components/ContextMenuButton/ContextMenuButtonSimpleExample02.js)
A context menu button but we set the `isMenuPrimaryAction` prop to true. Instead of a long press, tapping on the `ContextMenuButton` component will now immediately show the context menu. 

<br>

```jsx
<ContextMenuButton
  onPressMenuItem={({nativeEvent}) => {
    alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`);
  }}
  isMenuPrimaryAction={true} // <- set the prop to true
  menuConfig={{
    menuTitle: 'ContextMenuButtonSimpleExample02',
    menuItems: [{
      actionKey  : 'key-01',
      actionTitle: 'Action #1',
      imageType  : 'SYSTEM',
      imageValue : 'folder',
    }, {
      actionKey  : 'key-02'   ,
      actionTitle: 'Action #2',
      imageType  : 'SYSTEM',
      imageValue : 'dial.fill',
    }, {
      actionKey  : 'key-03'   ,
      actionTitle: 'Action #3',
      imageType  : 'SYSTEM'   ,
      imageValue : 'archivebox.fill',
    }],
  }}
/>
```

![Simple Example 2](./assets/example-screenshots/ContextMenuButton-SimpleExample02.png)

<br>

## License

MIT

<br>

## Links
* I'm [@DominicGo](https://twitter.com/GoDominic) on twitter if you have any questions ✨
* Other libraries: [￼react-native-ios-modal￼](https://github.com/dominicstop/react-native-ios-modal)
* This library was generated/made using [@react-native-community/bob](https://github.com/callstack/react-native-builder-bob)
