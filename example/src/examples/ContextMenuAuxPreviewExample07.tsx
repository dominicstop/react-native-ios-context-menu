/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuAuxPreviewExample07(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample07',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        }],
      }}
      auxiliaryPreviewConfig={{
        // Configure the aux. preview to have a fixed size 
        // of 100 x 100
        width: 100,
        height: 100,
        alignmentHorizontal: 'previewCenter',
        transitionEntranceDelay: 'RECOMMENDED',
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            100
          </Text>
          <Text style={styles.textLabel}>
            x
          </Text>
          <Text style={styles.textLabel}>
            100
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
        title={'ContextMenuAuxPreviewExample07'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that has fixed size`,
          '`auxiliaryPreviewConfig.width`\n`auxiliaryPreviewConfig.height`'
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
  },
  textLabel: {
    fontSize: 18,
    fontWeight: '600',
  },
});