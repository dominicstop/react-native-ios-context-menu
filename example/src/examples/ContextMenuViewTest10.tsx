import * as React from 'react';

import { ContextMenuView, MenuActionConfig, MenuConfig, MenuElementConfig } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Helpers from '../functions/Helpers';
import * as Colors  from '../constants/Colors';
import type { ImageItemConfig } from 'src/types/ImageItemConfig';


type MenuConfigKeys = 
  | 'menuCutCopyPaste'
  | 'actionShare'
  | 'actionFavorite'
  | 'actionSendACopy'
  | 'actionAddToFavorites'
  | 'actionAddToWork'
  | 'actionAddToSchool'
  | 'menuInLineSmallRow1'
  | 'menuInLineSmallRow2'
  | 'menuInLineSmallRow3'
  | 'menuInLineSmallRow4'
  | 'menuInLineSmallRow5'
  | 'menuInLineSmallRow6'
  | 'menuInLineSmallRow7';

const MENU_CONFIGS: Record<MenuConfigKeys, MenuElementConfig> = {
  actionFavorite: {
    type: 'action',
    actionKey: `favorite`,
    actionTitle: 'Unfavorite',
    actionSubtitle: 'Remove from favorites',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'star.fill',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.AMBER.A700,
      },
    }
  },

  actionShare: {
    type: 'action',
    actionKey: `share`,
    actionTitle: 'Share...',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'square.and.arrow.up',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.BLUE.A700,
      },
    }
  },

  menuCutCopyPaste: {
    type: 'menu',
    menuTitle: '',
    menuOptions: ['displayInline'],
    menuPreferredElementSize: 'medium',
    menuItems: [{
      type: 'action',
      actionKey: `cut`,
      actionTitle: 'Cut',
      icon: {
        type: 'IMAGE_SYSTEM',
        imageValue: {
          systemName: 'scissors',
          scale: 'large',
        },
      }
    }, {
      type: 'action',
      actionKey: `copy`,
      actionTitle: 'Copy',
      icon: {
        type: 'IMAGE_SYSTEM',
        imageValue: {
          systemName: 'doc.on.doc',
          scale: 'large',
        }
      },
    }, {
      type: 'action',
      actionKey: `paste`,
      actionTitle: 'Paste',
      icon: {
        type: 'IMAGE_SYSTEM',
        imageValue: {
          systemName: 'doc.on.clipboard',
          scale: 'large',
        }, 
      }
    }]
  },

  actionSendACopy: {
    type: 'action',
    actionKey: `sendCopy`,
    actionTitle: 'Send a Copy',
    actionSubtitle: 'Create shareable link...',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'paperplane',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.PURPLE.A700,
      },
    }
  },

  actionAddToFavorites: {
    type: 'action',
    actionKey: 'add-to-favorites',
    actionTitle: 'Favorites',
    actionSubtitle: 'Add to Favorites...',
    menuState: 'on',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'star.fill',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.AMBER.A700,
      },
    }
  },

  actionAddToWork: {
    type: 'action',
    actionKey: 'add-to-work',
    actionTitle: 'Work',
    actionSubtitle: 'Add to Work...',
    menuState: 'off',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'briefcase',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.BLUE.A700,
      },
    }
  },

  actionAddToSchool: {
    type: 'action',
    actionKey: 'add-to-school',
    actionTitle: 'School',
    actionSubtitle: 'Add to School...',
    menuState: 'off',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'book',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.PURPLE.A700,
      },
    }
  },

  ...(() => {
    const heartOutline: ImageItemConfig = {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'heart',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.RED.A700,
      },
    };

    const heartFill: ImageItemConfig = {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'heart.fill',
        scale: 'large',
      },
      imageOptions: {
        renderingMode: 'alwaysOriginal',
        tint: Colors.RED.A700,
      },
    };

    let actionKeyCounter = 0;

    const makeActionHeartOutline = (): MenuActionConfig => ({
      type: 'action',
      actionKey: `heart-${actionKeyCounter++}`,
      actionTitle: '',
      icon: heartOutline,
    });

    const makeActionHeartFill = (): MenuActionConfig => ({
      type: 'action',
      actionKey: `heart-${actionKeyCounter++}`,
      actionTitle: '',
      icon: heartFill,
    });

    const makeRow = (n = 1, shouldOffset = false): MenuElementConfig[] => (
      [...Array(n).keys()].map(i => (
        ((shouldOffset? i + 1 : i) % 2 === 0)
          ? makeActionHeartOutline()
          : makeActionHeartFill()
      ))
    );

    const makeMenu = (n = 1, shouldOffset = false): MenuConfig => ({
      type: 'menu',
      menuTitle: '',
      menuOptions: ['displayInline'],
      menuPreferredElementSize: 'small',
      menuItems: makeRow(n, shouldOffset),
    });

    return ({
      menuInLineSmallRow1: makeMenu(1),
      menuInLineSmallRow2: makeMenu(2),
      menuInLineSmallRow3: makeMenu(3),
      menuInLineSmallRow4: makeMenu(4),
      menuInLineSmallRow5: makeMenu(4, true),
      menuInLineSmallRow6: makeMenu(4),
      menuInLineSmallRow7: makeMenu(4, true),
    });
  })()
};


export function ContextMenuViewTest10(props: ContextMenuExampleProps) {

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        type: 'menu',
        menuTitle: '',
        menuItems: [{
          type: 'action',
          actionKey: `edit`,
          actionTitle: `Edit...`
        }, {
          type: 'deferred',
          deferredID: 'def-01',
          shouldCache: false,
        }],
      }}
      onRequestDeferredElement={async (deferredID, provider) => {
        switch (deferredID) {
          // 01
          case 'def-01':
            await Helpers.timeout(500);
            provider([{
              // 01-01 - Inline Submenu
              type: 'menu',
              menuTitle: '',
              menuOptions: ['displayInline'],
              menuItems: [{
                //01-01-01
                ...MENU_CONFIGS.actionFavorite
              }, {
                //01-01-02
                type: 'deferred',
                deferredID: 'def-01-01-02'
              }, {
                //01-01-03
                ...MENU_CONFIGS.actionShare
              }],
            }, {
              // 01-02 - Nested Submenu
              type: 'menu',
              menuTitle: 'Move to...',
              menuItems: [{
                // 01-02-01 - In-line Submenu
                type: 'menu',
                menuTitle: '',
                menuOptions: ['displayInline'],
                menuItems: [{
                  // 01-02-01-01
                  type: 'deferred',
                  deferredID: '01-02-01-01'
                }, {
                  // 01-02-01-02
                  type: 'deferred',
                  deferredID: '01-02-01-02'
                }, {
                  // 01-02-01-03
                  type: 'deferred',
                  deferredID: '01-02-01-03'
                }],
              }, {
                // 01-02-02 - Nested Submenu
                type: 'menu',
                menuTitle: 'Even More Options...',
                menuItems: [{
                  ...MENU_CONFIGS.menuInLineSmallRow1,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow2,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow3,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow4,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow5,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow6,
                }, {
                  ...MENU_CONFIGS.menuInLineSmallRow7,
                }],
              }]
            }, {
              // 01-03 - in-line submenu
              ...MENU_CONFIGS.menuCutCopyPaste
            }]);
            break;
            
          case 'def-01-01-02':
            await Helpers.timeout(1000);
            provider([
              MENU_CONFIGS.actionSendACopy,
            ]);
            break;

          case '01-02-01-01':
            await Helpers.timeout(750);
            provider([{
              ...MENU_CONFIGS.actionAddToFavorites
            }]);
            break;

          case '01-02-01-02':
            await Helpers.timeout(1250);
            provider([{
              ...MENU_CONFIGS.actionAddToWork,
            }]);
            break;

          case '01-02-01-03':
            await Helpers.timeout(1750);
            provider([{
              ...MENU_CONFIGS.actionAddToSchool,
            }]);
            break;

          default:
            break;
        }
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest10'}
        subtitle={'Deferred Element + Nested'}
        description={[
          `Nested menus, deferred elements, large icons, and small menu`,
        ]}
      />
    </ContextMenuView>
  );
};