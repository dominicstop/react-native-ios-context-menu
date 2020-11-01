import React from 'react';
import { View } from 'react-native';


export function ContextMenuButton(props){
  return(
    <View {...props}>
      {props.children}
    </View>
  );
};