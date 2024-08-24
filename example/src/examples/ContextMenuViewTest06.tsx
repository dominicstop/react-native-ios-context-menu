import * as React from 'react';

import { ContextMenuView, OnPressMenuItemEvent } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';
import { Alert } from 'react-native';


export function ContextMenuViewTest06(props: ContextMenuExampleProps) {
  const [itemCount, setItemCount] = React.useState(0);

  const hasItems = (itemCount > 0);

  const items = [...Array(itemCount).keys()];

  const hanldeOnPressMenuItem: OnPressMenuItemEvent = ({nativeEvent}) => {
    switch (nativeEvent.actionKey) {
      case 'add-action':
        setItemCount((prevValue) => (prevValue + 1));
        break;

      case 'delete-all':
        setItemCount(0);
        break;

      default:
        Alert.alert('onPressMenuItem', `actionKey: ${nativeEvent.actionKey}`);
        break;
    };
  };

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest06',
        menuItems: [{
          actionKey  : 'add-action',
          actionTitle: 'Add Action',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'plus',
            },
          }
        }, {
          actionKey     : 'delete-all',
          actionTitle   : 'Delete All',
          menuAttributes: [hasItems? 'destructive' : 'disabled'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }, {
          menuTitle  : 'submenu',
          menuOptions: ['displayInline'],
          menuItems  : items.map(item => ({
            actionKey  : `item-key-${item}`,
            actionTitle: `Action #${item}`,
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: (item % 2 === 0)? 'heart.fill' : 'heart',
              },
            }
          })),
        }],
      }}
      onPressMenuItem={hanldeOnPressMenuItem}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest06'}
        subtitle={'add menu action'}
        description={[
          `Test for programmatically adding a menu action`
        ]}
      />
    </ContextMenuView>
  );
};