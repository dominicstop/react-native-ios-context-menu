import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuButton } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';

import { ContextMenuButtonCard } from '../components/ContextMenuButtonCard';
import { ContextMenuCardButton } from '../components/ContextMenuCardButton';


export function ContextMenuButtonExample02(props: ContextMenuExampleProps) {
  return (
    <ContextMenuButtonCard
      style={props.style}
      index={props.index}
      title={'ContextMenuButtonExample02'}
      subtitle={'actions text-only'}
      description={[
        `Context menu button but we set the 'isMenuPrimaryAction' prop to true.`,
        `Press the button to show menu.`
      ]}
    >
      <ContextMenuButton
        isMenuPrimaryAction={true}
        menuConfig={{
          menuTitle: 'ContextMenuButtonSimpleExample02',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'folder',
              },
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'dial.fill',
              },
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'archivebox.fill',
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
        <ContextMenuCardButton
          buttonTitle={'⭐️ Context Menu Button'}
        />
      </ContextMenuButton>
    </ContextMenuButtonCard>
  );
};