# react-native-ios-context-menu

<br>

## 🚧⚠️ **Library WIP** ⚠️🚧

- The documentation is incomplete (some parts/sections are marked as **TBA** i.e. "to be added"). 
- Some of the links in the documentation are broken (i.e. the URL points to `PLACE_HOLDER_LINK`).

<br>

## A. Introduction

<br>

## B. Installation

<br>

## C. Basic Usage

<br>

## D. Documentation

### D.1. Components

#### `ContextMenuView` Component

##### `ContextMenuView` Component: Props

| Prop Name and Type                                          | Description                                                  |
| :---------------------------------------------------------- | :----------------------------------------------------------- |
| ⚛️ `ViewProps`                                               | This component supports all the standard props from a `<View/>` component. |
| 🔤 **Required**: `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK)              | TBA                                                          |

<br>

##### `ContextMenuView` Component: Event Props

| Prop Name and Type                             | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### `ContextMenuView` Component: Properties/Methods

| Prop Name and Type                             | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

#### `ContextMenuButton` Component

##### `ContextMenuButton` Component: Props

| Prop Name and Type                                          | Description                                                  |
| :---------------------------------------------------------- | :----------------------------------------------------------- |
| ⚛️ `ViewProps`                                               | This component supports all the standard props from a `<View/>` component. |
| 🔤 **Required**: `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA                                                          |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK)              | TBA                                                          |

<br>

##### `ContextMenuButton` Component: Event Props

| Prop Name and Type                             | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### `ContextMenuButton` Component: Properties/Methods

| Prop Name and Type                             | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

### D.2. Context

TBA

<br>

### D.3. Hooks

TBA

<br>

### D.4. Objects and Types

#### 📄 `MenuConfig.ts`

* 📌 **Declaration**: [`MenuConfig.ts`](src/types/MenuConfig.ts)

##### Object Type: `MenuConfig`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### Object Type: `MenuActionConfig`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `MenuAttributes`

| Type     | Description |
| :------- | :---------- |
| 🔤  `abc` | TBA         |

<br>

##### String Union: `MenuState`

| Type                                           | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `UIMenuOptions`

| Type                                           | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `abc`

| Type                                           | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

#### 📄 `MenuPreviewConfig,ts`

* 📌 **Declaration**: [`MenuPreviewConfig.ts`](src/types/MenuPreviewConfig.ts)

##### Object Type: `MenuPreviewConfig`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `ContextMenuInteractionCommitStyle`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `MenuPreviewSize`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

##### String Union: `MenuPreviewType`

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

#### 📄 `MenuIconConfig.ts`

* 📌 **Declaration**: [`MenuIconConfig.ts`](src/types/MenuIconConfig.ts)

<br>

##### Object Type: `IconConfig`

This has been deprecated and will be removed in a future version. Use [`ImageItemConfig`](PLACE_HOLDER_LINK) instead.

| Name and Type                                  | Description |
| :--------------------------------------------- | :---------- |
| 🔤  `abc`<br/><br/>⚛️ [`abc`](PLACE_HOLDER_LINK) | TBA         |

<br>

#### 📄 `ImageItemConfig.ts`

* 📌 **Declaration**: [`ImageItemConfig.ts`](src/types/ImageItemConfig.ts)

<br>

##### Object Type: `ImageItemConfig`

This type is an object tagged union type, with the `type` property being the tag that separates the unions. The table below defines the possible valid values that can be assigned to the `type` property.

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `ImageItemConfigType` string union, i.e. `'IMAGE_ASSET' ¦ 'IMAGE_SYSTEM' ¦ 'IMAGE_REQUIRE' ¦ 'IMAGE_EMPTY' ¦ 'IMAGE_RECT' ¦ 'IMAGE_GRADIENT' ` | TBA         |

<br>

###### `ImageItemConfig`: `IMAGE_ASSET`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e. `'IMAGE_ASSET' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(named:)`](https://developer.apple.com/documentation/uikit/uiimage/1624146-init) constructor in the apple docs. |
| 🔤  **Required**: `imageValue`<br/><br/>⚛️  `string`           | TBA                                                          |
| 🔤  `imageOptions?`<br/><br/>⚛️  [`UIImageConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_SYSTEM`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e. `'IMAGE_SYSTEM' ` | TBA<br/><br/>📌 Maps to [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤  **Required**:  `imageValue`<br/><br/>⚛️  [`ImageSystemConfig`](PLACE_HOLDER_LINK) | TBA<br/><br/>📌 Maps to the `withConfiguration` argument label in the  [`UIImage.init(systemName:withConfiguration:)`](https://developer.apple.com/documentation/uikit/uiimage/3294234-init) constructor in the apple docs. |
| 🔤  `imageOptions?`<br/><br/>⚛️  [`UIImageConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_EMPTY`

| Name and Type                                                | Description |
| :----------------------------------------------------------- | ----------- |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e. `'IMAGE_EMPTY' ` | TBA         |

<br>

###### `ImageItemConfig`: `IMAGE_RECT`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e. `'IMAGE_RECT' ` | TBA<br/><br/>📝 **Note**: Programmatically creates an image using [`UIGraphicsImageRenderer`](https://developer.apple.com/documentation/uikit/uigraphicsrenderer). |
| 🔤  **Required**: `imageValue`<br/><br/>⚛️  [`ImageRectConfig`](PLACE_HOLDER_LINK) | TBA                                                          |

<br>

###### `ImageItemConfig`: `IMAGE_GRADIENT`

| Name and Type                                                | Description                                                  |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| 🔤  **Required**: `type`<br/><br/>⚛️  `string` i.e. `'IMAGE_GRADIENT' ` | TBA<br/><br/>📝 **Note**: Programmatically creates an image using [`UIGraphicsImageRenderer`](https://developer.apple.com/documentation/uikit/uigraphicsrenderer). |
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
| 🔤  `type?`<br/><br/>⚛️  `string` i.e. `'axial' ¦ 'conic' ¦ 'radial'` | TBA<br/><br/>📌 Maps to [`CAGradientLayer.type`](https://developer.apple.com/documentation/quartzcore/cagradientlayer/1462413-type) property in the apple docs. |

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

TBA

<br>

## E. Getting Started Guide

<br>

## F. Usage And Examples

<br>

## G. Showcase, Tests and Demos

<br>

## E. Meta

<br>

## F. Licence