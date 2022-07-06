/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Text, View, Alert, TouchableOpacity } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample14(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'rgba(255,255,255,0.75)',
        // change the exit transition that occurs when the 
        // context menu preview is pressed.
        preferredCommitStyle: 'pop',
      }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <TouchableOpacity>
            <Text style={{fontSize: 32}}>
              Hello World
            </Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={{fontSize: 32}}>
              Hello World
            </Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={{fontSize: 32}}>
              Hello World
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
        title={'ContextMenuViewExample14'}
        description={[
          `Show a custom preview for the context menu with the "preferredCommitStyle" property in the "PreviewConfig" prop set to "pop"`
        ]}
      />
    </ContextMenuView>
  );
};