import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample10(props: ContextMenuExampleProps) {
  const [timer, setTimer] = React.useState(0);
  const increment = React.useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((prevTimer) => prevTimer + 1);
    }, 1000);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return (
    <ContextMenuView
      style={props.style}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleReset()}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample10',
        menuItems: [{
          actionKey  : 'key-00',
          actionTitle: `Static Action`,
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'square.and.arrow.down',
          }
        }, {
          actionKey  : 'key-01',
          actionTitle: `timer: ${timer}`,
          icon: {
            iconType : 'SYSTEM',
            iconValue: ((timer % 2 === 0)
              ? 'heart'
              : 'heart.fill'
            ),
          }
        }, (timer % 3 === 0) && {
          actionKey  : 'key-02',
          actionTitle: `Dynamic Action`,
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'scissors.badge.ellipsis',
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample10'}
        description={[
          `On iOS 14+ you can update the menu while it's visible (e.g. you can control the menu via state).`,
          `This is a simple demo where the menu action changes every time the counter increments every second.`
        ]}
      />
    </ContextMenuView>
  );
};