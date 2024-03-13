# CHANGELOG

Changelog for [`react-native-ios-context-menu`](https://github.com/dominicstop/react-native-ios-context-menu).

<br><br>

* `TBA` - **Release**: [2.5.0](https://github.com/dominicstop/react-native-ios-context-menu/releases/tag/v2.5.0-4) | [changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.5.0-4...v2.5.0) | [all changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.4.4...v2.5.0)
  * **Summary**: Finalized release of `2.5.0` - Refactor of cleanup logic
    * Fix for [issue #94](https://github.com/dominicstop/react-native-ios-context-menu/issues/94)
    * Raise min. version dependency to `react-native-ios-utilities` from `4.3.x` to `4.4.x`.
    * Remove `RNICleanupMode` usage.
    * Update to use new cleanup logic - Refactor `RNIContextMenuView` + `RNIContextMenuButton` to conform to `RNICleanableViewDelegate`, and use `RNICleanableViewRegistry` to trigger cleanup logic.<br><br>
  
* `2024-03-12-20:27 PST` - **Release**: [2.5.0-4](https://github.com/dominicstop/react-native-ios-context-menu/releases/tag/v2.5.0-4) | [changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.5.0-3...v2.5.0-4) | [all changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.4.4...v2.5.0-4)
  * **Summary**: Update for `react-native-ios-utilities@v4.4.0-6` - Refactor types - Update to use `RNIViewCleanupModeProp` to define `internalViewCleanupMode` for `RNIContextMenuView` and `RNIContextMenuButton`.<br><br>
* `2024-03-12-16:03 PST` -  **Release**: [2.5.0-3](https://github.com/dominicstop/react-native-ios-context-menu/releases/tag/v2.5.0-3) | [changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.5.0-2...v2.5.0-3) | [all changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.4.4...v2.5.0-3)
  * **Summary**: Merge changes from branch [branch v2.4.x](https://github.com/dominicstop/react-native-ios-context-menu/tree/v2.4.x)<br><br>
* `2024-03-09-09:55 PST` - **Release**: [v2.4.4](https://github.com/dominicstop/react-native-ios-context-menu/releases/tag/v2.4.4) | [changes](https://github.com/dominicstop/react-native-ios-context-menu/compare/v2.4.3...v2.4.4) | [branch v2.4.x](https://github.com/dominicstop/react-native-ios-context-menu/tree/v2.4.x)
  * **Summary**: Contains a bugfix for touch events being blocked during the aux. preview entrance transition.

