/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuAuxPreviewExample09(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample09',
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        // Configure the aux. preview to always appear on the
        // bottom of the context menu preview...
        //
        // 📝 Note: This is set to `automatic` by default.
        anchorPosition: 'bottom',
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Always Bottom
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
        title={'ContextMenuAuxPreviewExample09'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that's anchored to the bottom.`,
          `anchorPosition: 'bottom'`
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