import * as React from 'react';

import { ContextMenuView, OnPressMenuItemEvent } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Colors from '../constants/Colors';


export function ContextMenuViewExample24(props: ContextMenuExampleProps) {
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
        setActionState1((prevValue) => (!prevValue));
        setActionState2((prevValue) => (!prevValue));
        setActionState3((prevValue) => (!prevValue));
        break;
    };
  };

  return (
    <ContextMenuView
      style={props.style}
      onPressMenuItem={handleOnPressMenuItem}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample24',
        menuItems: [{
          actionKey: 'key-01',
          actionTitle: `Action 1: ${actionState1? 'on' : 'off'}`,
          menuState: (actionState1? 'on' : 'off'),
          menuAttributes: ['keepsMenuPresented'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: (actionState1
                ? 'heart.fill'
                : 'heart'
              ),
              scale: actionState1? 'large' : 'medium',
            },
            imageOptions: actionState1 && {
              renderingMode: 'alwaysOriginal',
              tint: Colors.RED.A700,
            },
          }
        }, {
          actionKey  : 'key-02',
          actionTitle: `Action 2: ${actionState2? 'on' : 'off'}`,
          menuState  : (actionState2? 'on' : 'off'),
          menuAttributes: ['keepsMenuPresented'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: (actionState2
                ? 'suit.club.fill'
                : 'suit.club'
              ),
              scale: actionState2? 'large' : 'medium',
            },
            imageOptions: actionState2 && {
              renderingMode: 'alwaysOriginal',
              tint: Colors.BLUE.A700,
            },
          }
        }, {
          actionKey: 'key-03',
          actionTitle: `Action 3: ${actionState3? 'on' : 'off'}`,
          menuState: (actionState3? 'on' : 'off'),
          menuAttributes: ['keepsMenuPresented'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: (actionState3
                ? 'suit.spade.fill'
                : 'suit.spade'
              ),
              scale: actionState3? 'large' : 'medium',
            },
            imageOptions: actionState3 && {
              renderingMode: 'alwaysOriginal',
              tint: Colors.AMBER.A700,
            },
          }
        }, {
          actionKey: 'key-04',
          actionTitle: `Reset All`,
          menuAttributes: [
            'keepsMenuPresented',
            isResetEnabled? 'destructive' : 'hidden',
          ],
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
        title={'ContextMenuViewExample24'}
        subtitle={'menuAttributes'}
        description={[
          `Example for menu actions that have menuAttributes set to 'keepsMenuPresented' `
          + 'Requires iOS 16+.'
        ]}
      />
    </ContextMenuView>
  );
};