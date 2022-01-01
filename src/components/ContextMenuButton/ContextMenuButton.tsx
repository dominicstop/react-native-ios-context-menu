import React from 'react';
import { View } from 'react-native';

import type { ContextMenuButtonProps } from './ContextMenuButtonTypes';


export class ContextMenuButton extends React.Component<ContextMenuButtonProps> {
  render(){
    return(
      <View {...this.props}>
        {this.props.children}
      </View>
    );
  };
};