## D. Documentation

💡 **Tip**: Most of the time, when a type or component is mentioned, you can click it to jump to that item in the README (or its declaration in the source code).

<br>

### D.1. Components

#### `ContextMenuView` Component

##### `ContextMenuView` Component: Props

| Prop Name and Type                                           | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ⚛️ `ViewProps`                                                | This component supports all the standard props from a `<View/>` component. |
| 🔤  `menuConfig`<br/><br/>⚛️ [`MenuConfig`](PLACE_HOLDER_LINK) | This prop configures the context menu, along with what menu actions to show.<br><br>This prop accepts a `MenuConfig` object. This object is used to configure various aspects of the context menu. Here are some relevant properties:<br><br>1️⃣  `MenuConfig.menuTitle`: the context menu title (required) — if you don't want to show the menu title, pass in an empty string.<br><br/>2️⃣  `MenuConfig.menuItems`: the actions to show (e.g. the title, icons, subtitle, etc) — accepts either an array of `MenuActionConfig` or `MenuConfig` objects.<br><br/>3️⃣  `MenuConfig.menuOptions`: the attributes of the context menu (e.g. destructive) — accepts an array of  `UIMenuOptions` string items, and any nested menus or submenus to show (see "**Note A**"). <br><br>📝 **Note A**: Passing a `MenuConfig` object inside of the `MenuConfig.menuItems` property will result in a nested context menu (i.e. a submenu).<br><br>In this scenario, the `MenuConfig.menuOptions` and `MenuConfig.icon` can be used to configure the appearance of the submenu.<br><br>For usage examples regarding nested menus, see [Example 06](contextmenuview-example06).<br><br>📝 **Note B**: Passing a value of `null` (or `undefined`) to this prop will not disable the context menu. Instead, please use the `isContextMenuEnabled` prop to disable the context menu. <br><br/>📝 **Note C**: You can put `MenuConfig` in state if you want to dynamically change the menu configuration (this will allow you to add/remove submenu items, or update the current menu options).<br><br>If the context menu is currently visible, changing/updating the `MenuConfig` value passed to this prop will cause the context menu to change in real-time. This behavior is only supported on iOS 14+.<br><br>📌 Some example links to get you started:<br>• For basic usage examples regarding `MenuConfig`, see: [Example 1](#contextmenuview-example-06),<br><br/>• For examples on creating + configuring the menu action items (i.e `MenuActionConfig`), see: [Example 2](#contextmenuview-example-02),<br><br/>• For menu action attributes + menu state, and action subtitles, see: [Example 4](#contextmenuview-example-04), [Example 8](#contextmenuview-example-08), and [Example 13](#contextmenuview-example-13),<br><br/>• For examples regarding the usage of icons (i.e `ImageItemConfig`), see: [Example 16](#contextmenuview-example-16), [Example 17](#contextmenuview-example-17), and [Example 18](#contextmenuview-example-18). |
| 🔤  `previewConfig`<br/><br/>⚛️ [`MenuPreviewConfig`](PLACE_HOLDER_LINK) | Configures the context menu's preview.<br><br>If no configuration is provided then it will default to using the context menu component itself as the preview.<br/><br/>📝 **Note**: If you do not want to show a preview (i.e. only show the context menu itself), consider using a [`ContextMenuButton`](PLACE_HOLDER_LINK) component instead.<br/><br/>📌 Some example links to get you started:<br/>• For examples regarding the configuration of the context menu preview (e.g. custom previews), see: [Example 11](#contextmenuview-example-11), [Example 12](#contextmenuview-example-12), [Example 14](#contextmenuview-example-14), and [Example 15](#contextmenuview-example-15). |
| 🔤  `shouldUseDiscoverability`<br>`TitleAsFallbackValueForSubtitle`<br/><br>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | On iOS 15+, the value passed to the  `MenuActionConfig.discoverabilityTitle` property is no longer displayed as a subtitle under the menu action.<br><br>Instead you need to set a different property called `MenuActionConfig.subtitle`.<br><br>The `discoverabilityTitle` property is now used for the "discoverability heads-up display" (e.g when an app supports keyboard shortcuts, holding down the command key presents a list of shortcuts; the `discoverabilityTitle` is then used as the title for the shortcut).<br><br>If this prop is set to true, it will then use the value passed on to the `discoverabilityTitle` value as the subtitle for the menu action, preserving the old behavior. In other words, this prop exists for backwards-compatibility reasons.<br><br>📝 **Note**: This prop is set to `true` by default; set this to `false` if you don't want this automatic behaviour to happen. |
| 🔤  `shouldWaitForMenuToHide`<br/>`BeforeFiringOnPressMenuItem`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | If set to `true` (which it is by default), the `onPressMenuItem` event will be triggered after the context menu has been hidden (i.e. after `onMenuDidHide` event is triggered).<br><br>Set this to `false` if you want `onPressMenuItem` to trigger as soon as an item has been pressed in the context menu.<br><br>📝 **Note**: Layout updates while the context menu is transitioning from it's open to hidden state might cause layout flickering (e.g. [Issue #43](https://github.com/dominicstop/react-native-ios-context-menu/issues/43)). |
| 🔤  `isContextMenuEnabled`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Enables or disables the context menu. Useful if you want to temporarily disable the context menu. |
| 🔤  `lazyPreview`<br/><br/>⚛️ `boolean`<br><br>✳️ **Default**: `true` | If set to `true` (which it is by default), the custom context menu preview (i.e. the component returned from the `ContextMenuView.renderPreview` prop) and the  auxiliary preview (i.e. the component returned from the `ContextMenuView.renderAuxillaryPreview` prop) are only mounted/rendered when the context menu is visible.<br><br>Set this to `false` if you want the preview content to be always mounted. |
| 🔤  `shouldEnable`<br>`AggressiveCleanup`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Deprecated. This prop no longer does anything (see `shouldCleanupOnComponentWillUnmount`<br>`ForMenuPreview`, and `shouldCleanup`<br/>`OnComponentWillUnmountForAuxPreview`<br/>). |
| 🔤  `useActionSheetFallback`<br><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `true` | Context menus are only supported on iOS 13+ (i.e context menus are not supported on iOS 12, and below).<br><br>On iOS 12 and below, a long press on a `ContextMenuView` will show a [`ActionSheetIOS`](https://reactnative.dev/docs/actionsheetios#docsNav) menu based on the current `menuConfig` prop.<br><br> If you want to disable this behavior, set this  prop to false.<br><br>📝 **Note**: Default value is `false` on iOS 13+, and `true` on iOS 12 and below. |
| 🔤  `renderPreview`<br/><br/>⚛️ [`() => React.ReactElement`](PLACE_HOLDER_LINK) | This prop is a "render" prop, i.e it accepts a function that returns a react component.<br><br>The returned component will displayed in the context menu preview. |
| 🔤  `isAuxiliaryPreviewEnabled`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `false` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `auxiliaryPreviewConfig`<br/><br/>⚛️ `MenuAuxiliaryPreviewConfig` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `renderAuxillaryPreview`<br/><br/>⚛️ `() => React.ReactElement` | ⚠️ **Experimental**: Please see [Auxiliary Preview](#contextmenuview-component-experimental---auxiliary-preview) section.<br/><br/>TBA |
| 🔤  `internalCleanupMode`<br/><br/>⚛️ `RNICleanupMode`<br/><br/>✳️ **Default**: `automatic` | Internally, a clean up routine is triggered whenever a component is unmounted.<br><br>However, if the clean up routine is triggered too early, this will lead to the context menu component disappearing (E.g. [issue #34](https://github.com/dominicstop/react-native-ios-context-menu/issues/34)).<br><br>If you are experiencing this issue, you can disable the clean up routine from triggering altogether by setting this prop to `disabled`.<br><br>Additionally, you can also try setting this prop to either to `viewController`, `didMoveToWindowNil`, or `reactComponentWillUnmount`.<br/><br/>`viewController` mode will trigger the clean up routine via the `UIViewController.viewWillDisappear` lifecycle method, and `didMoveToWindowNil` will trigger the cleanup routine during the `UIView.didMoveToWindow` lifecycle method, while the `reactComponentWillUnmount` mode on the other hand, will trigger the clean up routine via the `componentWillUnmount` react lifecycle event. |
| 🔤  `shouldCleanupOnComponent`<br>`WillUnmountForMenuPreview`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `false` | If set to `true`, the custom preview is immediately freed from memory once the context menu is closed.<br/><br/>📝 **Note**: For the immediately cleanup to take effect, the  `lazyPreview` prop also needs to be enabled. |
| 🔤  `shouldCleanupOnComponent`<br/>`WillUnmountForAuxPreview`<br/><br/>⚛️ `boolean`<br/><br/>✳️ **Default**: `false` | If set to `true`, the aux. preview is immediately freed from memory once the context menu is closed.<br/><br/>📝 **Note**: For the immediately cleanup to take effect, the  `lazyPreview` prop also needs to be enabled. |

<br><br>

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
| 🔤  `onMenuAuxiliaryPreviewDidShow`<br/><br/>⚛️ [`DeferredElementProvider`](./src/components/ContextMenuView/ContextMenuViewTypes) i.e. <br>`(deferredID, completion) => void` | This event gets called whenever a `UIDeferredMenuElement` needs to be loaded. A deferred menu element can be created via a `DeferredMenuElementConfig` object.<br><br>A deferred menu is a context menu is basically a placeholder — i.e. it appears as a loading indicator in the context menu.<br><br> When you pass in a `DeferredMenuElementConfig` object to `MenuConfig.menuItems`, it means you want to load and add additional menu items once the context menu is opened.<br><br>This event will provide a `completion` callback — use this to provide the additional context menu items you want to load.<br><br>📝 **Note A**: Deferred menu elements only work on iOS 14+.<br><br>📝 **Note B**: You can dynamically update the context menu items without using the prop — the difference is that deferred menu items will show a placeholder loading indicator when the additional menu items haven't been loaded yet.<br/><br/>📝 **Note C**: It is possible to have multiple deferred menu elements (e.g. deferred elements can also provide deferred elements, and so on).<br><br>Just be sure to use a unique `deferredID` so you can tell them apart.<br/><br/>📌 **Example Usage**:<br/>• [`ContextMenuViewExample19`](#ContextMenuView-Example-19). |

<br>

##### `ContextMenuView` Component: Properties/Methods

| Prop Name and Type                                           | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| 🔤  `dismissMenu`<br/><br/>⚛️ `Promise<Void>`                  | Allows you to  programmatically dismiss the context menu. Only available on iOS 14 and above. |
| 🔤  `presentMenu`<br/><br/>⚛️ `Promise<Void>`                  | Allows you to  programmatically show the context menu.       |
| 🔤  `showAuxiliaryPreviewAsPopover`<br/><br/>⚛️ `Promise<Void>` | Allows you to  programmatically show the auxiliary preview as a popover. |

<br>

##### `ContextMenuView` Component: Experimental - Auxiliary Preview

The context menu auxiliary preview is an experimental feature, and is not officially part of `UIKit`'s "Menu and Shortcuts" API. 

This is just a feature that I've implemented myself and added to the library — as such official support is limited and might break in a future iOS version. Please use at your own risk.

<br>

#### `ContextMenuButton` Component

For basic usage, please see [Example 1](#contextmenubutton-example-01) section.

* The `ContextMenuButton` component is almost the same as the `ContextMenuView` component (It supports the same kind of props and events). <br>

* The only difference between them is that the `ContextMenuButton` component does not have a preview, and it can be immediately shown when its tapped instead of having to do a long press. See [Example 2](#422-contextmenubutton-simple-example-2) for more details.<br>

* Note that `ContextMenuButton` is only available on iOS 14 and above. On iOS 13, it will use a `ContextMenuButton`, and on iOS 12 and below, it will use the `ActionSheetFallback` module to present a `ActionSheetIOS` menu.<br>

* If you want to add additional touch events, you can wrap this component inside a button component (e.g. `TouchableOpacity`). <br>
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

####  `MenuConfig.ts`

* 📌 **Declaration**: [`MenuConfig.ts`](src/types/MenuConfig.ts)

##### Object Type: `MenuConfig`

> A container for grouping related menu elements in an app menu or contextual menu.

An object that is used to create and configure a context menu. Internally, this object is used to create a `UIMenu` instance (see [apple docs](https://developer.apple.com/documentation/uikit/uimenu/) for more information).

<br>

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| 🔤  `type`<br/><br/>⚛️ `string`, i.e`"menu"`                   | TBA                                                          |
| 🔤  `menuTitle`<br/><br/>⚛️ `string`                           | TBA<br><br>📝 **Note**: If you don't want a menu title to appear for your context menu, just pass in an empty string to this property. |
| 🔤  `menuSubtitle`<br/><br/>⚛️ `string`                        | TBA<br/><br/>📝 **Note**: Requires iOS 15+.                   |
| 🔤  `menuOptions`<br/><br/>⚛️ `Array<UIMenuOptions>`<br>📌 [`UIMenuOptions`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `menuPreferredElementSize`<br/><br/>⚛️ `MenuElementSize`   | TBA                                                          |
| 🔤  `menuItems`<br/><br/>⚛️ `MenuElementConfig[]` i.e. <br/>`MenuConfig ¦ MenuActionConfig`<br/>`¦ DeferredMenuElementConfig`<br><br/>📌 [`MenuConfig`](PLACE_HOLDER_LINK)<br/>📌 [`MenuActionConfig`](PLACE_HOLDER_LINK)<br/>📌 [`DeferredMenuElementConfig`](PLACE_HOLDER_LINK) | TBA                                                          |
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

##### Object Type: `DeferredMenuElementConfig`

An object that is used to create a deferred menu element. Internally, this object is used to create a `UIDeferredMenuElement` instance (see [apple docs](https://developer.apple.com/documentation/uikit/uideferredmenuelement) for more information),

| Name and Type                                               | Description |
| ----------------------------------------------------------- | ----------- |
| 🔤 **Required**: `type`<br/><br/>⚛️ `string` i.e. `deferred`. | TBA         |
| 🔤 **Required**: `deferredID`<br/><br/>⚛️ `string`            | TBA         |
| 🔤: `shouldCache`<br/><br/>⚛️ `boolean`                       | TBA         |

<br>

##### String Union: `MenuAttributes`

> Attributes that determine the style of the menu element.

A union string type that maps to `UIMenuElement.Attributes` enum (see [apple docs](https://developer.apple.com/documentation/uikit/uimenuelement/attributes) for more information).

<br>

| Type                    | Description |
| :---------------------- | :---------- |
| ⚛️  `hidden`             | TBA         |
| ⚛️  `disabled`           | TBA         |
| ⚛️  `destructive`        | TBA         |
| ⚛️  `keepsMenuPresented` | TBA         |

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

##### String Union: `MenuElementSize`

> Constants that determine the size of an element in a menu.

A union string type that maps to `UIMenu.ElementSize` enum (see [apple docs](https://developer.apple.com/documentation/uikit/uimenu/elementsize) for more information).

<br>

| Type        | Description |
| :---------- | :---------- |
| ⚛️  `small`  | TBA         |
| ⚛️  `medium` | TBA         |
| ⚛️  `large`  | TBA         |

<br>

#### `MenuPreviewConfig.ts`

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

#### `MenuAuxiliaryPreviewConfig.ts`

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

##### Object Type: `MenuAuxiliaryPreviewBaseTransitionConfig`

This type is an object tagged union type, with the `transition` property being the tag that separates the unions. 

The table below defines the possible valid values that can be assigned to the `type` property (the subsequent tables are the different possible unions).

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
| 🔤  `slideOffset`<br/><br/>⚛️ `number`             | TBA         |

<br>

| Name and Type                                   | Description |
| :---------------------------------------------- | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `zoom` | TBA         |
| 🔤  `zoomOffset`<br/><br/>⚛️ `number`             | TBA         |

<br>

| Name and Type                                           | Description |
| :------------------------------------------------------ | ----------- |
| 🔤  `transition`<br/><br/>⚛️ `string` i.e. `zoomAndSlide` | TBA         |
| 🔤  `slideOffset`<br/><br/>⚛️ `number`                    | TBA         |
| 🔤  `zoomOffset`<br/><br/>⚛️ `number`                     | TBA         |

<br>

##### Object Union Type: `MenuAuxiliaryPreviewTransitionConfig`

This type is a union between the `UIViewAnimateConfig` object type, and the `MenuAuxiliaryPreviewBaseTransitionConfig` object type.

```typescript
export type MenuAuxiliaryPreviewTransitionConfig = 
  | UIViewAnimateConfig
  | MenuAuxiliaryPreviewBaseTransitionConfig;
```

<br>

##### Mixed Union Type: `MenuAuxiliaryPreviewTransitionEntranceDelay`.

| Name and Type     | Description |
| :---------------- | ----------- |
| ⚛️ `number`        | TBA         |
| ⚛️ `RECOMMENDED`   | TBA         |
| ⚛️ `AFTER_PREVIEW` | TBA         |

<br>

#### `MenuIconConfig.ts`

* 📌 **Declaration**: [`MenuIconConfig.ts`](src/types/MenuIconConfig.ts)

<br>

##### Object Type: `IconConfig`

This has been deprecated and will be removed in a future version. Use [`ImageItemConfig`](PLACE_HOLDER_LINK) instead. For documentation regarding `IconConfig`, please see the documentation in the [old README](./README-old.md).

<br>

#### `ImageItemConfig.ts`

* 📌 **Declaration**: [`ImageItemConfig.ts`](src/types/ImageItemConfig.ts)

<br>

##### Object Type: `ImageItemConfig`

This type is an object tagged union type, with the `type` property being the tag that separates the unions. The table below defines the possible valid values that can be assigned to the `type` property.

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `ImageItemConfigType` string union, i.e. `'IMAGE_ASSET' ¦ 'IMAGE_SYSTEM' ¦ 'IMAGE_REQUIRE'`<br>` ¦ 'IMAGE_EMPTY' ¦ 'IMAGE_RECT' ¦ 'IMAGE_GRADIENT' `<br>`¦ 'IMAGE_REMOTE_URL'` | TBA         |

<br>

###### `ImageItemConfig`: `IMAGE_ASSET`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_ASSET' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(named:)`](https://developer.apple.com/documentation/uikit/uiimage/1624146-init) constructor in the apple docs. |
| 🔤  **Required**: `imageValue`<br/><br/>⚛️  `string`           | TBA                                                          |
| 🔤  `imageOptions?`<br/><br/>⚛️  [`ImageOptions`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_SYSTEM`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_SYSTEM' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤  **Required**:  `imageValue`<br/><br/>⚛️  [`ImageSystemConfig`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to the `withConfiguration` argument label in the  [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| `imageOptions`<br/><br/>⚛️  [`ImageOptions`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `imageLoadingConfig`<br/><br/>⚛️  [`ImageLoadingConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

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
| `imageOptions`<br/><br/>⚛️  [`ImageOptions`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_REMOTE_URL`

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e `'IMAGE_REMOTE_URL' ` | TBA         |
| 🔤  `imageValue`<br/><br/>⚛️  [`ImageRemoteUrlConfig`](PLACE_HOLDER_LINK) | TBA         |
| 🔤  `imageLoadingConfig`<br/><br/>⚛️  [`ImageLoadingConfig`](PLACE_HOLDER_LINK) | TBA         |
| `imageOptions`<br/><br/>⚛️  [`ImageOptions`](PLACE_HOLDER_LINK) | TBA         |

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

##### Object Type: `UIImageConfig`

TBA

| Name and Type                                        | Description |
| :--------------------------------------------------- | ----------- |
| 🔤  `tint`<br/><br/>⚛️  `string ¦ DynamicColor`        | TBA         |
| 🔤  `renderingMode`<br/><br/>⚛️  `ImageRenderingModes` | TBA         |

<br>

##### Object Union Type: `ImageOptions`

This type is a unioned with `UIImageConfig` object type, so it inherits its properties.

| Name and Type                          | Description |
| :------------------------------------- | ----------- |
| 🔤  `cornerRadius`<br/><br/>⚛️  `number` | TBA         |

<br>

#####  Object Type: `ImageRemoteUrlConfig`

TBA

| Name and Type                               | Description |
| :------------------------------------------ | ----------- |
| 🔤 **Required**:  `url`<br/><br/>⚛️  `string` | TBA         |

<br>

#####  Object Type: `ImageLoadingConfig`

TBA

| Name and Type                             | Description |
| :---------------------------------------- | ----------- |
| 🔤  `shouldCache`<br/><br/>⚛️  `boolean`    | TBA         |
| 🔤  `shouldLazyLoad`<br/><br/>⚛️  `boolean` | TBA         |

<br>

#### Undocumented Types

TBA

| Type                                                         | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 📌 **Declaration**: [`MenuEvents`](src/types/MenuEvents.ts)   | This file contains all the menu-related events and event objects. |
| 📌 **Declaration**: [`MiscTypes.ts`](src/types/MiscTypes.ts)  | This file contains a bunch of types that haven't been categorized yet.<br><br>Contains: `PointPreset`, `Point`, `DynamicColor`, etc. |
| 📌 **Declaration**: [`RNICleanupMode.ts`](src/types/RNICleanupMode.ts) | TBA                                                          |

<br>

### D.5. Constants

#### Object: `LIB_ENV`

TBA

<br>

| Type                                                    | Description |
| :------------------------------------------------------ | :---------- |
| 🔤  `isContextMenuButtonSupported`<br/><br/>⚛️  `boolean` | TBA         |
| 🔤  `isContextMenuViewSupported`<br/><br/>⚛️  `boolean`   | TBA         |

<br><br>

