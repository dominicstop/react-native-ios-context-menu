import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';



export class ContextMenuViewTest01 extends React.PureComponent {
  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #1'}
        subtitle={'nested menus'}
        desc={`Test for multiple nested/deep submenu's`}
        onPressMenuItem={({nativeEvent}) => alert(`onPressMenuItem nativeEvent: ${JSON.stringify(nativeEvent)}`)}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest01',
          menuItems: [{
            actionKey  : 'key-01'   ,
            actionTitle: 'Action #1',
            imageType  : 'SYSTEM',
            imageValue : 'hare',
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            imageType  : 'SYSTEM',
            imageValue : 'calendar',
          }, {
            menuTitle: 'Submenu #1...',
            imageType: 'SYSTEM',
            imageValue: 'ant',
            menuItems: [{
              actionKey  : 'key-03-01'   ,
              actionTitle: 'Submenu Action #3',
              imageType  : 'SYSTEM',
              imageValue : 'moon',
            }, {
              actionKey  : 'key-03-02'   ,
              actionTitle: 'Submenu Action #4',
              imageType  : 'SYSTEM',
              imageValue : 'house',
            }, {
              menuTitle: 'Submenu #5...',
              imageType: 'SYSTEM',
              imageValue: 'moon.stars',
              menuItems: [{
                actionKey  : 'key-03-03-01',
                actionTitle: 'Submenu Action #5',
                imageType  : 'SYSTEM',
                imageValue : 'dial',
              }, {
                actionKey  : 'key-03-03-02',
                actionTitle: 'Submenu Action #6',
                imageType  : 'SYSTEM',
                imageValue : 'square.and.arrow.up.on.square',
              }, {
                menuTitle: 'Submenu #3...',
                imageType: 'SYSTEM',
                imageValue: 'archivebox',
                menuItems: [{
                  actionKey  : 'key-03-03-03-01',
                  actionTitle: 'Submenu Action #7',
                  imageType  : 'SYSTEM',
                  imageValue : 'folder',
                }, {
                  actionKey  : 'key-03-03-03-02',
                  actionTitle: 'Submenu Action #8',
                  imageType  : 'SYSTEM',
                  imageValue : 'pencil.slash',
                }, {
                  menuTitle: 'Submenu #4...',
                  imageType: 'SYSTEM',
                  imageValue: 'rosette',
                  menuItems: [{
                    actionKey  : 'key-03-03-03-03-01',
                    actionTitle: 'Submenu Action #9',
                    imageType  : 'SYSTEM',
                    imageValue : 'lessthan.circle',
                  }, {
                    actionKey  : 'key-03-03-03-03-02',
                    actionTitle: 'Submenu Action #10',
                    imageType  : 'SYSTEM',
                    imageValue : 'divide.square',
                  }, {
                    actionKey  : 'key-03-03-03-03-03',
                    actionTitle: 'Submenu Action #11',
                    imageType  : 'SYSTEM',
                    imageValue : 'cloud.moon',
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