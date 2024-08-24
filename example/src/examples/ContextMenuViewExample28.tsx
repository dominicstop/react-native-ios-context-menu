
import * as React from 'react';

import { CardButton } from 'react-native-ios-utilities';
import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ExampleItemProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample28(props: ExampleItemProps) {
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
