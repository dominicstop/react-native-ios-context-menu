import React, { useState, useRef } from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample10(props) {

  const [timer, setTimer] = useState(0);
  const increment = useRef(null);

  const handleStart = () => {
    increment.current = setInterval(() => {
      setTimer((timer) => timer + 1);
    }, 1000);
  };

  const handleReset = () => {
    clearInterval(increment.current);
    setTimer(0);
  };

  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #10'}
      subtitle={'Update Menu'}
      desc={`On iOS 14+ you can update the menu while it's visible. So you can control the menu via state. This is a simple demo with a counter incrementing every second.`}
      // `ContextMenuView` Props
      onMenuDidShow={handleStart}
      onMenuDidHide={handleReset}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample10',
        menuItems: [{
          actionKey  : 'key-00',
          actionTitle: `Static Action`,
          imageType  : 'SYSTEM',
          imageValue : 'square.and.arrow.down',
        }, {
          actionKey  : 'key-01',
          actionTitle: `timer: ${timer}`,
          imageType  : 'SYSTEM',
          imageValue : ((timer % 2 == 0)
            ? 'heart'
            : 'heart.fill'
          ),
        }],
      }}
    />
  );
};

const styles = StyleSheet.create({
});