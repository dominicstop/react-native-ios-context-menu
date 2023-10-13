import * as React from 'react';
import { StyleSheet, View, ViewStyle } from 'react-native';

import * as Colors from '../../constants/Colors';


export const CardBody: React.FC<React.PropsWithChildren<{
  style?: ViewStyle;
}>> = (props) => {
  return (
    <View style={[styles.cardBodyContainer, props.style]}>
      {props.children}
    </View>
  );
};

const styles = StyleSheet.create({
  cardBodyContainer: {
    paddingHorizontal: 12,
    paddingVertical: 15,
    marginHorizontal: 10,
    marginVertical: 10,
    backgroundColor: Colors.PURPLE[50],
    borderRadius: 10,
  },
});