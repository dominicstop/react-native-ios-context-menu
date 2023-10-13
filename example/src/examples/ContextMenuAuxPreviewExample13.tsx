/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuAuxPreviewExample13(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample13',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        }],
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        // Add some space between the aux. preview, and the
        // menu preview...
        marginPreview: 30,
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Distance from Preview
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
        title={'ContextMenuAuxPreviewExample13'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that has custom margins`,
          `MenuAuxiliaryPreviewConfig.marginPreview`
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
  },
});