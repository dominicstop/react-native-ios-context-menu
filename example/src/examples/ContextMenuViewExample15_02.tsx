import * as React from 'react';
import { StyleSheet, Text, Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';
import { WrapperView } from 'react-native-ios-utilities';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample15_02(props: ContextMenuExampleProps) {
  const wrapperViewRef = React.useRef<WrapperView>();

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample15',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }],
      }}
      previewConfig={{
        // get the associated `reactTag` of the view element you want use as the 
        // preview target
        targetViewNode: wrapperViewRef.current?.getNativeReactTag(),
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample15-02'}
        subtitle={'Preview Target + WrapperView'}
        description={[
          `Example context menu with a specific preview target using WrapperView`
        ]}
      >
        <WrapperView
          // @ts-ignore
          ref={wrapperViewRef}
          style={styles.targetContainer}
        >
          <Text style={styles.text}>
            {`Hello inside: WrapperView\nTarget Node: ${wrapperViewRef.current?.getNativeReactTag()}`}
          </Text>
        </WrapperView>
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  targetContainer: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    alignSelf: 'flex-start',
    padding: 10,
    borderRadius: 10,
    marginTop: 10,
  },
  text: {
    fontSize: 16,
  }
});