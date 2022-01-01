import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample05(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample04',
        menuItems: [{
          actionKey     : 'key-01',
          actionTitle   : 'Disabled Action',
          menuAttributes: ['disabled'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey     : 'key-02'   ,
          actionTitle   : 'Destructive Action',
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }, {
          actionKey     : 'key-03'   ,
          actionTitle   : 'Hidden Action',
          menuAttributes: ['hidden'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }, {
          actionKey     : 'key-04'   ,
          actionTitle   : 'Disabled/Destructive',
          menuAttributes: ['disabled', 'destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash.fill',
            },
          }
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
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