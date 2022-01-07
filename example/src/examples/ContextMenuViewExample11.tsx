/* eslint-disable react-native/no-inline-styles */

import * as React from 'react';
import { View, Text, Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample11(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
        </View>
      )}
      onPressMenuPreview={() => {
        Alert.alert(
          'onPressMenuPreview Event',
          `Menu preview was pressed...`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample11'}
        subtitle={'Custom Preview'}
        description={[
          `Show a custom preview for the context menu.`
        ]}
      />
    </ContextMenuView>
  );
};