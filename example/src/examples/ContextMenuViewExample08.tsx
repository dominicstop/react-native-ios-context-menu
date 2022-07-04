import * as React from 'react';
import { Alert } from 'react-native';

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
          // show a checkmark
          menuState: 'on',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'menuState: off',
          // no checkmark
          menuState: 'off',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'dial',
            },
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'menuState: mixed',
          menuState  : 'mixed',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'archivebox',
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
        title={'ContextMenuViewExample08'}
        subtitle={'menuState'}
        description={[
          `Context menu with 3 actions that has "on", "off", and "mixed" menuState.`
        ]}
      />
    </ContextMenuView>
  );
};