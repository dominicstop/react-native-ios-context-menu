import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest08(props: ContextMenuExampleProps) {
  const [counter, setCounter] = React.useState(0);

  const menuRef = React.useRef<ContextMenuView>();
  const intervalRef = React.useRef<NodeJS.Timer | undefined>();

  React.useEffect(() => {
    return () => {
      if(!intervalRef.current) return;
      clearInterval(intervalRef.current);
    };
  }, []);

  return (
    <ContextMenuView
      style={props.style}
      ref={menuRef}
      previewConfig={{
        previewType: 'CUSTOM',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={styles.previewContainer}>
          <Text style={styles.previewCounterText}>
            {`Will Dismiss in: ${3 - counter}`}
          </Text>
        </View>
      )}
      onMenuDidShow={() => {
        let internalCounter = 0;

        intervalRef.current = setInterval(async () => {
          setCounter(prevValue => (prevValue + 1));
          internalCounter++;
          
          if(internalCounter === 3) {
            await menuRef.current?.dismissMenu();
            clearInterval(intervalRef.current);
          };
        }, 500);
      }}
      onMenuDidHide={() => {
        clearInterval(intervalRef.current);
        setCounter(0);
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest08'}
        subtitle={'dismiss menu'}
        description={[
          `Test for programmatically dismissing the menu.`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  previewContainer: {
    padding: 20,
  },
  previewCounterText: {
    fontSize: 32,
  },
});