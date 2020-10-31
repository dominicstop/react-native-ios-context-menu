import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewTest04 extends React.PureComponent {
  constructor(props){
    super(props);

    this.state = {
      actionToggle1: false,
      actionToggle2: false,
      actionToggle3: false,
    };
  };

  _handleOnPressMenuItem = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'key-01':
        this.setState((prevState) => ({
          actionToggle1: !prevState.actionToggle1
        }));
        break;

      case 'key-02':
        this.setState((prevState) => ({
          actionToggle2: !prevState.actionToggle2
        }));
        break;

      case 'key-03':
        this.setState((prevState) => ({
          actionToggle3: !prevState.actionToggle3
        }));
        break;

      case 'key-04':
        this.setState({
          actionToggle1: false,
          actionToggle2: false,
          actionToggle3: false,
        });
        break;
    };
  };

  render(){
    const state = this.state;

    const resetEnabled = (
      state.actionToggle1 ||
      state.actionToggle2 ||
      state.actionToggle3 
    );

    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #4'}
        subtitle={'toggle icons'}
        desc={`Test for toggling the menu icons from state`}
        onPressMenuItem={this._handleOnPressMenuItem}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest04',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: `Action 1: ${state.actionToggle1? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : (state.actionToggle1? 'heart.fill' : 'heart'),
          }, {
            actionKey  : 'key-02',
            actionTitle: `Action 2: ${state.actionToggle2? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : (state.actionToggle2? 'suit.club.fill' : 'suit.club'),
          }, {
            actionKey  : 'key-03',
            actionTitle: `Action 3: ${state.actionToggle3? 'on' : 'off'}`,
            imageType  : 'SYSTEM',
            imageValue : (state.actionToggle3? 'suit.spade.fill' : 'suit.spade'),
          }, {
            menuTitle  : 'Inline Menu',
            menuOptions: ['displayInline'],
            menuItems  : [{
              actionKey     : 'key-04',
              actionTitle   : `Reset All`,
              imageType     : 'SYSTEM',
              imageValue    : 'trash',
              menuAttributes: [resetEnabled? 'destructive' : 'hidden'],
              menuState     : 'off',
            }],
          }]
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});