import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewTest03 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        index={3}
        title={'Simple Example #3'}
        subtitle={'submenu'}
        desc={"Context menu with 1 action and 1 submenu (with 3 submenu actions)"}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest03',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            imageType  : 'SYSTEM',
            imageValue : 'folder',
          }, {
            menuTitle: 'Submenu...',
            menuItems: [{
              actionKey  : 'key-01-01',
              actionTitle: 'Submenu Action #1',
              imageType  : 'SYSTEM',
              imageValue : 'star',
            }, {
              actionKey  : 'key-01-02',
              actionTitle: 'Submenu Action #2',
              imageType  : 'SYSTEM',
              imageValue : 'star.lefthalf.fill',
            }, {
              actionKey  : 'key-01-03',
              actionTitle: 'Submenu Action #3',
              imageType  : 'SYSTEM',
              imageValue : 'star.fill',
            }]
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});