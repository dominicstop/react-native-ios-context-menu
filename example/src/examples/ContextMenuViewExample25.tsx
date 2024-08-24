import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample25(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample25',
        menuItems: [{
          type: 'menu',
          menuTitle: '',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey: 'key-01-01',
            actionTitle: 'small',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                scale: 'small',
              },
            }
          }, {
            actionKey: 'key-01-02',
            actionTitle: 'medium',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                scale: 'medium',
              },
            }
          }, {
            actionKey: 'key-01-03',
            actionTitle: 'large',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                scale: 'large',
              },
            }
          }],
        }, {
          type: 'menu',
          menuTitle: '',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey: 'key-02-01',
            actionTitle: 'ultraLight',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                weight: 'ultraLight',
              },
            }
          }, {
            actionKey: 'key-02-02',
            actionTitle: 'semibold',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                weight: 'semibold',
              },
            }
          }, {
            actionKey: 'key-02-03',
            actionTitle: 'black',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'heart',
                weight: 'black',
              },
            }
          }],
        },  {
          type: 'menu',
          menuTitle: '',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey: 'key-03-01',
            actionTitle: 'paletteColors',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'delete.left.fill',
                paletteColors: ['red', 'blue']
              },
            }
          }, {
            actionKey: 'key-03-02',
            actionTitle: 'semibold',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'delete.left.fill',
                hierarchicalColor: 'red',
              },
            }
          }, {
            actionKey: 'key-03-03',
            actionTitle: 'paletteColors',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'folder.fill.badge.plus',
                paletteColors: ['blue', 'red']
              },
            }
          },  {
            actionKey: 'key-03-04',
            actionTitle: 'hierarchicalColor',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'folder.fill.badge.plus',
                hierarchicalColor: 'blue',
              },
            }
          }],
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample25'}
        subtitle={'Icon Example'}
        description={[
          `Advanced SFSymbols icon customization`,
          `E.g.: scale, weight, paletteColors, hierarchicalColor`
        ]}
      />
    </ContextMenuView>
  );
};