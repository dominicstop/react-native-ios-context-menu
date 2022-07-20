import * as React from 'react';

import { ContextMenuButton } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';

import { ContextMenuButtonCard } from '../components/ContextMenuButtonCard';
import { ContextMenuCardButton } from '../components/ContextMenuCardButton';

import * as Helpers from '../functions/Helpers';


export function ContextMenuButtonExample03(props: ContextMenuExampleProps) {
  const menuRef = React.useRef<ContextMenuButton>();

  return (
    <ContextMenuButtonCard
      style={props.style}
      index={props.index}
      title={'ContextMenuButtonExample03'}
      subtitle={'Deferred Elements'}
      description={[
        `Context menu button with a deferred menu action item`,
        `Also, to test if 'dismissMenu' works, the context menu will auto close after 7 seconds...`
      ]}
    >
      <ContextMenuButton
        ref={menuRef}
        isMenuPrimaryAction={true}
        menuConfig={{
          menuTitle: 'ContextMenuButtonSimpleExample02',
          menuItems: [{
            // Create a deferred menu item... this will act as a placeholder
            // and will be replaced with the actual menu items later
            type: 'deferred',

            // if we have multiple deferred items, you can use the `deferredID`
            // to distinguish between them
            deferredID: 'deferred-01',
            shouldCache: false,
          }],
        }}
        // this event will fire when a deferred menu item is present...
        onRequestDeferredElement={async (deferredID, provider) => {
          switch(deferredID) {
            case 'deferred-01':
              // dummy delay, wait for 1 second...
              await Helpers.timeout(2000);

              // provide the items to add to the context menu...
              provider([{
                type: 'menu',
                menuTitle: 'Deferred Submenu...',
                menuItems: [{
                  type: 'action',
                  actionKey: 'action-02',
                  actionTitle: 'Deferred Item 02',
                  actionSubtitle: 'Deferred item...'
                }, {
                  type: 'action',
                  actionKey: 'action-03',
                  actionTitle: 'Deferred Item 03',
                  actionSubtitle: 'Deferred item...'
                }],
              }]);
              break;
          };
        }}
        onMenuDidShow={async () => {
          await Helpers.timeout(7000);
          menuRef.current.dismissMenu();
        }}
      >
        <ContextMenuCardButton
          buttonTitle={'⭐️ Context Menu Button'}
        />
      </ContextMenuButton>
    </ContextMenuButtonCard>
  );
};