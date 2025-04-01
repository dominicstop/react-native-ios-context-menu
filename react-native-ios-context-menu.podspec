require 'json'

absolute_react_native_path = ''
if !ENV['REACT_NATIVE_PATH'].nil?
  absolute_react_native_path = File.expand_path(ENV['REACT_NATIVE_PATH'], Pod::Config.instance.project_root)
else
  absolute_react_native_path = File.dirname(`node --print "require.resolve('react-native/package.json')"`)
end

unless defined?(install_modules_dependencies)
  # `install_modules_dependencies` and `add_dependency` are defined in react_native_pods.rb.
  # When running with `pod ipc spec`, these methods are not defined and we have to require manually.
  require File.join(absolute_react_native_path, "scripts/react_native_pods")
end

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

reactNativeVersion = '0.0.0'
begin
  reactNativeVersion = `node --print "require('#{absolute_react_native_path}/package.json').version"`
rescue
  reactNativeVersion = '0.0.0'
end

reactNativeTargetVersion = reactNativeVersion.split('.')[1].to_i

use_hermes = ENV['USE_HERMES'] == nil || ENV['USE_HERMES'] == '1'
fabric_enabled = ENV['RCT_NEW_ARCH_ENABLED'] == '1'

folly_version = '2022.05.16.00'
folly_compiler_flags = get_folly_config()[:compiler_flags]

linkage = ENV['USE_FRAMEWORKS']
reactNativeTargetVersionOverride = ENV['REACT_NATIVE_TARGET_VERSION']

puts "react-native-ios-context-menu"
puts " - reactNativeTargetVersion: #{reactNativeVersion}"
puts " - reactNativeTargetVersionOverride: #{reactNativeTargetVersionOverride}"
puts " - fabric_enabled: #{fabric_enabled}"
puts " - linkage: #{linkage}"
puts " - hermes enabled: #{use_hermes}"
puts "\n"

if reactNativeTargetVersionOverride 
  reactNativeTargetVersion = reactNativeTargetVersionOverride.to_i
end

fabric_compiler_flags = '-DRN_FABRIC_ENABLED -DRCT_NEW_ARCH_ENABLED'
compiler_flags = folly_compiler_flags + ' ' + "-DREACT_NATIVE_TARGET_VERSION=#{reactNativeTargetVersion}"

if use_hermes
  compiler_flags << ' -DUSE_HERMES'
end

if fabric_enabled
  compiler_flags << ' ' << fabric_compiler_flags
end

Pod::Spec.new do |s|

  s.name           = "react-native-ios-context-menu"
  s.version        = package["version"]
  s.summary        = package["description"]
  s.homepage       = package["homepage"]
  s.license        = package["license"]
  s.authors        = package["author"]

  s.platforms      = { :ios => min_ios_version_supported }
  s.source         = { :git => "https://github.com/dominicstop/react-native-ios-context-menu.git", :tag => "#{s.version}" }

  s.swift_version  = '5.4'

  s.static_framework = true
  s.header_dir       = 'react-native-ios-context-menu'

  header_search_paths = [
    '"$(PODS_ROOT)/Headers/Private/React-Core"', 
    # '"$(PODS_ROOT)/boost"',
    '"$(PODS_ROOT)/DoubleConversion"',
    # '"$(PODS_ROOT)/RCT-Folly"',
    # '"${PODS_ROOT}/Headers/Public/React-hermes"',
    # '"${PODS_ROOT}/Headers/Public/hermes-engine"',
    # '"$(PODS_ROOT)/Headers/Private/Yoga"',
  ]

  if fabric_enabled && ENV['USE_FRAMEWORKS']
    header_search_paths.concat([
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-RuntimeApple/React_RuntimeApple.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-RuntimeCore/React_RuntimeCore.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-performancetimeline/React_performancetimeline.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-runtimescheduler/React_runtimescheduler.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-rendererconsistency/React_rendererconsistency.framework/Headers"',
      '"$(PODS_ROOT)/Headers/Public/ReactCommon"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-jserrorhandler/React_jserrorhandler.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-jsinspector/jsinspector_modern.framework/Headers"',
      
      '"${PODS_CONFIGURATION_BUILD_DIR}/RCT-Folly/folly.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/fmt/fmt.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-utils/React_utils.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-debug/React_debug.framework/Headers"',
      '"${PODS_CONFIGURATION_BUILD_DIR}/React-rendererdebug/React_rendererdebug.framework/Headers"',
    ])
  end
  

  # Swift/Objective-C compatibility
  s.pod_target_xcconfig = {
    'USE_HEADERMAP' => 'YES',
    'DEFINES_MODULE' => 'YES',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'OTHER_SWIFT_FLAGS' => "$(inherited) #{fabric_enabled ? fabric_compiler_flags : ''}",
    'HEADER_SEARCH_PATHS' => header_search_paths.join(' '),
    "FRAMEWORK_SEARCH_PATHS" => "\"${PODS_CONFIGURATION_BUILD_DIR}/React-hermes\"",
  }

  user_header_search_paths = [
    '"${PODS_CONFIGURATION_BUILD_DIR}/react-native-ios-utilities/**"',
    '"${PODS_CONFIGURATION_BUILD_DIR}/react-native-ios-utilities/Swift Compatibility Header"',
    '"${PODS_CONFIGURATION_BUILD_DIR}/react-native-ios-context-menu/Swift Compatibility Header"',
    '"$(PODS_ROOT)/Headers/Private/React-bridging/react/bridging"',
    '"$(PODS_CONFIGURATION_BUILD_DIR)/React-bridging/react_bridging.framework/Headers"',
    '"$(PODS_ROOT)/Headers/Private/Yoga"', 
  ]

  if fabric_enabled && ENV['USE_FRAMEWORKS']
    user_header_search_paths << "\"$(PODS_ROOT)/DoubleConversion\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers/react/renderer/graphics/platform/ios\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/React-Fabric/React_Fabric.framework/Headers\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon/ReactCommon.framework/Headers\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon/ReactCommon.framework/Headers/react/nativemodule/core\""
    user_header_search_paths << "\"${PODS_CONFIGURATION_BUILD_DIR}/React-RCTFabric/RCTFabric.framework/Headers\""
  end
  
  s.user_target_xcconfig = {
    "HEADER_SEARCH_PATHS" => user_header_search_paths,
  }

  if use_hermes
    s.dependency 'hermes-engine'
  else
    s.dependency 'React-jsc'
  end

  if use_hermes && reactNativeTargetVersion >= 78
    add_dependency(s, "React-jsinspector", :framework_name => 'jsinspector_modern')
    add_dependency(s, "React-jsinspectortracing", :framework_name => 'jsinspector_moderntracing')
  end

  s.dependency 'React-Core'
  s.dependency 'ReactCommon/turbomodule/core'

  s.dependency 'React-RCTAppDelegate' if reactNativeTargetVersion >= 71
  s.dependency 'React-NativeModulesApple' if reactNativeTargetVersion >= 72

  if fabric_enabled
    s.dependency 'React-RCTFabric'
    s.dependency 'RCT-Folly', folly_version
  end

  s.dependency 'react-native-ios-utilities'
  s.dependency 'DGSwiftUtilities'
  s.dependency 'ContextMenuAuxiliaryPreview', '~> 0.5'

  exclude_files = ['ios/Tests/']
  
  if !fabric_enabled
    exclude_files.append('ios/Fabric/')
    exclude_files.append('common/cpp/fabric/')
  end

  install_modules_dependencies(s)

  s.source_files = 'ios/**/*.{h,m,mm,swift,cpp}', 'common/cpp/**/*.{h,cpp}'
  s.exclude_files = exclude_files
  s.compiler_flags = compiler_flags

  s.public_header_files = 'ios/**/*.h'
  s.private_header_files = ['ios/**/*+Private.h', 'ios/**/Swift.h']

end