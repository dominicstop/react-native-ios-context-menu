import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewSimpleExample07 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #7'}
        subtitle={'displayInline + destructive submenu'}
        desc={`Same as Example #3 (and Example #5 + Example #6) but the submenu has "destructive" and "displayInline" in it's menuOptions. This looks the same as "displayInline" submenu (i.e Example #5)`}
        onPressMenuItem={({key}) => alert(key)}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample07',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            imageType  : 'SYSTEM',
            imageValue : 'folder',
          }, {
            menuTitle: 'Submenu...',
            menuOptions: ['displayInline', 'destructive'],
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