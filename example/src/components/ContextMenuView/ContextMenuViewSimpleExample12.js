import React, { useState, useRef } from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample12(props) {
  const [timer, setTimer] = useState(0);
  const increment = useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((timer) => timer + 1);
    }, 1000);
  };

  const handleStop = () => {
    clearInterval(increment.current);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #12'}
      subtitle={'Custom Preview #2 - Counter'}
      desc={`Another custom preview example. Show counter in the context menu, configure menu with a menu action to add 100 to the counter and a action to reset the counter.`}
      // `ContextMenuView` Props
      previewConfig={{
        previewType: 'CUSTOM',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={{ padding: 20 }}>
          <Text style={{fontSize: 32}}>
            {`Counter: ${timer}`}
          </Text>
          <Text style={{fontSize: 32}}>
            {(timer % 2 == 0)? 'EVEN' : 'The number is: ODD'}
          </Text>
        </View>
      )}
      onMenuDidShow={() => handleStart()}
      onMenuDidHide={() => handleStop()}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'add':
            setTimer((timer) => timer + 100);
            break;

          case 'reset':
            handleReset();
            break;
        };
      }}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample12',
        menuItems: [{
          actionKey     : 'add',
          actionTitle   : `Add 100`,
          imageType     : 'SYSTEM',
          imageValue    : 'plus',
        }, (timer > 0) && {
          actionKey     : 'reset',
          actionTitle   : `Reset Counter`,
          imageType     : 'SYSTEM',
          imageValue    : 'trash',
          menuAttributes: ['destructive']
        }],
      }}
    />
  );
};

const styles = StyleSheet.create({
});