import * as React from 'react';
import { StyleSheet, Text, ScrollView, Pressable, Alert } from 'react-native';

import { MessageBubble } from './MessageBubble';

import { ContextMenuCard } from '../../components/ContextMenuCard';
import { CardButton } from '../../components/Card/CardButton';

function MessageContent(props: {
  message: string;
}){
  return (
    <Pressable
      onPress={() => {
        Alert.alert("Pressable.onPress");
      }}
    >
      <Text style={styles.messageText}>
        {props.message}
      </Text>
    </Pressable>
  );
};

export const Test07Screen = () => {
  const [
    shouldMountMessageBubbles, 
    setShouldMountMessageBubbles
  ] = React.useState(false);
  
  return (
    <ScrollView 
      style={styles.rootContainer}
      contentContainerStyle={styles.rootContentContainer}
    >
      <ContextMenuCard
        style={styles.debugControls}
        index={0}
        title={'Debug Controls'}
        subtitle={'For testing and stuff'}
      >
        <CardButton
          title={'Toggle Show Message Bubbles'}
          subtitle={`setShouldMountMessageBubbles: ${shouldMountMessageBubbles}`}
          onPress={() => {
            setShouldMountMessageBubbles(prevValue => !prevValue);
          }}
        />
      </ContextMenuCard>
      {shouldMountMessageBubbles && (
        <React.Fragment>
          <MessageBubble isMe={false}>
            <MessageContent
              message={'Hello World #1'}
            />
          </MessageBubble>
          <MessageBubble isMe={true}>
            <MessageContent
              message={'Hello World #2'}
            />
          </MessageBubble>
        </React.Fragment>
      )}
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
  debugControls: {
    alignSelf: 'stretch',
    marginBottom: 12,
  },
});