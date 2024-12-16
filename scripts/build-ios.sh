#!/bin/bash

BUILD_CONFIG="${1:-DEBUG}"

cd ./example/ios

BUILD_INFO=$(
  xcodebuild \
    -project ./*.xcodeproj \
    -showBuildSettings -list -json | tr -d ' ' | tr -d '\n'
)

SCHEME_NAME=$(
  node -pe 'JSON.parse(process.argv[1]).project.schemes[0]' $BUILD_INFO
) 
echo "Starting build..."
echo "Configuration: $BUILD_CONFIG"
echo "Scheme: $SCHEME_NAME"

xcodebuild \
  -workspace *.xcworkspace \
  -configuration Release \
  -scheme $SCHEME_NAME \
  -destination 'generic/platform=iOS' \
  clean build
