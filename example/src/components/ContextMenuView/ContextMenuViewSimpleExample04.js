import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewSimpleExample04 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #4'}
        subtitle={'menuAttributes'}
        desc={'Context menu with a "disabled" action, a "destructive" action, a "hidden" action (which is not visible), and a disabled + destructive action'}
        // `ContextMenuView` Props
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample04',
          menuItems: [{
            actionKey     : 'key-01',
            actionTitle   : 'Disabled Action',
            menuAttributes: ['disabled'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'folder',
            }
          }, {
            actionKey     : 'key-02'   ,
            actionTitle   : 'Destructive Action',
            menuAttributes: ['destructive'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'trash',
            }
          }, {
            actionKey     : 'key-03'   ,
            actionTitle   : 'Hidden Action',
            menuAttributes: ['hidden'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'trash',
            }
          }, {
            actionKey     : 'key-04'   ,
            actionTitle   : 'Disabled/Destructive',
            menuAttributes: ['disabled', 'destructive'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'trash.fill',
            }
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});