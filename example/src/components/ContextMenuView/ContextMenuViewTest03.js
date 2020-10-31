import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';



export class ContextMenuViewTest03 extends React.PureComponent {
  constructor(props){
    super(props);

    this.state = {
      actionState1: false,
      actionState2: false,
      actionState3: false,
    };
  };

  _handleOnPressMenuItem = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'key-01':
        this.setState((prevState) => ({
          actionState1: !prevState.actionState1
        }));
        break;

      case 'key-02':
        this.setState((prevState) => ({
          actionState2: !prevState.actionState2
        }));
        break;

      case 'key-03':
        this.setState((prevState) => ({
          actionState3: !prevState.actionState3
        }));
        break;

      case 'key-04':
        this.setState({
          actionState1: false,
          actionState2: false,
          actionState3: false,
        });
        break;
    };
  };

  render(){
    const state = this.state;

    const resetEnabled = (
      state.actionState1 ||
      state.actionState2 ||
      state.actionState3 
    );

    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #3'}
        subtitle={'toggle menuState'}
        desc={`Test for toggling the menuState on/off`}
        // `ContextMenuView` Props
        onPressMenuItem={this._handleOnPressMenuItem}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest03',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: `Action 1: ${state.actionState1? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : 'heart',
            menuState  : (state.actionState1? 'on' : 'off'),
          }, {
            actionKey  : 'key-02',
            actionTitle: `Action 2: ${state.actionState2? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : 'suit.club',
            menuState  : (state.actionState2? 'on' : 'off'),
          }, {
            actionKey  : 'key-03',
            actionTitle: `Action 3: ${state.actionState3? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : 'suit.spade',
            menuState  : (state.actionState3? 'on' : 'off'),
          }, {
            actionKey     : 'key-04',
            actionTitle   : `Reset All`,
            imageType     : 'SYSTEM',
            imageValue    : 'trash',
            menuAttributes: [resetEnabled? 'destructive' : 'hidden'],
            menuState     : 'off',
          }]
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});