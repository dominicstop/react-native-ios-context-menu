import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Helpers from '../functions/Helpers';


export function ContextMenuViewExample20(props: ContextMenuExampleProps) {
  const [extraMenuItems, setExtraMenuItems] = React.useState([]);

  const [isLoading, setIsLoading] = React.useState(true);
  const [didLoadItems, setDidLoadItems] = React.useState(false);

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample20',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        },

        // add deferred item so that the loading indicator
        // appears...
        isLoading && ({
          type: 'deferred',
          deferredID: 'deferred-01'
        }), 

        // add the extra menu items...
        ...extraMenuItems,

        didLoadItems && ({
          type: 'menu',
          menuTitle: '',
          menuOptions: ['displayInline'],
          menuItems: [{
            type: 'action',
            actionKey: 'clear_cache',
            actionTitle: 'Clear Cache',
            actionSubtitle: 'Remove loaded items...',
            menuAttributes: ['destructive'],
          }]
        })],
      }}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'clear_cache':
            // reset state...
            setExtraMenuItems([]);
            setIsLoading(false);
            setDidLoadItems(false);
            break;
        
          default:
            Alert.alert(
              'onPressMenuItem Event',
              `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
            );
        };
      }}
      // this event will fire when a deferred menu item is present...
      onMenuWillShow={async () => {
        if(didLoadItems) return;

        // for the purposes of this example, let's add a delay
        // before showing the loading indicator...
        // 
        // this way, we can see the context menu updating and
        // showing the loading indicator.
        // 
        // Ideally, `isLoading` should already be set to `true`
        // before the context menu is shown...
        await Helpers.timeout(750);
        setIsLoading(true);

        // loading...
        // dummy delay, wait for 2 second...
        await Helpers.timeout(2000);
        setDidLoadItems(true);

        // add extra menu items
        setExtraMenuItems([{
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

        // hide the loading indicator
        setIsLoading(false);
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample20'}
        subtitle={'Deferred Elements'}
        description={[
          `Context menu with a deferred menu action item `
        ]}
      />
    </ContextMenuView>
  );
};