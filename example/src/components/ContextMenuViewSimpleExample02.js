import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewSimpleExample02 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #2'}
        subtitle={'actions w/ icons'}
        desc={'Context menu with 3 actions (text w/ system icon)'}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample02',
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