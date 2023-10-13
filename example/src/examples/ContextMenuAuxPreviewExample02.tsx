/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as COLORS from '../constants/Colors';


export function ContextMenuAuxPreviewExample02(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample02',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Shorter Delay',
        }],
      }}
      // If you want to immediately show the aux. preview, then
      // set `transitionEntranceDelay` to: `RECOMMENDED`.
      // 
      // The default is: `AFTER_PREVIEW`.
      //
      // You can also pass in a number indicating how long delay
      // is in seconds  (e.g. 0.3).
      //
      // Note: Do not pass in a number below 0.25 to avoid any
      // layout bugs...
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED'
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Faster Transition
          </Text>
        </View>
      )}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewExample02'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that shows up faster`,
          `transitionEntranceDelay: RECOMMENDED'`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer: {
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 10,
    width: 200,
  },
  textLabel: {
    fontSize: 18,
    fontWeight: '600',
    color: COLORS.BLUE.A700,
  },
});