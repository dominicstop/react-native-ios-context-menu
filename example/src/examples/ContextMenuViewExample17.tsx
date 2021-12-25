import * as React from 'react';

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
            imageOptions: {
              tint: 'blue',
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
            imageOptions: {
              tint: 'rgb(218,165,32)',
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
            imageOptions: {
              tint: '#FF1493',
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
            imageOptions: {
              tint: 'rgba(124,252,0,0.5)',
            },
          },
        }]
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