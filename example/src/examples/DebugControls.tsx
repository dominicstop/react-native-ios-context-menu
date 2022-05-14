/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, TouchableOpacity } from 'react-native';


import { useNavigation } from '@react-navigation/native';

import type { ContextMenuExampleProps } from './SharedExampleTypes';

import { ContextMenuCard } from '../components/ContextMenuCard';
import { CardButton } from '../components/Card/CardButton';


export function DebugControls(props: ContextMenuExampleProps) {
  const navigation = useNavigation();

  return (
    <ContextMenuCard
      style={props.style}
      index={props.index}
      title={'Debug Controls'}
      subtitle={'For testing and stuff'}
    >
      <CardButton
        title={'Push: Home'}
        subtitle={'Navigate to "Home" screen...'}
        onPress={() => {
          navigation.push('Home');
        }}
      />
      <CardButton
        title={'Push: Test'}
        subtitle={'Navigate to "Test" screen...'}
        onPress={() => {
          navigation.push('Test');
        }}
      />
    </ContextMenuCard>
  );
};