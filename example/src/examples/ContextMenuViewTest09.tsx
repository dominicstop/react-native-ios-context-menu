import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest09(props: ContextMenuExampleProps) {
  const [counter, setCounter] = React.useState(0);

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest09',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: `Counter: ${counter}`,
        }, {
          type: 'deferred',
          deferredID: `deferred-a-${counter}`
        }, {
          type: 'deferred',
          deferredID: `deferred-b-${counter}`
        }, {
          type: 'deferred',
          deferredID: `deferred-c-${counter}`
        }, {
          type: 'deferred',
          deferredID: `deferred-d-${counter}`
        }]
      }}
      onMenuDidHide={() => {
        setCounter(prevCount => prevCount + 1);
      }}
    >
    <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest09'}
        subtitle={'Deferred Elements - Cleanup'}
        description={[
            `Generate new 'deferredID' everytime the context menu is shown/hide. `
          + `Test for 'cleanupOrphanedDeferredElements'.`
        ]}
      />
    </ContextMenuView>
  );
};