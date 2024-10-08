// import * as React from 'react';

import { Colors } from 'react-native-ios-utilities';
import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ExampleItemProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample22(props: ExampleItemProps) {

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: '',
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
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample22'}
        subtitle={'menuPreferredElementSize'}
        description={[
          `menuPreferredElementSize: 'small' - Requires iOS 16+.`
        ]}
      />
    </ContextMenuView>
  );
};