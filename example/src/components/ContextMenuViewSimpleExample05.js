import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewSimpleExample05 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #5'}
        subtitle={'inline submenu'}
        desc={`Same as Example #3 but the submenu has "displayInline" in it's menuOptions`}
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample05',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            imageType  : 'SYSTEM',
            imageValue : 'folder',
          }, {
            menuTitle: 'Submenu...',
            menuOptions: ['displayInline'],
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