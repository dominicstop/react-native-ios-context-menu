import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewTest01 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        index={1}
        title={'Simple Example #1'}
        desc={'Context menu with 3 actions (no icon, just text)'}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest01',
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
      />
    );
  };
};

const styles = StyleSheet.create({
});