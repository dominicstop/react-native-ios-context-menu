import * as React from 'react';

import { ContextMenuView, OnPressMenuItemEvent } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest04(props: ContextMenuExampleProps) {
  const [actionToggle1, setActionToggle1] = React.useState(false);
  const [actionToggle2, setActionToggle2] = React.useState(false);
  const [actionToggle3, setActionToggle3] = React.useState(false);

  const isResetEnabled = (
    actionToggle1 ||
    actionToggle2 ||
    actionToggle3 
  );

  const handleOnPressMenuItem: OnPressMenuItemEvent = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'key-01':
        setActionToggle1((prevValue) => (!prevValue));
        break;

      case 'key-02':
        setActionToggle2((prevValue) => (!prevValue));
        break;

      case 'key-03':
        setActionToggle3((prevValue) => (!prevValue));
        break;

      case 'key-04':
        setActionToggle1((prevValue) => (!prevValue));
        setActionToggle2((prevValue) => (!prevValue));
        setActionToggle3((prevValue) => (!prevValue));
        break;
    };
  };

  return (
    <ContextMenuView
      style={props.style}
      onPressMenuItem={handleOnPressMenuItem}
      menuConfig={{
          menuTitle: 'ContextMenuViewTest04',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: `Action 1: ${actionToggle1? 'on' : 'off'}`,
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: (actionToggle1? 'heart.fill' : 'heart'),
              },
            }
          }, {
            actionKey  : 'key-02',
            actionTitle: `Action 2: ${actionToggle2? 'on' : 'off'}`,
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: (actionToggle2? 'suit.club.fill' : 'suit.club'),
              },
            }
          }, {
            actionKey  : 'key-03',
            actionTitle: `Action 3: ${actionToggle3? 'on' : 'off'}`,
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: (actionToggle3? 'suit.spade.fill' : 'suit.spade'),
              },
            }
          }, {
            menuTitle  : 'Inline Menu',
            menuOptions: ['displayInline'],
            menuItems  : [{
              actionKey     : 'key-04',
              actionTitle   : `Reset All`,
              menuAttributes: [isResetEnabled? 'destructive' : 'hidden'],
              menuState     : 'off',
              icon: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'trash',
                },
              }
            }],
          }]
        }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest04'}
        subtitle={'toggle icons'}
        description={[
          `Test for toggling the menu icons from state`
        ]}
      />
    </ContextMenuView>
  );
};