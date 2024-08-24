/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Text, View } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample12(props: ContextMenuExampleProps) {
  // increments every second...
  const [timer, setTimer] = React.useState(0);
  const increment = React.useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((prevTimer) => prevTimer + 1);
    }, 1000);
  };

  const handleStop = () => {
    clearInterval(increment.current);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample12',
        menuItems: [{
          actionKey  : 'add',
          actionTitle: `Add 100`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'plus',
            },
          }
        }, (timer > 0) && {
          actionKey     : 'reset',
          actionTitle   : `Reset Counter`,
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }],
      }}
      previewConfig={{
        previewType: 'CUSTOM',
        backgroundColor: 'white'
      }}
      // The context menu preview grows and shrinks due to the labels/
      // text changing every second...
      renderPreview={() => (
        <View style={{ padding: 20 }}>
          <Text style={{fontSize: 32}}>
            {`Counter: ${timer}`}
          </Text>
          <Text style={{fontSize: 32}}>
            {(timer % 2 === 0)? 'EVEN' : 'The number is: ODD'}
          </Text>
        </View>
      )}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleStop()}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'add':
            setTimer((prevTimer) => prevTimer + 100);
            break;

          case 'reset':
            handleReset();
            break;
        };
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample12'}
        description={[
          `Another custom preview example.`,
          `Show counter in the context menu preview, and configure menu with a action to add 100 to the counter, and another action to reset the counter.`
        ]}
      />
    </ContextMenuView>
  );
};