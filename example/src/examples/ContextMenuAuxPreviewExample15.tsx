/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Colors from '../constants/Colors';


export function ContextMenuAuxPreviewExample15(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample15',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          actionSubtitle: 'Dummy action'
        }],
      }}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        alignmentHorizontal: 'previewCenter',

        // The space between the aux. preview, and the
        // menu preview...
        // 
        // A negative value means that you want the aux. preview
        // to appear closer to the menu preview.
        //
        // This is particularly useful if the menu preview is
        // too big, and it causes the menu items to go out of 
        // bounds...
        marginPreview: -60,
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
        previewSize: 'STRETCH',
      }}
      renderPreview={() => (
        <View style={[styles.previewRootContainer, {
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Custom Menu Preview
          </Text>
        </View>
      )}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewExample15'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Basic 'ContextMenuView' w/ a auxillary preview that has negative margins `
          + `so that aux. preview overlaps inside the menu preview`,
          `marginPreview`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer: {
    backgroundColor: Colors.PURPLE[100],
    borderRadius: 10,
    padding: 10,
    width: 200,
    borderColor: Colors.PURPLE.A700,
    borderWidth: 1,
  },
  previewRootContainer: {
    backgroundColor: 'white',
    padding: 10,
  },
  textLabel: {
    fontSize: 18,
    fontWeight: '600',
  },
});