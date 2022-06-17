import * as React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert } from 'react-native';

import { SHARED_ENV } from '../constants/SharedEnv';


export const TestScreen = (props) => {
  return (
    <View style={styles.rootContainer}>
      <TouchableOpacity
        onPress={() => {
          if(SHARED_ENV.enableReactNavigation){
            props.navigation.push('Home');

          } else {
            Alert.alert('react-navigation is disabled.');
          };
        }}
      >
        <Text>
          {'Test Screen'}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center' 
  },
});