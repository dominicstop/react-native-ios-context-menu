import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import { ContextMenuCard } from '../components/ContextMenuCard';

import type { ContextMenuExampleProps } from './SharedExampleTypes';


export function ContextMenuViewExample09(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample09',
        menuItems: [{
          actionKey  : 'save',
          actionTitle: 'Save',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'square.and.arrow.down',
          }
        }, {
          actionKey  : 'like',
          actionTitle: 'Like',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'hand.thumbsup',
          }
        }, {
          actionKey  : 'play',
          actionTitle: 'Play',
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'play',
          }
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'save':
            Alert.alert('saving...');
            break;

          case 'like':
            Alert.alert('liking...');
            break;

          case 'play':
            Alert.alert('playing...');
            break;
        };
      }}
    >
      <ContextMenuCard
        index={props.index}
        subtitle={'menu actions'}
        title={'ContextMenuViewExample09'}
        description={[
          `An example context menu for using the 'onPressMenuItem' event.`
        ]}
      />
    </ContextMenuView>
  );
};