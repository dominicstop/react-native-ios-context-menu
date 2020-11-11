import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample17(props) {
  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #17'}
      subtitle={'Icon colors'}
      desc={'Context menu icon colors example'}
      // `ContextMenuView` Props
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample17',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'Blue Icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'cloud.heavyrain.fill',
            iconTint : 'blue',
          },
        }, {
          actionKey  : 'key-02',
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Orange Icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'exclamationmark.triangle.fill',
            iconTint : 'rgb(218,165,32)',
          },
        }, {
          actionKey  : 'key-03',
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Pink Icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'heart.fill',
            iconTint : '#FF1493',
          },
        }, {
          actionKey  : 'key-04',
          actionTitle: 'Action #4',
          discoverabilityTitle: 'Green Icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'bubble.right.fill',
            iconTint : 'rgba(124,252,0,0.5)',
          },
        }]
      }}
    />
  );
};

const styles = StyleSheet.create({
});