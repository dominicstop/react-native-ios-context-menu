import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample17(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample17',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'Blue Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'cloud.heavyrain.fill',
            },
            // blue icon
            imageOptions: {
              tint: 'blue',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-02',
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Orange Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'exclamationmark.triangle.fill',
            },
            // orange icon
            imageOptions: {
              tint: 'rgb(218,165,32)',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-03',
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Pink Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'heart.fill',
            },
            // pink icon
            imageOptions: {
              tint: '#FF1493',
              renderingMode: 'alwaysOriginal',
            },
          },
        }, {
          actionKey  : 'key-04',
          actionTitle: 'Action #4',
          discoverabilityTitle: 'Green Icon',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'bubble.right.fill',
            },
            // green icon
            imageOptions: {
              tint: 'rgba(124,252,0,0.5)',
              renderingMode: 'alwaysOriginal',
            },
          },
        }]
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample17'}
        subtitle={'Icon colors'}
        description={[
          `Context menu icon colors example`
        ]}
      />
    </ContextMenuView>
  );
};