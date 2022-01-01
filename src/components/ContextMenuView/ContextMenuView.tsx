import React from 'react';
import { View } from 'react-native';

import type { ContextMenuViewProps } from './ContextMenuViewTypes';


export const ContextMenuView: React.FC<ContextMenuViewProps> = (props) => {
  return(
    <View {...props}>
      {props.children}
    </View>
  );
};