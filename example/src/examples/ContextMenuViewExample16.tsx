import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample16(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample16',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'No Icon',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Use "SYSTEM" icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'dial.fill',
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Use "ASSET" icon',
          icon: {
            iconType : 'ASSET',
            iconValue: 'icon-rainbow-flag',
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample16'}
        subtitle={'ImageType Icons'}
        description={[
          `Context menu with an action that uses a 'ASSET' icon`
        ]}
      />
    </ContextMenuView>
  );
};