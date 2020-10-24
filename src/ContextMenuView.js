import React from 'react';
import { StyleSheet, requireNativeComponent, UIManager } from 'react-native';
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
    menuConfig: Proptypes.object,
    onPressMenuItem: Proptypes.func,
  };

  _handleOnPressMenuItem = ({nativeEvent}) => {
    this.props.onPressMenuItem?.({key: nativeEvent.key});
  };

  render(){
    const { style, ...props } = this.props;
    const nativeProps = {
      ...props,
      style: [styles.menuView, style],
      [NATIVE_PROP_KEYS.onPressMenuItem]: this._handleOnPressMenuItem,
    };

    return(
      <NativeComponent
        {...nativeProps}
      />
    );
  };
};

const styles = StyleSheet.create({
  menuView: {
    backgroundColor: 'transparent',
  },
});