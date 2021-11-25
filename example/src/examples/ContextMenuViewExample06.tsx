import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample06(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample06',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'folder',
          }
        }, {
          menuTitle: 'Submenu...',
          menuOptions: ['destructive'],
          menuItems: [{
            actionKey  : 'key-01-01',
            actionTitle: 'Submenu Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'star',
            }
          }, {
            actionKey  : 'key-01-02',
            actionTitle: 'Submenu Action #2',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'star.lefthalf.fill',
            }
          }, {
            actionKey  : 'key-01-03',
            actionTitle: 'Submenu Action #3',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'star.fill',
            }
          }]
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample06'}
        subtitle={'destructive submenu'}
        description={[
          `Same as Example #3 but the submenu has "destructive" in it's menuOptions`
        ]}
      />
    </ContextMenuView>
  );
};