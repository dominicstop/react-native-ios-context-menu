import * as React from 'react';
import { StyleSheet, Text, Alert } from 'react-native';

import { ContextMenuView, WrapperView } from 'react-native-ios-context-menu';
import type { StateViewID } from 'react-native-ios-utilities';

import type { ExampleItemProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample15_02(props: ExampleItemProps) {
  const [viewID, setViewID] = React.useState<StateViewID>();

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
        // get the associated id of the view element you want use as the 
        // preview target
        viewIdentifier: {
          viewID: viewID!,
        },
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
        title={'ContextMenuViewExample15-02'}
        subtitle={'Preview Target + WrapperView'}
        description={[
          `Example context menu with a specific preview target using WrapperView`
        ]}
      >
        <WrapperView
          style={styles.targetContainer}
          onDidSetViewID={({nativeEvent}) => {
            setViewID(nativeEvent.viewID);
          }}
        >
          <Text style={styles.text}>
            {`Hello inside: WrapperView\nView ID: ${viewID}`}
          </Text>
        </WrapperView>
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