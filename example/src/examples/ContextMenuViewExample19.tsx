/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Helpers from '../functions/Helpers';


export function ContextMenuViewExample19(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample19',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        }, {
          type: 'deferred',
          deferredID: 'deferred-01'
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
      onRequestDeferredElement={async (deferredID, provider) => {
        switch(deferredID) {
          case 'deferred-01':
            await Helpers.timeout(1000);

            provider([{
              type: 'action',
              actionKey: 'action-01',
              actionTitle: 'Deferred Item 01'
            }]);
            break;
        };
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample19'}
        subtitle={'Deferred Elements'}
        description={[
          `Context menu with a deferred menu action item `
        ]}
      />
    </ContextMenuView>
  );
};