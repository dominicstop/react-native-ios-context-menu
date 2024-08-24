import * as React from 'react';
import { Alert } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest01(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest01',
        menuItems: [{
          actionKey  : 'key-01'   ,
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'hare',
            },
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'calendar',
            },
          }
        }, {
          menuTitle: 'Submenu #1...',
          menuSubtitle: 'Nested Menu',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'ant',
            },
          },
          menuItems: [{
            actionKey  : 'key-03-01'   ,
            actionTitle: 'Submenu Action #3',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'moon',
              },
            },
          }, {
            actionKey  : 'key-03-02'   ,
            actionTitle: 'Submenu Action #4',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'house',
              },
            }
          }, {
            menuTitle: 'Submenu #5...',
            menuSubtitle: 'Nested Menu',
            icon: {
              type: 'IMAGE_SYSTEM',
              imageValue: {
                systemName: 'moon.stars',
              },
            },
            menuItems: [{
              actionKey  : 'key-03-03-01',
              actionTitle: 'Submenu Action #5',
              icon: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'dial',
                },
              }
            }, {
              actionKey  : 'key-03-03-02',
              actionTitle: 'Submenu Action #6',
              icon: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'square.and.arrow.up.on.square',
                },
              }
            }, {
              menuTitle: 'Submenu #3...',
              menuSubtitle: 'Nested Menu',
              icon: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'archivebox',
                },
              },
              menuItems: [{
                actionKey  : 'key-03-03-03-01',
                actionTitle: 'Submenu Action #7',
                icon: {
                  type: 'IMAGE_SYSTEM',
                  imageValue: {
                    systemName: 'folder',
                  },
                },
              }, {
                actionKey  : 'key-03-03-03-02',
                actionTitle: 'Submenu Action #8',
                icon: {
                  type: 'IMAGE_SYSTEM',
                  imageValue: {
                    systemName: 'pencil.slash',
                  },
                }
              }, {
                menuTitle: 'Submenu #4...',
                menuSubtitle: 'Nested Menu',
                icon: {
                  type: 'IMAGE_SYSTEM',
                  imageValue: {
                    systemName: 'rosette',
                  },
                },
                menuItems: [{
                  actionKey  : 'key-03-03-03-03-01',
                  actionTitle: 'Submenu Action #9',
                  icon: {
                    type: 'IMAGE_SYSTEM',
                    imageValue: {
                      systemName: 'lessthan.circle',
                    },
                  }
                }, {
                  actionKey  : 'key-03-03-03-03-02',
                  actionTitle: 'Submenu Action #10',
                  icon: {
                    type: 'IMAGE_SYSTEM',
                    imageValue: {
                      systemName: 'divide.square',
                    },
                  }
                }, {
                  actionKey  : 'key-03-03-03-03-03',
                  actionTitle: 'Submenu Action #11',
                  icon: {
                    type: 'IMAGE_SYSTEM',
                    imageValue: {
                      systemName: 'cloud.moon',
                    },
                  }
                }],
              }],
            }],
          }],
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest01'}
        subtitle={'nested menus'}
        description={[
          `Test for multiple nested/deep submenu's`
        ]}
      />
    </ContextMenuView>
  );
};