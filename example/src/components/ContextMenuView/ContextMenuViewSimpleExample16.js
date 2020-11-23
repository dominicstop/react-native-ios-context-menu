import React from 'react';
import { StyleSheet, Image, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample16(props) {
  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #16'}
      subtitle={'ImageType Icons'}
      desc={'Context menu with an action that uses a `ASSET` icon'}
      // `ContextMenuView` Props
      onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
      onPressMenuPreview={() => alert('onPressMenuPreview')}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample16',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'No Icon',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Use "SYSTEM" icon',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'dial.fill',
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Use "ASSET" icon',
          icon: {
            iconType : 'ASSET',
            iconValue: 'icon-rainbow-flag',
          }
        }],
      }}
    />
  );
};

const styles = StyleSheet.create({
});