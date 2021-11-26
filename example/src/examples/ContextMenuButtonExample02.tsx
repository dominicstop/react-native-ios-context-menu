import * as React from 'react';

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
        <ContextMenuCardButton
          buttonTitle={'⭐️ Context Menu Button'}
        />
      </ContextMenuButton>
    </ContextMenuButtonCard>
  );
};