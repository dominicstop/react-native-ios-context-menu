import * as React from 'react';
import { StyleSheet } from 'react-native';
import { ContextMenuView } from 'react-native-ios-context-menu';

import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample01(props: {
  index: number
}) {
  return (
    <ContextMenuView
      menuConfig={{
        menuTitle: 'ContextMenuViewExample01',
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
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample01'}
        description={[
          `Basic 'ContextMenuView' usage.`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({

});
