import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


const MenuConfig01 = {
  menuTitle: 'Menu Test 1',
  // can be another menu or an action
  menuItems: [{
    actionKey: 'key-01',
    actionTitle: 'Action #1'
  }, {
    actionKey  : 'key-02'   ,
    actionTitle: 'Action #2',
  }, {
    actionKey  : 'key-03'   ,
    actionTitle: 'Action #3',
  }],
};

export class ContextMenuViewTest01 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        index={1}
        title={'Simple Example #1'}
        desc={'Context menu with 3 actions (no icon, just text)'}
        menuConfig={MenuConfig01}
      />
    );
  };
};

const styles = StyleSheet.create({
});