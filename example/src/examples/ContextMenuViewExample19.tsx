/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample19(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample19',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
        }],
      }}
      renderAuxillaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          // by default, the root view you returned will be resized to match
          // the width of the preview (you can override this behavior via the
          // `auxiliaryPreviewConfig` prop).
          //
          // since this view is going to be resized, let's center the content
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Hello World
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
        title={'ContextMenuViewExample19'}
        subtitle={'EXPERIMENTAL - Aux. Preview Simple'}
        description={[
          `Basic 'ContextMenuView' w/ a basic auxillary preview configuration.`
        ]}
      />
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer: {
    backgroundColor: 'white',
  },
  textLabel: {
    fontWeight: 'bold',
    borderRadius: 10,
    padding: 10,
  },
});