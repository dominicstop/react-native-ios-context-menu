#!/bin/bash

# value: either "quick" or "not-quick"
# default: "not-quick"
BUILD_MODE="${1:-not-quick}"

NEW_ARCH_STATIC_DEBUG=PENDING 
OLD_ARCH_STATIC_DEBUG=PENDING
NEW_ARCH_STATIC_RELEASE=PENDING 
OLD_ARCH_STATIC_RELEASE=PENDING
# NEW_ARCH_DYNAMIC=PENDING 
OLD_ARCH_DYNAMIC=PENDING

log_build_status() {
  echo "\n\n\nBUILD RESULTS..."
  echo "BUILD_MODE: $BUILD_MODE"
  echo "Build - NEW_ARCH_STATIC_DEBUG: ${NEW_ARCH_STATIC_DEBUG}"
  echo "Build - OLD_ARCH_STATIC_DEBUG: ${OLD_ARCH_STATIC_DEBUG}"
  echo "Build - NEW_ARCH_STATIC_RELEASE: ${NEW_ARCH_STATIC_RELEASE}"
  echo "Build - OLD_ARCH_STATIC_RELEASE: ${OLD_ARCH_STATIC_RELEASE}"
  # echo "Build - NEW_ARCH_DYNAMIC: ${NEW_ARCH_DYNAMIC}"
  echo "Build - OLD_ARCH_DYNAMIC: ${OLD_ARCH_DYNAMIC}"
  echo "\n\n"
}

clear_cache(){
  echo "\nBUILD_MODE: $BUILD_MODE"

  # Check the value of BUILD_MODE
  if [ "$BUILD_MODE" = "quick" ]; then
    echo "Skipping cleanup..."

  elif [ "$BUILD_MODE" = "not-quick" ]; then
    echo 'clearing pods + derived data...'
    yarn run nuke:example-pods
    yarn run nuke:derived-data 
  else
    echo "Invalid BUILD_MODE. Please use 'quick' or 'not-quick'."
  fi
}

build_A1(){
  log_build_status
  clear_cache;

  echo '\n\nBuild - new-arch (fabric) + static, debug: Begin...\n'
  yarn run pod-install:new-static
  yarn run build:ios ;

  if [ $? -eq 0 ]; then
    NEW_ARCH_STATIC_DEBUG=SUCCESS;
  else
    NEW_ARCH_STATIC_DEBUG=FAILED;
  fi
}

build_A2(){ 
  log_build_status
  clear_cache

  echo '\n\nBuild - old-arch (paper) + static, debug: Begin...'
  yarn run pod-install:old-static
  yarn run build:ios ; 

  if [ $? -eq 0 ]; then
    OLD_ARCH_STATIC_DEBUG=SUCCESS;
  else
    OLD_ARCH_STATIC_DEBUG=FAILED;
  fi
}

build_B1(){ 
  log_build_status
  clear_cache

  echo '\n\nBuild - new-arch (fabric) + static, release: Begin...'
  yarn run pod-install:new-static
  yarn run build:ios-release ; 

  if [ $? -eq 0 ]; then
    NEW_ARCH_STATIC_RELEASE=SUCCESS;
  else
    NEW_ARCH_STATIC_RELEASE=FAILED;
  fi
}

build_B2(){ 
  log_build_status
  clear_cache

  echo '\n\nBuild - old-arch (paper) + static, release: Begin...'
  yarn run pod-install:old-static
  yarn run build:ios-release ; 

  if [ $? -eq 0 ]; then
    OLD_ARCH_STATIC_RELEASE=SUCCESS;
  else
    OLD_ARCH_STATIC_RELEASE=FAILED;
  fi
}

# build_C1(){
# log_build_status
# clear_cache

# echo '\nBuild - new-arch (fabric) + dynamic: Begin...\n'
# yarn run pod-install:new-dynamic
# yarn run build:ios ; 

# if [ $? -eq 0 ]; then
#   NEW_ARCH_DYNAMIC=SUCCESS;
# else
#   NEW_ARCH_DYNAMIC=FAILED;
# fi
# }

build_C2(){
  log_build_status;
  clear_cache;

  echo 'Build - old-arch (paper) + static: Begin...'
  yarn run pod-install:old-dynamic
  yarn run build:ios ;

  if [ $? -eq 0 ]; then
    OLD_ARCH_DYNAMIC=SUCCESS;
  else
    OLD_ARCH_DYNAMIC=FAILED;
  fi
}

build_A1
build_A2
build_B1
build_B2
build_C2

echo "\n\n All Builds Completed..."
log_build_status