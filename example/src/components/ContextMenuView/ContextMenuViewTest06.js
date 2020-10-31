import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewTest06 extends React.PureComponent {
  constructor(props){
    super(props);

    this.state = {
      itemCount: 0,
    };
  };

  _hanldeOnPressMenuItem = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'add-action':
        this.setState((prevState) => ({
          itemCount: ((prevState.itemCount ?? 0) + 1)
        }));
        break;

      case 'delete-all':
        this.setState({
          itemCount: 0,
        });
        break;

      default:
        alert(`onPressMenuItem: ${nativeEvent.actionKey}`);
        break;
    };
  };

  render(){
    const { itemCount } = this.state;
    const menuItems = [...Array(itemCount).keys()];

    const hasItems = (itemCount > 0);

    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #6'}
        subtitle={'add menu action'}
        desc={`Test for programmatically adding a menu action`}
        // `ContextMenuView` Props
        onPressMenuItem={this._hanldeOnPressMenuItem}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest06',
          menuItems: [{
            actionKey  : 'add-action',
            actionTitle: 'Add Action',
            imageType  : 'SYSTEM',
            imageValue : 'plus',
          }, {
            actionKey     : 'delete-all',
            actionTitle   : 'Delete All',
            imageType     : 'SYSTEM',
            imageValue    : 'trash',
            menuAttributes: [hasItems? 'destructive' : 'disabled'],
          }, {
            menuTitle  : 'submenu',
            menuOptions: ['displayInline'],
            menuItems  : menuItems.map(item => ({
              actionKey  : `item-key-${item}`,
              actionTitle: `Action #${item}`,
              imageType  : 'SYSTEM',
              imageValue : (item % 2 == 0)? 'heart.fill' : 'heart',
            })),
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});