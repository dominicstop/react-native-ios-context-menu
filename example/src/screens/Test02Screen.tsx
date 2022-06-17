import * as React from 'react';
import { useState } from 'react';
import { View, Image, StyleSheet, Text } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';


export const Test02Screen = () => {
  const [isMessageLiked, setIsMessageLiked] = useState(false);
  const [isContextMenuVisible, setIsContextMenuVisible] = useState(false);

  const shouldShowHeart = isMessageLiked && !isContextMenuVisible;

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
          onMenuWillShow={() => {
            setIsContextMenuVisible(true);
          }}
          onMenuDidHide={() => {
            setIsContextMenuVisible(false);
          }}
        >
          <Image
            style={styles.messageImage}
            source={require('../assets/macos11_wallpaper.jpg')}
            resizeMode={'cover'}
          />
        </ContextMenuView>
        {shouldShowHeart && (
          <Text>
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
});