import * as React from 'react';
import { StyleSheet, SafeAreaView, FlatList, ListRenderItem } from 'react-native';

import type { ContextMenuExampleProps } from '../examples/SharedExampleTypes';

import { ContextMenuViewExample01 } from '../examples/ContextMenuViewExample01';
import { ContextMenuViewExample02 } from '../examples/ContextMenuViewExample02';
import { ContextMenuViewExample03 } from '../examples/ContextMenuViewExample03';
import { ContextMenuViewExample04 } from '../examples/ContextMenuViewExample04';
import { ContextMenuViewExample05 } from '../examples/ContextMenuViewExample05';
import { ContextMenuViewExample06 } from '../examples/ContextMenuViewExample06';
import { ContextMenuViewExample07 } from '../examples/ContextMenuViewExample07';
import { ContextMenuViewExample08 } from '../examples/ContextMenuViewExample08';
import { ContextMenuViewExample09 } from '../examples/ContextMenuViewExample09';
import { ContextMenuViewExample10 } from '../examples/ContextMenuViewExample10';
import { ContextMenuViewExample11 } from '../examples/ContextMenuViewExample11';
import { ContextMenuViewExample12 } from '../examples/ContextMenuViewExample12';
import { ContextMenuViewExample13 } from '../examples/ContextMenuViewExample13';
import { ContextMenuViewExample14 } from '../examples/ContextMenuViewExample14';
import { ContextMenuViewExample15 } from '../examples/ContextMenuViewExample15';
import { ContextMenuViewExample16 } from '../examples/ContextMenuViewExample16';
import { ContextMenuViewExample17 } from '../examples/ContextMenuViewExample17';
import { ContextMenuViewExample18 } from '../examples/ContextMenuViewExample18';
import { ContextMenuViewExample19 } from '../examples/ContextMenuViewExample19';
import { ContextMenuViewExample20 } from '../examples/ContextMenuViewExample20';
import { ContextMenuViewExample21 } from '../examples/ContextMenuViewExample21';
import { ContextMenuViewExample22 } from '../examples/ContextMenuViewExample22';
import { ContextMenuViewExample23 } from '../examples/ContextMenuViewExample23';
import { ContextMenuViewExample24 } from '../examples/ContextMenuViewExample24';
import { ContextMenuViewExample25 } from '../examples/ContextMenuViewExample25';
import { ContextMenuViewExample26 } from '../examples/ContextMenuViewExample26';
import { ContextMenuViewExample27 } from '../examples/ContextMenuViewExample27';

import { ContextMenuAuxPreviewExample01 } from '../examples/ContextMenuAuxPreviewExample01';
import { ContextMenuAuxPreviewExample02 } from '../examples/ContextMenuAuxPreviewExample02';
import { ContextMenuAuxPreviewExample03 } from '../examples/ContextMenuAuxPreviewExample03';
import { ContextMenuAuxPreviewExample04 } from '../examples/ContextMenuAuxPreviewExample04';
import { ContextMenuAuxPreviewExample05 } from '../examples/ContextMenuAuxPreviewExample05';
import { ContextMenuAuxPreviewExample06 } from '../examples/ContextMenuAuxPreviewExample06';
import { ContextMenuAuxPreviewExample07 } from '../examples/ContextMenuAuxPreviewExample07';
import { ContextMenuAuxPreviewExample08 } from '../examples/ContextMenuAuxPreviewExample08';
import { ContextMenuAuxPreviewExample09 } from '../examples/ContextMenuAuxPreviewExample09';
import { ContextMenuAuxPreviewExample10 } from '../examples/ContextMenuAuxPreviewExample10';
import { ContextMenuAuxPreviewExample11 } from '../examples/ContextMenuAuxPreviewExample11';
import { ContextMenuAuxPreviewExample12 } from '../examples/ContextMenuAuxPreviewExample12';
import { ContextMenuAuxPreviewExample13 } from '../examples/ContextMenuAuxPreviewExample13';
import { ContextMenuAuxPreviewExample14 } from '../examples/ContextMenuAuxPreviewExample14';
import { ContextMenuAuxPreviewExample15 } from '../examples/ContextMenuAuxPreviewExample15';

import { ContextMenuViewTest01 } from '../examples/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from '../examples/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from '../examples/ContextMenuViewTest03';
import { ContextMenuViewTest04 } from '../examples/ContextMenuViewTest04';
import { ContextMenuViewTest05 } from '../examples/ContextMenuViewTest05';
import { ContextMenuViewTest06 } from '../examples/ContextMenuViewTest06';
import { ContextMenuViewTest07 } from '../examples/ContextMenuViewTest07';
import { ContextMenuViewTest08 } from '../examples/ContextMenuViewTest08';
import { ContextMenuViewTest09 } from '../examples/ContextMenuViewTest09';
import { ContextMenuViewTest10 } from '../examples/ContextMenuViewTest10';

import { ContextMenuAuxPreviewTest01 } from '../examples/ContextMenuAuxPreviewTest01';
import { ContextMenuAuxPreviewTest02 } from '../examples/ContextMenuAuxPreviewTest02';

import { ContextMenuButtonExample01 } from '../examples/ContextMenuButtonExample01';
import { ContextMenuButtonExample02 } from '../examples/ContextMenuButtonExample02';
import { ContextMenuButtonExample03 } from '../examples/ContextMenuButtonExample03';

import { DebugControls } from '../examples/DebugControls';
import { SHARED_ENV } from '../constants/SharedEnv';


type ExampleListItem = {
  id: number;
  component: React.FC<ContextMenuExampleProps>;
};

const EXAMPLE_COMPONENTS = [
  SHARED_ENV.enableReactNavigation && DebugControls,
  ContextMenuViewExample01,
  ContextMenuViewExample02,
  ContextMenuViewExample03,
  ContextMenuViewExample04,
  ContextMenuViewExample05,
  ContextMenuViewExample06,
  ContextMenuViewExample07,
  ContextMenuViewExample08,
  ContextMenuViewExample09,
  ContextMenuViewExample10,
  ContextMenuViewExample11,
  ContextMenuViewExample12,
  ContextMenuViewExample13,
  ContextMenuViewExample14,
  ContextMenuViewExample15,
  ContextMenuViewExample16,
  ContextMenuViewExample17,
  ContextMenuViewExample18,
  ContextMenuViewExample19,
  ContextMenuViewExample20,
  ContextMenuViewExample21,
  ContextMenuViewExample22,
  ContextMenuViewExample23,
  ContextMenuViewExample24,
  ContextMenuViewExample25,
  ContextMenuViewExample26,
  ContextMenuViewExample27,
  ContextMenuAuxPreviewExample01,
  ContextMenuAuxPreviewExample02,
  ContextMenuAuxPreviewExample03,
  ContextMenuAuxPreviewExample04,
  ContextMenuAuxPreviewExample05,
  ContextMenuAuxPreviewExample06,
  ContextMenuAuxPreviewExample07,
  ContextMenuAuxPreviewExample08,
  ContextMenuAuxPreviewExample09,
  ContextMenuAuxPreviewExample10,
  ContextMenuAuxPreviewExample11,
  ContextMenuAuxPreviewExample12,
  ContextMenuAuxPreviewExample13,
  ContextMenuAuxPreviewExample14,
  ContextMenuAuxPreviewExample15,
  ContextMenuViewTest01,
  ContextMenuViewTest02,
  ContextMenuViewTest03,
  ContextMenuViewTest04,
  ContextMenuViewTest05,
  ContextMenuViewTest06,
  ContextMenuViewTest07,
  ContextMenuViewTest08,
  ContextMenuViewTest09,
  ContextMenuViewTest10,
  ContextMenuAuxPreviewTest01,
  ContextMenuAuxPreviewTest02,
  ContextMenuButtonExample01,
  ContextMenuButtonExample02,
  ContextMenuButtonExample03,
];

const EXAMPLE_ITEMS: ExampleListItem[] = EXAMPLE_COMPONENTS.map((item, index) => ({
  id: index + 1,
  component: item
}));

export function HomeScreen() {
  const renderItem: ListRenderItem<ExampleListItem>  = ({ item })  => (
    React.createElement(item.component, {
      index: item.id,
      style: styles.exampleListItem
    })
  );

  return (
    <SafeAreaView>
      <FlatList
        contentContainerStyle={styles.scrollContentContainer}
        data={EXAMPLE_ITEMS}
        renderItem={renderItem}
        keyExtractor={(item) => `item-${item.id}`}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  scrollContentContainer: {
    paddingHorizontal: 10,
    paddingBottom: 100,
    paddingTop: 20,
  },
  exampleListItem: {
    marginBottom: 15,
  },
});