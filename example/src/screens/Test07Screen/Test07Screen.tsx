import * as React from 'react';
import { StyleSheet, Text, ScrollView } from 'react-native';

import { MessageBubble } from './MessageBubble';

import { ContextMenuCard } from '../../components/ContextMenuCard';
import { CardButton } from '../../components/Card/CardButton';

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