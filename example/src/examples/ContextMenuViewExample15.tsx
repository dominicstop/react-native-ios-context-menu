import * as React from 'react';
import { StyleSheet, View, Text, findNodeHandle, Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample15(props: ContextMenuExampleProps) {
  const [targetViewNode, setTargetViewNode] = React.useState(null);

  const viewRef = React.useRef();

  React.useEffect(() => {
    setTargetViewNode(
      findNodeHandle(viewRef.current)
    );

  }, []);

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample15',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }],
      }}
      previewConfig={{
        // specify which view to use as the preview target.
        targetViewNode: targetViewNode,
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample15'}
        subtitle={'Preview Target'}
        description={[
          `Example context menu with a specific preview target`
        ]}
      >
        <View
          style={styles.targetContainer}
          ref={viewRef}
        >
          <Text style={styles.text}>
            {`Hello! Target Node: ${targetViewNode}`}
          </Text>
        </View>
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  targetContainer: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    alignSelf: 'flex-start',
    padding: 10,
    borderRadius: 10,
    marginTop: 10,
  },
  text: {
    fontSize: 16,
  }
});