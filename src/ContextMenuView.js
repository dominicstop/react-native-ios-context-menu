import React from 'react';
import { requireNativeComponent, UIManager } from 'react-native';
import Proptypes from 'prop-types';


const componentName   = "RCTContextMenu";
const NativeCommands  = UIManager[componentName]?.Commands;
const NativeComponent = requireNativeComponent(componentName);

const NATIVE_PROP_KEYS = {
  menuConfig     : 'menuConfig'     ,
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
      [NATIVE_PROP_KEYS.onPressMenuItem]: this._handleOnPressMenuItem,
    };

    return(
      <NativeComponent
        {...nativeProps}
      />
    );
  };
};
