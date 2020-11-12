import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewSimpleExample08 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #8'}
        subtitle={'menuState'}
        desc={`Context menu with 3 actions that has "on", "off", and "mixed" menuState`}
        // `ContextMenuView` Props
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample08',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'menuState: on',
            menuState  : 'on',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'folder',
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'menuState: off',
            menuState  : 'off',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'dial',
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'menuState: mixed',
            menuState  : 'mixed',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'archivebox',
            }
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});