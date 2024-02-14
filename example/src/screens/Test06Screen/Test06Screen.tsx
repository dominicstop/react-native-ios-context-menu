import * as React from 'react';
import { View, StyleSheet, Text, Pressable, ScrollView } from 'react-native';

import { MessageBubble } from './MessageBubble';


export const Test06Screen = () => {
  
  return (
    <ScrollView 
      style={styles.rootContainer}
      contentContainerStyle={styles.rootContentContainer}
    >
      <MessageBubble
        isMe={false}
      >
        <Text style={styles.messageText}>
          {'Hello World'}
        </Text>
      </MessageBubble>
      <MessageBubble
        isMe={true}
      >
        <Text style={styles.messageText}>
          {'Hello World'}
        </Text>
      </MessageBubble>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1,
  },
  rootContentContainer: {
    alignItems: 'flex-end',
    justifyContent: 'flex-end',
    paddingHorizontal: 12,
    paddingTop: 12,
    paddingBottom: 24,
  },
  messageContainer: {
    
  },
  messageText: {
    fontSize: 16,
  },
});