import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';



export function ContextMenuViewSimpleExample13(props) {
  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #13'}
      subtitle={'discoverabilityTitle'}
      desc={'Context menu with 3 actions that has the `discoverabilityTitle` set.'}
      // `ContextMenuView` Props
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample13',
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
    />
  );
};

const styles = StyleSheet.create({
});