/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as COLORS from '../constants/Colors';


export function ContextMenuAuxPreviewExample04(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample04',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'yeah you know',
          actionSubtitle: 'what i feel right',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'arrow.right',
              weight: 'bold',
            },
            imageOptions: {
              tint: COLORS.BLUE.A700,
              renderingMode: 'alwaysOriginal',
            },
          },
        }],
      }}
      auxiliaryPreviewConfig={{
        // Align the aux. preview to the right...
        // 📝 Note: By default, this is set to: `stretchPreview`
        alignmentHorizontal: 'previewTrailing',
        transitionEntranceDelay: 'RECOMMENDED',
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Yeah right, yeah right
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
        title={'ContextMenuAuxPreviewExample04'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview aligned to the right.`,
          `alignmentHorizontal: 'previewTrailing'`
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