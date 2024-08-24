import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample10(props: ContextMenuExampleProps) {
  // `timer` will increment every second... 
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
      menuConfig={{
        menuTitle: 'ContextMenuViewExample10',
        menuItems: [{
          actionKey  : 'key-00',
          actionTitle: `Static Action`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'square.and.arrow.down',
            },
          }
        }, {
          actionKey  : 'key-01',
          // update the action title every second...
          actionTitle: `timer: ${timer}`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
               // update the icon every second...
              systemName: ((timer % 2 === 0)
                ? 'heart'
                : 'heart.fill'
              ),
            },
          }
        }, 
        // this item will be added and removed...
        (timer % 3 === 0) && {
          actionKey  : 'key-02',
          actionTitle: `Dynamic Action`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'scissors.badge.ellipsis',
            },
          }
        }],
      }}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleReset()}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
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