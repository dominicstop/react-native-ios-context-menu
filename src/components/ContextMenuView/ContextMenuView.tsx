import React from 'react';
import { View } from 'react-native';

import type { ContextMenuViewProps } from './ContextMenuViewTypes';


export class ContextMenuView extends React.Component<ContextMenuViewProps> {
  render(){
    return(
      <View {...this.props}>
        {this.props.children}
      </View>
    );
  };
};