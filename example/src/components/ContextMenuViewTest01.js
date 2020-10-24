import React from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';
import Proptypes from 'prop-types';

import { ContextMenuView, MenuItemKeys, ImageTypes, MenuElementState, MenuElementAtrributes, MenuOptions } from 'react-native-ios-context-menu';



const menuItemsDummy1 = [{
    [MenuItemKeys.key           ]: 'key-01',
    [MenuItemKeys.title         ]: 'Disabled Action #1',
    [MenuItemKeys.imageType     ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue    ]: 'folder.fill',
    [MenuItemKeys.menuState     ]: MenuElementState.off,
    [MenuItemKeys.menuAttributes]: [MenuElementAtrributes.disabled],
  },{
    [MenuItemKeys.key       ]: 'key-02',
    [MenuItemKeys.title     ]: 'Normal Action #2',
    [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue]: 'archivebox.fill',
  },{
    [MenuItemKeys.key       ]: 'key-03',
    [MenuItemKeys.title     ]: 'MenuState: On',
    [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue]: 'folder.fill',
    [MenuItemKeys.menuState ]: MenuElementState.on,
  },{
    [MenuItemKeys.key         ]: 'key-05',
    [MenuItemKeys.title       ]: 'Action w/ Submmenu...',
    [MenuItemKeys.imageType   ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue  ]: 'dial',
    [MenuItemKeys.submenuItems]: [{
      [MenuItemKeys.key       ]: 'key-07',
      [MenuItemKeys.title     ]: 'Submenu Action #1',
      [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
      [MenuItemKeys.imageValue]: 'star',
    },{
      [MenuItemKeys.key       ]: 'key-08',
      [MenuItemKeys.title     ]: 'Submenu Action #2',
      [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
      [MenuItemKeys.imageValue]: 'star.lefthalf.fill',
    },{
      [MenuItemKeys.key         ]: 'key-09',
      [MenuItemKeys.title       ]: 'Submenu Action #3...',
      [MenuItemKeys.imageType   ]: ImageTypes.SYSTEM,
      [MenuItemKeys.imageValue  ]: 'star.fill',
      [MenuItemKeys.submenuItems]: [{
        [MenuItemKeys.key       ]: 'key-10',
        [MenuItemKeys.title     ]: 'Submenu Action #4',
        [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
        [MenuItemKeys.imageValue]: 'moon.stars.fill',
      },{
        [MenuItemKeys.key       ]: 'key-11',
        [MenuItemKeys.title     ]: 'Submenu Action #5',
        [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
        [MenuItemKeys.imageValue]: 'ant.fill',
      },{
        [MenuItemKeys.key       ]: 'key-12',
        [MenuItemKeys.title     ]: 'Submenu Action #6...',
        [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
        [MenuItemKeys.imageValue]: 'hare.fill',
        [MenuItemKeys.submenuItems]: [{
          [MenuItemKeys.key       ]: 'key-13',
          [MenuItemKeys.title     ]: 'Submenu Action #7',
          [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
          [MenuItemKeys.imageValue]: 'moon.stars',
        },{
          [MenuItemKeys.key       ]: 'key-14',
          [MenuItemKeys.title     ]: 'Submenu Action #8...',
          [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
          [MenuItemKeys.imageValue]: 'ant',
          [MenuItemKeys.submenuItems]: [{
            [MenuItemKeys.key       ]: 'key-15',
            [MenuItemKeys.title     ]: 'Submenu Action #9',
            [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
            [MenuItemKeys.imageValue]: 'hare',
          }]
        }]
      }]
    }]
  },{
    [MenuItemKeys.key           ]: 'key-06',
    [MenuItemKeys.title         ]: 'Destructive Action',
    [MenuItemKeys.imageType     ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue    ]: 'trash.fill',
    [MenuItemKeys.menuState     ]: MenuElementState.off,
    [MenuItemKeys.menuAttributes]: [MenuElementAtrributes.destructive],
  }
];

const menuItemsDummy2 = [{
    [MenuItemKeys.key           ]: 'ActionEdit',
    [MenuItemKeys.title         ]: 'Edit...',
    [MenuItemKeys.imageType     ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue    ]: 'pencil',
    [MenuItemKeys.menuState     ]: MenuElementState.off,
    [MenuItemKeys.menuAttributes]: [],
  },{
    [MenuItemKeys.key           ]: 'ActionDelete',
    [MenuItemKeys.title         ]: 'Delete',
    [MenuItemKeys.imageType     ]: ImageTypes.SYSTEM,
    [MenuItemKeys.imageValue    ]: 'trash.fill',
    [MenuItemKeys.menuState     ]: MenuElementState.off,
    [MenuItemKeys.menuAttributes]: [MenuElementAtrributes.destructive],
  }
];

const menuItemsDummy3 = [{
  [MenuItemKeys.key       ]: 'key-01',
  [MenuItemKeys.title     ]: 'Action #1',
  [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
  [MenuItemKeys.imageValue]: 'folder.fill',
  [MenuItemKeys.menuAttributes]: MenuElementAtrributes.displayInline,
  [MenuItemKeys.submenuItems]: [{
    [MenuItemKeys.key  ]: 'key-03',
    [MenuItemKeys.title]: 'Submenu Action #1',
  }, {
    [MenuItemKeys.key  ]: 'key-04',
    [MenuItemKeys.title]: 'Submenu Action #2',
  }]
}, {
  [MenuItemKeys.key       ]: 'key-05',
  [MenuItemKeys.title     ]: 'Action #2',
  [MenuItemKeys.imageType ]: ImageTypes.SYSTEM,
  [MenuItemKeys.imageValue]: 'folder.fill',
  [MenuItemKeys.menuAttributes]: MenuElementAtrributes.displayInline,
}];



const MenuConfig01 = {
  menuTitle: 'Menu Test 1',
  // can be another menu or an action
  menuItems: [{
    actionKey: 'key-00',
    actionTitle: 'Action #1'
  }],
};

export class ContextMenuViewTest01 extends React.PureComponent {
  render(){
    return(
      <View style={styles.rootContainer}>
        <ContextMenuView 
          style={styles.contextMenuView}
          menuConfig={MenuConfig01}
          onPressMenuItem={({key}) => alert(key)}
        >
          <Image
            style={styles.imageBG}
            resizeMode={'cover'}
            source={require('../assets/macos11_wallpaper.jpg')}
          />
          <Text style={styles.text}>
            {'React Native View'}
          </Text>
        </ContextMenuView>
      </View>
    );
  };
};

/**
 *  
let old = (
  <React.Fragment>
    <ContextMenuView 
      style={styles.contextMenuView}
      menuItems={menuItemsDummy2}
      menuTitle={'Hello World'}
    >
      <Text style={styles.text}>
        {'Hello World'}
      </Text>
      <Text style={styles.text}>
        {'Hello World'}
      </Text>
      <Text style={styles.text}>
        {'Hello World'}
      </Text>
    </ContextMenuView>
    <ContextMenuView 
      style={styles.contextMenuViewImage}
      menuItems={menuItemsDummy2}
      menuTitle={'Image Preview'}
    >
      <Image
        style={styles.image}
        resizeMode={'cover'}
        source={require('../assets/macos11_wallpaper.jpg')}
      />
    </ContextMenuView>
  </React.Fragment>
);
*/

const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  contextMenuView: {
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 10,
    backgroundColor: 'black',
    margin: 15,
    overflow: 'hidden'
  },
  contextMenuViewImage: {
    margin: 15,
  },
  image: {
    width: 200,
    height: 100,
    borderRadius: 10,
  },
  imageBG: {
    ...StyleSheet.absoluteFillObject,
    width: 300,
    height: 200,
  },
  text: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white'
  },
});