import * as React from 'react';

import { View } from 'react-native';


export function Spacer(props: {
  space?: number;
}) {
  return(
    <View style={{marginTop: props.space ?? 15}}/>
  );
};

export function SpacerLine(props: {
  space?: number;
  lineThickness?: number;
}){
  
  const spacerLineStyle = {
    paddingTop: props.space ?? 12,
    borderBottomWidth: props.lineThickness ?? 1,
    borderBottomColor: 'rgba(0,0,0,0.15)',
  };

  return(
    <View style={spacerLineStyle}/>
  );
};