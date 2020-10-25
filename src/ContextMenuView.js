import React from 'react';
import { View } from 'react-native';


export function ContextMenuView(props){
  return(
    <View {...props}>
      {props.children}
    </View>
  );
};