/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuAuxPreviewExample06(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample06',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        }],
      }}
      auxiliaryPreviewConfig={{
        // Configure the aux. preview to use the entire width of
        // the screen...
        //
        // 📝 Note: By default, this is set to: `stretchPreview`
        alignmentHorizontal: 'stretchScreen',
        transitionEntranceDelay: 'RECOMMENDED',
      }}
      renderAuxiliaryPreview={() => (
        <View style={styles.auxRootContainer}>
          <View style={[styles.innerContainer, {
            alignItems: 'center',
            justifyContent: 'center',
          }]}>
            <Text style={styles.textLabel}>
              Stretch to Edges of Screen
            </Text>
          </View>
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
        title={'ContextMenuAuxPreviewExample06'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview xxx`,
          `alignmentHorizontal: 'stretchScreen'`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer:{
    paddingHorizontal: 5,
  },
  innerContainer: {
    flex: 1,
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 10,
  },
  textLabel: {
    fontSize: 18,
    fontWeight: '600',
  },
});