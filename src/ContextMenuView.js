import React from 'react';
import { StyleSheet, requireNativeComponent, UIManager } from 'react-native';
import Proptypes from 'prop-types';


const componentName   = "RCTContextMenu";
const NativeCommands  = UIManager[componentName]?.Commands;
const NativeComponent = requireNativeComponent(componentName);

const NATIVE_PROP_KEYS = {
  // props: values --------
  menuConfig: 'menuConfig',
  // props: events ------------------------
  onMenuShow        : 'onMenuShow'        ,
  onMenuHide        : 'onMenuHide'        ,
  onMenuCancel      : 'onMenuCancel'      ,
  onPressMenuItem   : 'onPressMenuItem'   ,
  onPressMenuPreview: 'onPressMenuPreview',
};


export class ContextMenuView extends React.PureComponent {
  static proptypes = {
    menuConfig: Proptypes.object,
    // events -------------------------
    onMenuShow        : Proptypes.func,
    onMenuHide        : Proptypes.func,
    onMenuCancel      : Proptypes.func,
    onPressMenuItem   : Proptypes.func,
    onPressMenuPreview: Proptypes.func,
  };

  constructor(props){
    super(props);

    this.state = {
      menuVisible: false,
    };
  };

  //#region - Event Handlers
  _handleOnMenuShow = (event) => {
    const { onMenuShow } = this.props;
    onMenuShow?.(event);

    this.setState({menuVisible: true});

  };

  _handleOnMenuHide = (event) => {
    const { onMenuHide } = this.props;
    onMenuHide?.(event);

    this.setState({menuVisible: false});
  };

  _handleOnMenuCancel = (event) => {
    const { onMenuCancel } = this.props;
    onMenuCancel?.(event);
  };

  _handleOnPressMenuItem = (event) => {
    this.props.onPressMenuItem?.(event);
  };

  _handleOnPressMenuPreview = (event) => {
    const { onPressMenuPreview } = this.props;
    onPressMenuPreview?.(event);
  };
  //#endregion

  render(){
    const { style, children, ...props } = this.props;
    const { menuVisible } = this.state;

    const nativeProps = {
      ...props,
      // Native Props ------------------------------------------------------
      [NATIVE_PROP_KEYS.onMenuShow        ]: this._handleOnMenuShow        ,
      [NATIVE_PROP_KEYS.onMenuHide        ]: this._handleOnMenuHide        ,
      [NATIVE_PROP_KEYS.onMenuCancel      ]: this._handleOnMenuCancel      ,
      [NATIVE_PROP_KEYS.onPressMenuItem   ]: this._handleOnPressMenuItem   ,
      [NATIVE_PROP_KEYS.onPressMenuPreview]: this._handleOnPressMenuPreview,
    };

    return(
      <NativeComponent
        style={[styles.menuView, style]}
        {...nativeProps}
      >
        {React.Children.map(children, child => 
          React.cloneElement(child, {menuVisible})
        )}
      </NativeComponent>
    );
  };
};

const styles = StyleSheet.create({
  menuView: {
    backgroundColor: 'transparent',
  },
});