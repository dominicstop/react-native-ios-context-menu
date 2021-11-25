import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample05(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample04',
        menuItems: [{
          actionKey     : 'key-01',
          actionTitle   : 'Disabled Action',
          menuAttributes: ['disabled'],
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'folder',
          }
        }, {
          actionKey     : 'key-02'   ,
          actionTitle   : 'Destructive Action',
          menuAttributes: ['destructive'],
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'trash',
          }
        }, {
          actionKey     : 'key-03'   ,
          actionTitle   : 'Hidden Action',
          menuAttributes: ['hidden'],
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'trash',
          }
        }, {
          actionKey     : 'key-04'   ,
          actionTitle   : 'Disabled/Destructive',
          menuAttributes: ['disabled', 'destructive'],
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'trash.fill',
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample05'}
        subtitle={'inline submenu'}
        description={[
          `Same as Example #3 but the submenu has "displayInline" in it's menuOptions`
        ]}
      />
    </ContextMenuView>
  );
};