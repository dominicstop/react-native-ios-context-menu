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
          // Create a deferred menu item... this will act as a placeholder
          // and will be replaced with the actual menu items later
          type: 'deferred',
          // if we have multiple deferred items, you can use the `deferredID`
          // to distinguish between them
          deferredID: 'deferred-01'
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
      // this event will fire when a deferred menu item is present...
      onRequestDeferredElement={async (deferredID, provider) => {
        switch(deferredID) {
          case 'deferred-01':
            // dummy delay, wait for 1 second...
            await Helpers.timeout(2000);

            // provide the items to add to the context menu...
            provider([{
              type: 'action',
              actionKey: 'action-02',
              actionTitle: 'Deferred Item 02',
              actionSubtitle: 'Deferred item...'
            }, {
              type: 'action',
              actionKey: 'action-03',
              actionTitle: 'Deferred Item 03',
              actionSubtitle: 'Deferred item...'
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