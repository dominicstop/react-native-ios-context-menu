#pragma once

#if __has_include(<react_native_ios_utilities/header>)
    #define RNI_INCLUDE_HEADER(header) <react_native_ios_utilities/header>
#else
    #define RNI_INCLUDE_HEADER(header) <react-native-ios-utilities/header>
#endif
