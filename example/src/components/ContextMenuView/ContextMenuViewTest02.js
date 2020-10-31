import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';



export class ContextMenuViewTest02 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #2'}
        subtitle={'inline menus'}
        desc={`Test for multiple inline menu's + nested submenu's`}
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest02',
          menuItems: [{
            menuTitle: 'Inline Submenu #1',
            menuOptions: ['displayInline'],
            menuItems: [{
              actionKey  : 'key-01'   ,
              actionTitle: 'Inline Action #1',
              imageType  : 'SYSTEM',
              imageValue : 'hare',
            }, {
              menuTitle  : 'Submenu #1...',
              imageType  : 'SYSTEM',
              imageValue : 'calendar',
              menuItems: [{
                actionKey  : 'key-02-01',
                actionTitle: 'Submenu Action #1',
                imageType  : 'SYSTEM',
                imageValue : 'paperclip',
              }, {
                menuTitle: 'Inline Submenu #4',
                menuOptions: ['displayInline'],
                menuItems: [{
                  actionKey  : 'key-02-02',
                  actionTitle: 'Inline Submenu Action #2',
                  imageType  : 'SYSTEM',
                  imageValue : 'house',
                }, {
                  actionKey  : 'key-02-03',
                  actionTitle: 'Inline Submenu Action #3',
                  imageType  : 'SYSTEM',
                  imageValue : 'tag',
                }],
              }, {
                actionKey  : 'key-02-04',
                actionTitle: 'Submenu Action #4',
                imageType  : 'SYSTEM',
                imageValue : 'sun.haze',
              }],
            }],
          }, {
            menuTitle: 'Inline Submenu #2',
            menuOptions: ['displayInline'],
            menuItems: [{
              actionKey     : 'key-03'   ,
              actionTitle   : 'Inline Submenu Action #2',
              menuAttributes: ['disabled'],
              imageType     : 'SYSTEM',
              imageValue    : 'suit.heart',
            }, {
              actionKey  : 'key-04'   ,
              actionTitle: 'Inline Submenu Action #3',
              imageType  : 'SYSTEM',
              imageValue : 'suit.club',
            }],
          }, {
            actionKey     : 'key-05'   ,
            actionTitle   : 'Action #4',
            menuAttributes: ['destructive'],
            imageType     : 'SYSTEM',
            imageValue    : 'trash',
          }]
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});