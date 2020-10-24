import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewTest02 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        index={2}
        title={'Simple Example #2'}
        desc={'Context menu with 3 actions (text w/ system icon)'}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest02',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            imageType  : 'SYSTEM',
            imageValue : 'folder',
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            imageType  : 'SYSTEM',
            imageValue : 'dial.fill',
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            imageType  : 'SYSTEM'   ,
            imageValue : 'archivebox.fill',
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});