/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuAuxPreviewExample08(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample08',
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        // Configure the aux. preview to always appear on top of
        // the context menu preview...
        //
        // 📝 Note: This is set to `automatic` by default.
        anchorPosition: 'top',
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Always Top
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
            Context Menu Preview
          </Text>
        </View>
      )}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewExample08'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that's anchored to the top.`,
          `anchorPosition: 'top'`
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