import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuButtonItem } from '../ExampleContextMenuButtonItem';


export class ContextMenuButtonSimpleExample02 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuButtonItem
        {...this.props}
        title={'Simple Example #2'}
        subtitle={'actions text-only'}
        desc={'Context menu button but we set the `isMenuPrimaryAction` prop to true. Press button to show menu.'}
        // `ContextMenuButton` Props
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        isMenuPrimaryAction={true}
        menuConfig={{
          menuTitle: 'ContextMenuButtonSimpleExample02',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'folder',
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'dial.fill',
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'archivebox.fill',
            }
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});