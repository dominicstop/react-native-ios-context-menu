/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';

import { useNavigation } from '@react-navigation/native';

import type { ContextMenuExampleProps } from './SharedExampleTypes';

import { ContextMenuCard } from '../components/ContextMenuCard';
import { CardButton } from '../components/Card/CardButton';
import { SHARED_ENV } from '../constants/SharedEnv';


export function DebugControls(props: ContextMenuExampleProps) {
  // eslint-disable-next-line react-hooks/rules-of-hooks
  const navigation = SHARED_ENV.enableReactNavigation && useNavigation();

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
          // @ts-ignore
          navigation.push('Home');
        }}
      />
      <CardButton
        title={'Push: Test'}
        subtitle={'Navigate to "Test" screen...'}
        onPress={() => {
          // @ts-ignore
          navigation.push('Test');
        }}
      />
    </ContextMenuCard>
  );
};