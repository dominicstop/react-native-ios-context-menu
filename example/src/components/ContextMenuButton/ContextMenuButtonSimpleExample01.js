import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuButtonItem } from '../ExampleContextMenuButtonItem';



export class ContextMenuButtonSimpleExample01 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuButtonItem
        {...this.props}
        title={'Simple Example #1'}
        subtitle={'actions text-only'}
        desc={'Context menu with 3 actions (no icon, just text)'}
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample01',
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