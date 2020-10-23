import React from 'react';
import { requireNativeComponent, UIManager } from 'react-native';
import Proptypes from 'prop-types';

import _ from 'lodash';

const componentName   = "RCTContextMenu";
const NativeCommands  = UIManager[componentName]?.Commands;
const NativeComponent = requireNativeComponent(componentName);


export const ImageTypes = {
  'NONE'  : 'NONE'  ,
  'URL '  : 'URL'   ,
  'SYSTEM': 'SYSTEM',
};

export const MenuOptions = {
  destructive  : 'destructive'  ,
  displayInline: 'displayInline',
};

export const MenuElementAtrributes = {
  hidden     : 'hidden'     ,
  disabled   : 'disabled'   ,
  destructive: 'destructive',
};

export const MenuElementState = {
  on   : 'on'   ,
  off  : 'off'  ,
  mixed: 'mixed',
};

export const MenuItemKeys = {
  key           : 'key'           , // required - unique identifier
  title         : 'title'         , // required - string value
  imageType     : 'imageType'     , // optional - ImageTypes item
  imageValue    : 'imageValue'    , // optional - string value
  menuState     : 'menuState'     , // optional - MenuElementState item
  menuAttributes: 'menuAttributes', // optional - MenuElementAtrributes item
  submenuItems  : 'submenuItems'  , // optional - array of MenuItemKeys
};

const PROP_KEYS = {
  // values -------------
  menuTitle: 'menuTitle',
  // arrays -----------------
  menuItems  : 'menuItems'  , // required: array of MenuItemKeys
  menuOptions: 'menuOptions', // optional: array of MenuOptions
  // events -----------------------
  onPressMenuItem: 'onPressMenuItem',
};


export class ContextMenuView extends React.PureComponent {
  static proptypes = {
    menuTitle: Proptypes.string,
    menuItems: Proptypes.array.isRequired,
    menuOptions: Proptypes.array,
    onPressMenuItem: Proptypes.func,
  };

  _handleOnPressMenuItem = ({nativeEvent}) => {
    this.props.onPressMenuItem?.({key: nativeEvent.key});
  };

  render(){
    const nativeProps = {
      ...this.props,
      [PROP_KEYS.onPressMenuItem]: this._handleOnPressMenuItem,
    };

    return(
      <NativeComponent
        {...nativeProps}
      />
    );
  };
};
