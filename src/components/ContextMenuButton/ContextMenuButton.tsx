import React from 'react';
import { View } from 'react-native';

import type { ContextMenuButtonProps } from './ContextMenuButtonTypes';


export const ContextMenuButton: React.FC<ContextMenuButtonProps> = (props) => {
  return(
    <View {...props}>
      {props.children}
    </View>
  );
};