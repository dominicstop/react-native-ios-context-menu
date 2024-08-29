import * as React from 'react';
import { StyleSheet, Text, View, Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';
import { WrapperView, type WrapperViewRef } from 'react-native-ios-utilities';

import type { ExampleItemProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample15_02(props: ExampleItemProps) {
  const wrapperViewRef = React.useRef<WrapperViewRef | undefined>();

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
          viewID: wrapperViewRef.current?.getViewID()!,
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
          // @ts-ignore
          ref={wrapperViewRef}
        >
          <View style={styles.targetContainer}>
            <Text style={styles.text}>
              {`Hello inside: WrapperView\nView ID: ${wrapperViewRef.current?.getViewID()}`}
            </Text>
          </View>
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