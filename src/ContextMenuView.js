import React from 'react';
import { requireNativeComponent, UIManager } from 'react-native';
import Proptypes from 'prop-types';


const componentName   = "RCTContextMenu";
const NativeCommands  = UIManager[componentName]?.Commands;
const NativeComponent = requireNativeComponent(componentName);

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
