/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';

import { ContextMenuView, MenuAuxiliaryPreviewHorizontalAlignment } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

const ALIGNMENT_MODES: MenuAuxiliaryPreviewHorizontalAlignment[] = [
  'previewCenter',
  'previewLeading',
  'previewTrailing',
  'stretchPreview',
  'stretchScreen',
];


export function ContextMenuAuxPreviewTest02(props: ContextMenuExampleProps) {
  const [modeIndex, setModeIndex] = React.useState(0);

  let currentMode = ALIGNMENT_MODES[modeIndex % ALIGNMENT_MODES.length];

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewTest02',
        menuItems: [false && {
          type: 'action',
          actionKey: 'abc',
          actionTitle: 'Hello'
        }],
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        alignmentHorizontal: currentMode
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Aux. Preview
          </Text>
        </View>
      )}
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'INHERIT',
      }}
      renderPreview={() => (
        <View style={styles.previewRootContainer}>
          <Text style={styles.textLabel}>
            {`alignmentHorizontal: ${currentMode}`}
          </Text>
        </View>
      )}
      onMenuDidHide={() => {
        setModeIndex(index => index + 1);
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewTest02'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Cycle through all the 'alignmentHorizontal' values + custom preview`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  previewRootContainer: {
    paddingHorizontal: 10,
    paddingVertical: 8,
    backgroundColor: 'white',
    minWidth: 300,
    minHeight: 200,
    alignItems: 'center',
    justifyContent: 'center',
  },
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