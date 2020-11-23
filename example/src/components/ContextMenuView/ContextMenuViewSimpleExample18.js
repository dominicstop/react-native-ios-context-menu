import React from 'react';
import { StyleSheet, Image, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';

const iconA = Image.resolveAssetSource(
  require('../../assets/emoji-pleading-face.png')
);

const iconB = Image.resolveAssetSource(
  require('../../assets/emoji-smiling-face-with-hearts.png')
);

const iconC = Image.resolveAssetSource(
  require('../../assets/emoji-sparkling-heart.png')
);

export function ContextMenuViewSimpleExample18(props) {
  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #18'}
      subtitle={'ImageType Icons'}
      desc={'Context menu with actions that uses `REQUIRE` icons'}
      // `ContextMenuView` Props
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
    />
  );
};

const styles = StyleSheet.create({
});