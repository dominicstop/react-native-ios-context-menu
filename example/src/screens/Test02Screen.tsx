import * as React from 'react';
import { useState } from 'react';
import { View, Image, StyleSheet, Text } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

// Repro for issue #43
// https://github.com/dominicstop/react-native-ios-context-menu/issues/43

export const Test02Screen = () => {
  const [isMessageLiked, setIsMessageLiked] = useState(false);

  return (
    <View style={styles.rootContainer}>
      <View style={styles.messageContainer}>
        <ContextMenuView 
          style={styles.messageMenuContainer}
          menuConfig={{
            menuTitle: '',
            menuItems: [{
              actionKey: 'action-like',
              actionTitle: isMessageLiked? 'Unlike' : 'Like',
              icon: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: isMessageLiked ? 'heart.fill' : 'heart',
                  paletteColors: ['']
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
                setIsMessageLiked((value) => !value);
                break;
            };
          }}
        >
          <Image
            style={styles.messageImage}
            source={require('../assets/macos11_wallpaper.jpg')}
            resizeMode={'cover'}
          />
        </ContextMenuView>
        {isMessageLiked && (
          <Text style={styles.labelReaction}>
            {'❤️'}
          </Text>
        )}
      </View>
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
  },
  messageMenuContainer: {
    flex: 0,
    backgroundColor: 'red',
    borderRadius: 10,
    overflow: 'hidden',
  },
  messageImage: {
    width: 200,
    height: 100,
  },
  labelReaction: {
    alignSelf: 'flex-end',
    marginTop: 5,
  },
});