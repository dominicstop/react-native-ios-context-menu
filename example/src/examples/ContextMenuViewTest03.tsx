import * as React from 'react';

import { ContextMenuView, OnPressMenuItemEvent } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest03(props: ContextMenuExampleProps) {
  const [actionState1, setActionState1] = React.useState(false);
  const [actionState2, setActionState2] = React.useState(false);
  const [actionState3, setActionState3] = React.useState(false);

  const isResetEnabled = (
    actionState1 ||
    actionState2 ||
    actionState3 
  );

  const handleOnPressMenuItem: OnPressMenuItemEvent = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'key-01':
        setActionState1((prevValue) => (!prevValue));
        break;

      case 'key-02':
        setActionState2((prevValue) => (!prevValue));
        break;

      case 'key-03':
        setActionState3((prevValue) => (!prevValue));
        break;

      case 'key-04':
        setActionState1(false);
        setActionState2(false);
        setActionState3(false);
        break;
    };
  };

  return (
    <ContextMenuView
      style={props.style}
      onPressMenuItem={handleOnPressMenuItem}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest03',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: `Action 1: ${actionState1? 'on' : 'off'}`,
          menuState  : (actionState1? 'on' : 'off'),
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'heart',
            },
          }
        }, {
          actionKey  : 'key-02',
          actionTitle: `Action 2: ${actionState2? 'on' : 'off'}`,
          menuState  : (actionState2? 'on' : 'off'),
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'suit.club',
            },
          }
        }, {
          actionKey  : 'key-03',
          actionTitle: `Action 3: ${actionState3? 'on' : 'off'}`,
          menuState  : (actionState3? 'on' : 'off'),
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'suit.spade',
            },
          }
        }, {
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
        }]
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest03'}
        subtitle={'toggle menuState'}
        description={[
          `Test for toggling the menuState on/off`
        ]}
      />
    </ContextMenuView>
  );
};