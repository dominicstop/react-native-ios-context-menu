import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import * as Colors  from '../../constants/Colors';


/**
 * ```
 * ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
 *   Label              Value │
 * └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
 * ```
 */                            
export function CardRowLabelDisplay(props: {
  label?: string;
  value?: string | number;
}){
  return (
    <View style={styles.cardRowLabelDisplayContainer}>
      <Text style={styles.cardRowLabelDisplayLabelText}>
        {props.label ?? 'Current Value'}
      </Text>
      <Text style={styles.cardRowLabelDisplayValueText}>
        {props.value ?? 'N/A'}
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  cardRowLabelDisplayContainer: {
    flexDirection: 'row',
    marginTop: 12,
    paddingHorizontal: 12,
    paddingVertical: 5,
    backgroundColor: Colors.INDIGO[100],
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  cardRowLabelDisplayLabelText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1100],
    opacity: 0.75,
  },
  cardRowLabelDisplayValueText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1100],
    opacity: 0.4,
  },
});