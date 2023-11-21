import * as React from 'react';
import { StyleSheet, Text, TouchableOpacity, GestureResponderEvent } from 'react-native';

import * as Colors from '../../constants/Colors';


/**
 * ```
 * ┌─────────────────────────────┐
 * │ Title                       │
 * │ Subtitle                    │
 * └─────────────────────────────┘
 * ```
 */ 
export function CardButton(props: {
  title: string;
  subtitle: string;
  onPress?: (event: GestureResponderEvent) => void;
  buttonColor?: string;
}){

  const buttonColor = props.buttonColor ?? Colors.PURPLE.A200;

  return(
    <TouchableOpacity 
      style={[styles.cardButtonContainer, {
        backgroundColor: buttonColor,
      }]}
      onPress={props.onPress}
    >
      <React.Fragment>
        <Text style={styles.cardButtonTitleText}>
          {props.title}
        </Text>
        <Text style={styles.cardButtonSubtitleText}>
          {props.subtitle}
        </Text>
      </React.Fragment>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  cardButtonContainer: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 10,
    marginTop: 12,
  },
  cardButtonTitleText: {
    color: 'white',
    fontSize: 15,
    fontWeight: '700'
  },
  cardButtonSubtitleText: {
    color: 'white',
    fontWeight: '400'
  },
});