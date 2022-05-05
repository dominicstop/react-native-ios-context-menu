/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample19(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample19',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
        }],
      }}
      renderAuxillaryPreview={() => (
        <View style={{
          flex: 1,
          backgroundColor: 'red',
        }}>
          <View style={{
            flex: 1,
            backgroundColor: 'blue',
          }}>
            <Text>
              Hello
            </Text>
          </View>
        </View>
      )}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample19'}
        subtitle={'EXPERIMENTAL - Aux. Preview Simple'}
        description={[
          `Basic 'ContextMenuView' w/ a basic auxillary preview configuration.`
        ]}
      />
    </ContextMenuView>
  );
};