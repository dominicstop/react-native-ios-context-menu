import * as React from 'react';
import { StyleSheet, Text, View, ScrollView } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

// Repro for:
// https://github.com/dominicstop/react-native-ios-context-menu/issues/102#issuecomment-2465444845

function FlickerExample({ children }: { children: React.ReactElement }) {
  return (
    <ContextMenuView
      style={styles.messageContainer}
      previewConfig={{ 
        previewType: "CUSTOM",
        backgroundColor: 'rgba(0,0,0,0)',
        borderRadius: 10,
      }}
      renderPreview={() => 
        <View style={styles.previewContainer}>
          {children}
        </View>
      }
      menuConfig={{
        menuTitle: "BasicUsageExample01",
        menuItems: [
          {
            actionKey: "key-01",
            actionTitle: "Action #1",
          },
          {
            actionKey: "key-02",
            actionTitle: "Action #2",
          },
          {
            actionKey: "key-03",
            actionTitle: "Action #3",
          },
        ],
      }}
    >
      {children}
    </ContextMenuView>
  );
}
export const Test08Screen = () => {
  return (
    <ScrollView 
      style={styles.rootContainer}
      contentContainerStyle={styles.rootContainerContent}
    >
      <FlickerExample>
        <Text style={styles.messageText}>
          {'Hello'}
        </Text>
      </FlickerExample>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1,
    backgroundColor: 'white',
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
  previewContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 32,
  },
  messageText: {
    fontSize: 16,
  },
});