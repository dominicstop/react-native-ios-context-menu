import * as React from 'react';
import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';

import * as Colors  from '../../constants/Colors';


export function CardRowStepper(props: {
  title: string;
  subtitle?: string;
  value: number;
  stepperAmount: number;
  onValueChange: (value: number) => void;
}){
  return (
    <View style={styles.cardRowStepperContainer}>
      <View style={styles.cardRowStepperLabelContainer}>
        <Text style={styles.cardRowStepperLabelText}>
          {props.title ?? 'Title'}
        </Text>
        <Text style={styles.cardRowStepperSubtitleText}>
          {props.subtitle ?? `Current value: ${props.value ?? 0}`}
        </Text>
      </View>
      <View style={styles.cardRowStepperButtonsContainer}>
        <TouchableOpacity 
          style={[styles.cardRowStepperButton, styles.cardRowStepperButtonLeft]}
          onPress={() => {
            props.onValueChange(
              (props.value - props.stepperAmount)
            );
          }}
        >
          <Text style={styles.cardRowStepperButtonLabel}>
            {'–'}
          </Text>
        </TouchableOpacity>
        <TouchableOpacity 
          style={[styles.cardRowStepperButton, styles.cardRowStepperButtonRight]}
          onPress={() => {
            props.onValueChange(
              (props.value + props.stepperAmount)
            );
          }}
        >
          <Text style={styles.cardRowStepperButtonLabel}>
            {'+'}
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  cardRowStepperContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 12,
  },
  cardRowStepperLabelContainer: {
    flex: 1,
  },
  cardRowStepperLabelText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1200],
  },
  cardRowStepperSubtitleText: {
    flex: 1,
    fontSize: 16,
    opacity: 0.5,
    color: Colors.PURPLE[1100],
  },
  cardRowStepperButtonsContainer: {
    flexDirection: 'row',
    overflow: 'hidden',
    borderRadius: 10,
  },
  cardRowStepperButton: {
    padding: 10,
    backgroundColor: Colors.PURPLE.A200,
    width: 45,
    alignItems: 'center',
    justifyContent: 'center',
  },
  cardRowStepperButtonLeft: {
    marginRight: 0.5,
  },
  cardRowStepperButtonRight: {
    marginLeft: 0.5,
  },
  cardRowStepperButtonLabel: {
    fontWeight: '500',
    color: 'white',
    opacity: 0.9,
    fontSize: 18,
  },
});