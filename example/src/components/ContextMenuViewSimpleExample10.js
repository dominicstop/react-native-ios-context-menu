import React from 'react';
import { StyleSheet } from 'react-native';

import { ExampleContextMenuItem } from './ExampleContextMenuItem';


export class ContextMenuViewSimpleExample10 extends React.PureComponent {

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
        title={'Simple Example #10'}
        subtitle={'inline menu'}
        desc={'On iOS 14...'}
        onPressMenuItem={this._handleOnPressMenuItem}
        onPressMenuPreview={() => alert('onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample10',
          menuOptions: ['displayInline'],
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