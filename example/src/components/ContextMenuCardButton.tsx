import React from 'react';
import { StyleSheet, View, Text, type ViewStyle } from 'react-native';
import { Colors } from 'react-native-ios-utilities';

import { ContextMenuButtonContext } from 'react-native-ios-context-menu';


export function ContextMenuCardButton(props: {
  style?: ViewStyle;
  buttonTitle: string;
}){
  const menuContext = React.useContext(ContextMenuButtonContext);

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
    paddingHorizontal: 12,
    paddingVertical: 10,
    borderRadius: 10,
  },
  labelText: {
    color: 'white',
    fontSize: 14,
    fontWeight: '600'
  },
});