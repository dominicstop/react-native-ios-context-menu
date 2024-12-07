#!/bin/bash

NEW_ARCH_STATIC=PENDING 
OLD_ARCH_STATIC=PENDING 
NEW_ARCH_DYNAMIC=PENDING 
OLD_ARCH_DYNAMIC=PENDING

log_build_status() {
  echo "\n\n\nBUILD RESULTS...";
  echo "Build - NEW_ARCH_STATIC: ${NEW_ARCH_STATIC}"
  echo "Build - OLD_ARCH_STATIC: ${OLD_ARCH_STATIC}"
  echo "Build - NEW_ARCH_DYNAMIC: ${NEW_ARCH_DYNAMIC}"
  echo "Build - OLD_ARCH_DYNAMIC: ${OLD_ARCH_DYNAMIC}"
  echo "\n\n"
}

log_build_status;

echo '\n\nBuild - new-arch (fabric) + static: Begin...\n'
yarn run pod-install:new-static
yarn run build:ios ;

if [ $? -eq 0 ]; then
  NEW_ARCH_STATIC=SUCCESS;
else
  NEW_ARCH_STATIC=FAILED;
fi;

log_build_status

echo '\n\nBuild - old-arch (paper) + static: Begin...'
yarn run pod-install:old-static
yarn run build:ios ; 

if [ $? -eq 0 ]; then
  OLD_ARCH_STATIC=SUCCESS;
else
  OLD_ARCH_STATIC=FAILED;
fi;

log_build_status

echo '\nBuild - new-arch (fabric) + dynamic: Begin...\n'
yarn run pod-install:new-dynamic
yarn run build:ios ; 

if [ $? -eq 0 ]; then
  NEW_ARCH_DYNAMIC=SUCCESS;
else
  NEW_ARCH_DYNAMIC=FAILED;
fi;

log_build_status;

echo 'Build - old-arch (paper) + static: Begin...'
yarn run pod-install:old-dynamic
yarn run build:ios ;

if [ $? -eq 0 ]; then
  OLD_ARCH_DYNAMIC=SUCCESS;
else
  OLD_ARCH_DYNAMIC=FAILED;
fi;

echo "\n\n All Builds Completed..."
log_build_status