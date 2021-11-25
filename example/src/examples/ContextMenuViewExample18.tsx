import * as React from 'react';
import { Image } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


const iconA = Image.resolveAssetSource(
  require('../assets/emoji-pleading-face.png')
);

const iconB = Image.resolveAssetSource(
  require('../assets/emoji-smiling-face-with-hearts.png')
);

const iconC = Image.resolveAssetSource(
  require('../assets/emoji-sparkling-heart.png')
);

export function ContextMenuViewExample18(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample18',
        menuItems: [{
          actionKey  : 'key-01'   ,
          actionTitle: 'Action #1',
          discoverabilityTitle: 'Use "REQUIRE" icon',
          icon: {
            iconType : 'REQUIRE',
            iconValue: iconA,
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          discoverabilityTitle: 'Use "REQUIRE" icon',
          icon: {
            iconType : 'REQUIRE',
            iconValue: iconB,
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          discoverabilityTitle: 'Use "REQUIRE" icon',
          icon: {
            iconType : 'REQUIRE',
            iconValue: iconC,
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample18'}
        subtitle={'ImageType Icons'}

        description={[
          `Context menu with actions that uses 'REQUIRE' icons`
        ]}
      />
    </ContextMenuView>
  );
};