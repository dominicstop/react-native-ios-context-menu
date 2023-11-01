import * as React from 'react';
import { useState } from 'react';
import { View, Image, StyleSheet, Text, Pressable } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

// Repro for issue: #77
// https://github.com/dominicstop/react-native-ios-context-menu/issues/77
//
// * Bug: Pressables inside of a context menu firing navigation in a native 
//   stack cause a crash

export const Test05Screen = () => {
  return (
    <View style={styles.rootContainer}>
      <ContextMenuView 
        style={styles.messageContainer}
        menuConfig={{
          menuTitle: '',
          menuItems: [{
            actionKey: 'action-like',
            actionTitle: 'Like',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart.fill',
              },
              imageOptions: {
                tint: 'red',
                renderingMode: 'alwaysOriginal',
              },
            }
          }],
        }}
        onPressMenuItem={({nativeEvent}) => {
          switch(nativeEvent.actionKey) {
            case "action-like":
              break;
          };
        }}
      >
        <Pressable>
          <Text>
            {'I am a link'}
          </Text>
        </Pressable>
      </ContextMenuView>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1,
    alignItems: 'flex-end',
    justifyContent: 'flex-end',
    paddingHorizontal: 15,
    paddingVertical: 10,
    paddingBottom: 20
  },
  messageContainer: {
    flex: 0,
    backgroundColor: 'red',
    borderRadius: 10,
    overflow: 'hidden',
  },
});