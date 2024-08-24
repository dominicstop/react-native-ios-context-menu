#!/bin/sh

#  ci_post_clone.sh
#  IosVisualEffectViewExample
#
#  Created by Dominic Go on 8/18/24.
#  

echo "Working DIR:" ; pwd

echo "Navigate to root" ; pwd
cd ../../../

echo "Install: cocoapods"
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
brew install cocoapods

echo "Install: nodejs"
brew install node

echo "Install: yarn"
brew install yarn

# Install dependencies for library
echo "Install library dependencies"
echo "Working DIR:" ; pwd
yarn install

# Install dependencies for example
echo "Install example dependencies"
cd example ; pwd
yarn install
cd ios ; pwd
rm -rfv .xcode.env.local
pod install