const ios = require('@react-native-community/cli-platform-ios');


module.exports = {
  project: {
    android: null,
    ios: {
      project: './ios/IosContextMenu.xcodeproj',
    },
  },
  platforms: {
    ios: {
      projectConfig: ios.projectConfig,
      dependencyConfig: ios.dependencyConfig,
    },
    android: null,
  },
};
