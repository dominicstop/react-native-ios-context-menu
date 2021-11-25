import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample03(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample03',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'folder',
          }
        }, {
          menuTitle: 'Submenu...',
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
        title={'ContextMenuViewExample03'}
        subtitle={'submenu'}
        description={[
          `Context menu with 1 action, and 1 submenu that has 3 submenu actions.`
        ]}
      />
    </ContextMenuView>
  );
};