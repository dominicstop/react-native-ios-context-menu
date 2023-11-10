
import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';
import { CardButton } from '../components/Card/CardButton';


export function ContextMenuViewExample28(props: ContextMenuExampleProps) {
  const menuRef = React.useRef<ContextMenuView>(null);
  
  return (
    <ContextMenuView
      ref={menuRef}
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample28',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample28'}
        subtitle={'TBA'}

        description={[
          `TBA`
        ]}
      >
        <CardButton
          title={'Show Context Menu'}
          subtitle={'Programmatically shows the context menu'}
          onPress={() => {
            menuRef.current?.presentMenu();
          }}
        />
      </ContextMenuCard>
    </ContextMenuView>
  );
};
