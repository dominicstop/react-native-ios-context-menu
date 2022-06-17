/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, TouchableOpacity, View, Text, StyleSheet } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as COLORS from '../constants/Colors';


export function ContextMenuViewExample19(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      auxiliaryPreviewConfig={{
        transitionEntranceDelay: 'RECOMMENDED',
        transitionConfigEntrance: {
          transition: 'zoomAndSlide',
          duration: 0.3,
        }
      }}
      onMenuAuxiliaryPreviewWillShow={(event) => {
        console.log('onMenuAuxiliaryPreviewWillShow', event.nativeEvent);
      }}
      onMenuAuxiliaryPreviewDidShow={(event) => {
        console.log('onMenuAuxiliaryPreviewDidShow', event.nativeEvent);
      }}
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
          <TouchableOpacity style={styles.buttonContainer}>
            <Text style={styles.buttonLabel}>
              Button
            </Text>
          </TouchableOpacity>
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
    borderRadius: 10,
    padding: 10,
  },
  buttonContainer: {
    backgroundColor: COLORS.PURPLE.A700,
    paddingHorizontal: 10,
    paddingVertical: 5,
    maxWidth: 200,
    borderRadius: 10,
  },
  buttonLabel: {
    fontWeight: 'bold',
    color: 'white',
  },
});