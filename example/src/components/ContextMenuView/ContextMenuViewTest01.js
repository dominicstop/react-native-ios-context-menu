import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';



export class ContextMenuViewTest01 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #1'}
        subtitle={'nested menus'}
        desc={`Test for multiple nested/deep submenu's`}
        // `ContextMenuView` Props
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest01',
          menuItems: [{
            actionKey  : 'key-01'   ,
            actionTitle: 'Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'hare',
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'calendar',
            }
          }, {
            menuTitle: 'Submenu #1...',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'ant',
            },
            menuItems: [{
              actionKey  : 'key-03-01'   ,
              actionTitle: 'Submenu Action #3',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'moon',
              },
            }, {
              actionKey  : 'key-03-02'   ,
              actionTitle: 'Submenu Action #4',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'house',
              }
            }, {
              menuTitle: 'Submenu #5...',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'moon.stars',
              },
              menuItems: [{
                actionKey  : 'key-03-03-01',
                actionTitle: 'Submenu Action #5',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'dial',
                }
              }, {
                actionKey  : 'key-03-03-02',
                actionTitle: 'Submenu Action #6',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'square.and.arrow.up.on.square',
                }
              }, {
                menuTitle: 'Submenu #3...',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'archivebox',
                },
                menuItems: [{
                  actionKey  : 'key-03-03-03-01',
                  actionTitle: 'Submenu Action #7',
                  icon: {
                    iconType : 'SYSTEM',
                    iconValue: 'folder',
                  },
                }, {
                  actionKey  : 'key-03-03-03-02',
                  actionTitle: 'Submenu Action #8',
                  icon: {
                    iconType : 'SYSTEM',
                    iconValue: 'pencil.slash',
                  }
                }, {
                  menuTitle: 'Submenu #4...',
                  icon: {
                    iconType : 'SYSTEM',
                    iconValue: 'rosette',
                  },
                  menuItems: [{
                    actionKey  : 'key-03-03-03-03-01',
                    actionTitle: 'Submenu Action #9',
                    icon: {
                      iconType : 'SYSTEM',
                      iconValue: 'lessthan.circle',
                    }
                  }, {
                    actionKey  : 'key-03-03-03-03-02',
                    actionTitle: 'Submenu Action #10',
                    icon: {
                      iconType : 'SYSTEM',
                      iconValue: 'divide.square',
                    }
                  }, {
                    actionKey  : 'key-03-03-03-03-03',
                    actionTitle: 'Submenu Action #11',
                    icon: {
                      iconType : 'SYSTEM',
                      iconValue: 'cloud.moon',
                    }
                  }],
                }],
              }],
            }],
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});