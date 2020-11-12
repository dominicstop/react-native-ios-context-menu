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
        // `ContextMenuView` Props
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
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'hare',
              }
            }, {
              menuTitle  : 'Submenu #1...',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'calendar',
              },
              menuItems: [{
                actionKey  : 'key-02-01',
                actionTitle: 'Submenu Action #1',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'paperclip',
                }
              }, {
                menuTitle: 'Inline Submenu #4',
                menuOptions: ['displayInline'],
                menuItems: [{
                  actionKey  : 'key-02-02',
                  actionTitle: 'Inline Submenu Action #2',
                  icon: {
                    iconType : 'SYSTEM',
                    iconValue: 'house',
                  }
                }, {
                  actionKey  : 'key-02-03',
                  actionTitle: 'Inline Submenu Action #3',
                  icon: {
                    iconType : 'SYSTEM',
                    iconValue: 'tag',
                  }
                }],
              }, {
                actionKey  : 'key-02-04',
                actionTitle: 'Submenu Action #4',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'sun.haze',
                }
              }],
            }],
          }, {
            menuTitle: 'Inline Submenu #2',
            menuOptions: ['displayInline'],
            menuItems: [{
              actionKey     : 'key-03'   ,
              actionTitle   : 'Inline Submenu Action #2',
              menuAttributes: ['disabled'],
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'suit.heart',
              }
            }, {
              actionKey  : 'key-04'   ,
              actionTitle: 'Inline Submenu Action #3',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'suit.club',
              }
            }],
          }, {
            actionKey     : 'key-05'   ,
            actionTitle   : 'Action #4',
            menuAttributes: ['destructive'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'trash',
            }
          }]
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});