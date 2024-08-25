
// import * as React from 'react';
import { StyleSheet } from 'react-native';
import { Colors } from 'react-native-ios-utilities';

import { ContextMenuCard, type ContextMenuCardProps, type ColorConfig } from './ContextMenuCard';


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