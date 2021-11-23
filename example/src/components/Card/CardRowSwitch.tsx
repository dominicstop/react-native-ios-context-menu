import * as React from 'react';
import { StyleSheet, View, Text, Switch } from 'react-native';

import * as Colors  from '../../constants/Colors';


/**
 * ```
 * ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐
 *   Title               ┌──┬─┐   
 * │ Subtitle            └──┴─┘  │
 *  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
 * ```
 */                               
export function CardRowSwitch(props: {
  title: string;
  subtitle?: string;
  value: boolean;
  onValueChange: (value: boolean) => void;
}){
  return(
    <View style={styles.cardRowSwitchContainer}>
      <View style={styles.cardRowSwitchLabelContainer}>
        <Text style={styles.cardRowSwitchLabelText}>
          {props.title ?? 'title'}
        </Text>
        <Text style={styles.cardRowSwitchSubtitleText}>
          {props.subtitle ?? 'Toggle the value'}
        </Text>
      </View>
      <Switch
        value={props.value ?? false}
        onValueChange={props.onValueChange}
        trackColor={{
          true: Colors.PURPLE.A700,
          false: Colors.PURPLE.A100
        }}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  cardRowSwitchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 12,
  },
  cardRowSwitchLabelContainer: {
    flex: 1,
    marginRight: 10,
  },
  cardRowSwitchLabelText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1200],
  },
  cardRowSwitchSubtitleText: {
    fontSize: 16,
    opacity: 0.5,
    color: Colors.PURPLE[1100],
  },
});