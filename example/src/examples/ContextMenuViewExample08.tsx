import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample08(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample08',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'menuState: on',
          menuState  : 'on',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'folder',
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'menuState: off',
          menuState  : 'off',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'dial',
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'menuState: mixed',
          menuState  : 'mixed',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'archivebox',
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample08'}
        subtitle={'menuState'}
        description={[
          `Context menu with 3 actions that has "on", "off", and "mixed" menuState.`
        ]}
      />
    </ContextMenuView>
  );
};