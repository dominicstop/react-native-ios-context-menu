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
        onPressMenuItem={this._handleOnPressMenuItem}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample09',
          menuItems: [{
            actionKey  : 'save',
            actionTitle: 'Save',
            imageType  : 'SYSTEM',
            imageValue : 'square.and.arrow.down',
          }, {
            actionKey  : 'like'         ,
            actionTitle: 'Like'         ,
            imageType  : 'SYSTEM'       ,
            imageValue : 'hand.thumbsup',
          }, {
            actionKey  : 'play'  ,
            actionTitle: 'Play'  ,
            imageType  : 'SYSTEM',
            imageValue : 'play'  ,
          }],
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});