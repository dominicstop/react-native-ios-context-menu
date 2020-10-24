import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewTest08 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        index={8}
        title={'Simple Example #8'}
        subtitle={'menuState'}
        desc={`Context menu with 3 actions that has "on", "off", and "mixed" menuState`}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest08',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'menuState: on',
            imageType  : 'SYSTEM',
            imageValue : 'folder',
            menuState  : 'on',
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'menuState: off',
            imageType  : 'SYSTEM',
            imageValue : 'dial',
            menuState  : 'off',
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'menuState: mixed',
            imageType  : 'SYSTEM'   ,
            imageValue : 'archivebox',
            menuState  : 'mixed',
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});