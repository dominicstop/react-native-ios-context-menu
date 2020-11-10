import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample16() {
  return(
    <ExampleContextMenuItem
      {...this.props}
      title={'Simple Example #16'}
      subtitle={'ImageType Icons'}
      desc={'Context menu with 3 actions that uses `ASSET` icons'}
      // `ContextMenuView` Props
      onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
      onPressMenuPreview={() => alert('onPressMenuPreview')}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample16',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          discoverabilityTitle: 'No Icon'
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          imageType  : 'SYSTEM',
          imageValue : 'dial.fill',
          discoverabilityTitle: 'Use "SYSTEM" icon'

        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          imageType  : 'ASSET'   ,
          imageValue : 'icon-rainbow-flag',
          discoverabilityTitle: 'Use "ASSET" icon'
        }],
      }}
      
    />
  );
};

const styles = StyleSheet.create({
});