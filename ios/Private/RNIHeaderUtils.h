#pragma once

/// Based on `PR-#121` by: `coolsoftwaretyler`
/// Link: https://github.com/dominicstop/react-native-ios-context-menu/pull/121
///
#if __has_include(<react_native_ios_utilities/react-native-ios-utilities.h>)
  #define RNI_UTILITIES_HEADER(header) <react_native_ios_utilities/header>
    
#elif __has_include(<react-native-ios-utilities/react-native-ios-utilities.h>)
  #define RNI_UTILITIES_HEADER(header) <react-native-ios-utilities/header>
  
#else
  #define RNI_UTILITIES_HEADER(header) header
#endif
