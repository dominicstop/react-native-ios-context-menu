
import * as React from 'react';

import { ContextMenuCard, ContextMenuCardProps, ColorConfig } from './ContextMenuCard';

import * as Colors from '../constants/Colors';
import { StyleSheet } from 'react-native';


const colorConfig: ColorConfig = {
  headerBGColorActive  : Colors.AMBER .A700,
  headerBGColorInactive: Colors.ORANGE.A700,

  bodyBGColorActive  : Colors.AMBER [50],
  bodyBGColorInactive: Colors.ORANGE[50],

  bodyDescriptionLabelColor: Colors.ORANGE[900],
};

export function ContextMenuButtonCard(props: ContextMenuCardProps){
  return (
    <ContextMenuCard
      {...props}
      extraContentContainerStyle={styles.extraContentContainer}
      colorConfig={colorConfig}
    />
  );
};

const styles = StyleSheet.create({
  extraContentContainer: {
    marginTop: 15,
  },
});