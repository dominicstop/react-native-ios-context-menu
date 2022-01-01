import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample13(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample13',
        menuItems: [{
          actionKey           : 'key-01',
          actionTitle         : 'Action #1',
          discoverabilityTitle: 'Action subtitle',
        }, {
          actionKey           : 'key-02'   ,
          actionTitle         : 'Action #2',
          discoverabilityTitle: 'Lorum ipsum sit amit dolor aspicing',
        }, {
          actionKey           : 'key-03'   ,
          actionTitle         : 'Action #3',
          discoverabilityTitle: 'Very long `discoverabilityTitle` lorum ipsum sit amit',
        }],
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
        title={'ContextMenuViewExample13'}
        subtitle={'discoverabilityTitle'}

        description={[
          `Context menu with 3 actions that has the 'discoverabilityTitle' set.`
        ]}
      />
    </ContextMenuView>
  );
};