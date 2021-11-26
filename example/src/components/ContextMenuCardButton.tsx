import React from 'react';
import { StyleSheet, View, Text, ViewStyle } from 'react-native';

import { useMenuContext } from 'react-native-ios-context-menu';

import * as Colors from '../constants/Colors';


export function ContextMenuCardButton(props: {
  style?: ViewStyle;
  buttonTitle: string;
}){
  const menuContext = useMenuContext();

  const rootContainerStyle = {
    backgroundColor: (menuContext.isMenuVisible
      ? Colors.AMBER .A700
      : Colors.ORANGE.A700
    )
  };

  return (
    <View style={[styles.rootContainer, rootContainerStyle, props.style]}>
      <Text style={styles.labelText}>
        {props.buttonTitle}
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainer: {
    padding: 10,
    borderRadius: 10,
  },
  labelText: {
    color: 'white',
    fontWeight: '500'
  },
});