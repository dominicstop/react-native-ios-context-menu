import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuButton } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';

import * as Colors from '../constants/Colors';

import { ContextMenuButtonCard } from '../components/ContextMenuButtonCard';
import { ContextMenuCardButton } from '../components/ContextMenuCardButton';
import { CardButton } from '../components/Card';


export function ContextMenuButtonExample04(props: ContextMenuExampleProps) {
  const menuRef = React.useRef<ContextMenuButton>(null);

  return (
    <ContextMenuButtonCard
      style={props.style}
      index={props.index}
      title={'ContextMenuButtonExample04'}
      subtitle={'actions text-only'}
      description={[
        `Context menu button with 3 actions (no icon, just text).`,
        `Long press on the button to show the context menu.`
      ]}
    >
      <ContextMenuButton
        ref={menuRef}
        menuConfig={{
          menuTitle: 'ContextMenuButtonSimpleExample01',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
          }],
        }}
        onPressMenuItem={({nativeEvent}) => {
          Alert.alert(
            'onPressMenuItem Event',
            `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
          );
        }}
      >
        <ContextMenuCardButton
          buttonTitle={'⭐️ Context Menu Button'}
        />
      </ContextMenuButton>
      <CardButton
        title={'Show Context Menu'}
        subtitle={'Programmatically shows the context menu'}
        buttonColor={Colors.ORANGE.A700}
        onPress={() => {
          menuRef.current?.presentMenu();
        }}
      />
    </ContextMenuButtonCard>
  );
};