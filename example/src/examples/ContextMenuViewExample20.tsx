/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as COLORS from '../constants/Colors';


export function ContextMenuViewExample20(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample20',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Shorter Delay',
        }],
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED'
      }}
      renderAuxillaryPreview={() => (
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
        title={'ContextMenuViewExample20'}
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