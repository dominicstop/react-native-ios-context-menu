import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewSimpleExample09 extends React.PureComponent {

  _handleOnPressMenuItem = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'save':
        alert('saving...');
        break;

      case 'like':
        alert('liking...');
        break;

      case 'play':
        alert('playing...');
        break;
    };
  };

  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #9'}
        subtitle={'menu actions'}
        desc={'An example context menu for using the `onPressMenuItem` event.'}
        // `ContextMenuView` Props
        onPressMenuItem={this._handleOnPressMenuItem}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample09',
          menuItems: [{
            actionKey  : 'save',
            actionTitle: 'Save',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'square.and.arrow.down',
            }
          }, {
            actionKey  : 'like',
            actionTitle: 'Like',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'hand.thumbsup',
            }
          }, {
            actionKey  : 'play',
            actionTitle: 'Play',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'play',
            }
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});