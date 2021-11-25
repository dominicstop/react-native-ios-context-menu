import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest02(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest02',
        menuItems: [{
          menuTitle: 'Inline Submenu #1',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey  : 'key-01'   ,
            actionTitle: 'Inline Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'hare',
            }
          }, {
            menuTitle  : 'Submenu #1...',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'calendar',
            },
            menuItems: [{
              actionKey  : 'key-02-01',
              actionTitle: 'Submenu Action #1',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'paperclip',
              }
            }, {
              menuTitle: 'Inline Submenu #4',
              menuOptions: ['displayInline'],
              menuItems: [{
                actionKey  : 'key-02-02',
                actionTitle: 'Inline Submenu Action #2',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'house',
                }
              }, {
                actionKey  : 'key-02-03',
                actionTitle: 'Inline Submenu Action #3',
                icon: {
                  iconType : 'SYSTEM',
                  iconValue: 'tag',
                }
              }],
            }, {
              actionKey  : 'key-02-04',
              actionTitle: 'Submenu Action #4',
              icon: {
                iconType : 'SYSTEM',
                iconValue: 'sun.haze',
              }
            }],
          }],
        }, {
          menuTitle: 'Inline Submenu #2',
          menuOptions: ['displayInline'],
          menuItems: [{
            actionKey     : 'key-03'   ,
            actionTitle   : 'Inline Submenu Action #2',
            menuAttributes: ['disabled'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'suit.heart',
            }
          }, {
            actionKey  : 'key-04'   ,
            actionTitle: 'Inline Submenu Action #3',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'suit.club',
            }
          }],
        }, {
          actionKey     : 'key-05'   ,
          actionTitle   : 'Action #4',
          menuAttributes: ['destructive'],
          icon: {
            iconType : 'SYSTEM',
            iconValue: 'trash',
          }
        }]
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest02'}
        subtitle={'inline menus'}
        description={[
          `Test for multiple inline menu's + nested submenu's`
        ]}
      />
    </ContextMenuView>
  );
};