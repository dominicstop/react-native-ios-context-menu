import * as React from 'react';
import { StyleSheet, Text, Pressable, ScrollView } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';
import { SHARED_ENV } from '../constants/SharedEnv';

import { useNavigation } from '@react-navigation/native';

// Repro for issue: #77
// https://github.com/dominicstop/react-native-ios-context-menu/issues/77
//
// * Bug: Pressables inside of a context menu firing navigation in a native 
//   stack cause a crash

function MessageBubble(props: React.PropsWithChildren){
  return (
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
      {props.children}
    </ContextMenuView>
  );
};

export const Test05Screen = () => {
  const navigation = SHARED_ENV.enableReactNavigation 
    ? useNavigation()
    : undefined;
  
  return (
    <ScrollView 
      style={styles.rootContainer}
      contentContainerStyle={styles.rootContainerContent}
    >
      <MessageBubble>
        <Pressable
          onPress={() => {
            //@ts-ignore
            navigation?.push('Home');
          }}
        >
          <Text style={[styles.messageText, styles.messageTextLink]}>
            {'I am a link'}
          </Text>
        </Pressable>
      </MessageBubble>

      <MessageBubble>
        <Text style={styles.messageText}>
          {'I am a '}
          <Text 
            style={[styles.messageTextLink]}
            onPress={() => {
              //@ts-ignore
              navigation?.push('Home');
            }}
          >
            {'link'}
          </Text>
          {' inside a text'}
        </Text>
      </MessageBubble>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1,
  },
  rootContainerContent: {
    alignItems: 'flex-end',
    justifyContent: 'flex-end',
    paddingHorizontal: 12,
    paddingTop: 12,
    paddingBottom: 24,
  },
  messageContainer: {
    flex: 0,
    backgroundColor: 'pink',
    borderRadius: 10,
    overflow: 'hidden',
    paddingHorizontal: 10,
    paddingVertical: 10,
    marginBottom: 12,
  },
  messageText: {
    fontSize: 16,
  },
  messageTextLink: {
    textDecorationLine: 'underline',
    textDecorationColor: 'rgba(0,0,0,0.5)',
  },
});