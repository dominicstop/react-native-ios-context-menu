import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Colors from '../constants/Colors';


export function ContextMenuViewExample23(props: ContextMenuExampleProps) {

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: '',
        menuItems: [{
          type: 'action',
          actionKey: 'remove-rating',
          menuAttributes: ['destructive'],
          actionTitle: 'Remove Rating',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          },
        }, {
          type: 'menu',
          menuTitle: '',
          menuOptions: ['displayInline'],
          menuPreferredElementSize: 'small',
          menuItems: [{
          actionKey: 'key-01',
          actionTitle: '',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star',
                weight: 'heavy',
                scale: 'large',
              },
              imageOptions: {
                renderingMode: 'alwaysOriginal',
                tint: Colors.AMBER.A700,
              }
            }
          }, {
            actionKey: 'key-02'   ,
            actionTitle: '',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.lefthalf.fill',
                weight: 'heavy',
                scale: 'large',
              },
              imageOptions: {
                renderingMode: 'alwaysOriginal',
                tint: Colors.AMBER.A700,
              }
            }
          }, {
            actionKey: 'key-03',
            actionTitle: '',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'star.fill',
                weight: 'heavy',
                scale: 'large',
              },
              imageOptions: {
                renderingMode: 'alwaysOriginal',
                tint: Colors.AMBER.A700,
              }
            }
          }],
        }]
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample23'}
        subtitle={'menuPreferredElementSize'}
        description={[
          `menuPreferredElementSize: 'small' - Requires iOS 16+.`
        ]}
      />
    </ContextMenuView>
  );
};