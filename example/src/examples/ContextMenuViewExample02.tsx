import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample02(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
          menuTitle: 'ContextMenuViewExample02',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'folder',
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'dial.fill',
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'archivebox.fill',
            }
          }],
        }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample02'}
        subtitle={'actions w/ icons'}
        description={[
          `Context menu with 3 actions (text w/ system icon)`
        ]}
      />
    </ContextMenuView>
  );
};