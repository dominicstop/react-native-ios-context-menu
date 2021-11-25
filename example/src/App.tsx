import * as React from 'react';
import { StyleSheet, SafeAreaView, FlatList, ListRenderItem } from 'react-native';

import type { ContextMenuExampleProps } from './examples/SharedExampleTypes';

import { ContextMenuViewExample01 } from './examples/ContextMenuViewExample01';
import { ContextMenuViewExample02 } from './examples/ContextMenuViewExample02';
import { ContextMenuViewExample03 } from './examples/ContextMenuViewExample03';
import { ContextMenuViewExample04 } from './examples/ContextMenuViewExample04';
import { ContextMenuViewExample05 } from './examples/ContextMenuViewExample05';
import { ContextMenuViewExample06 } from './examples/ContextMenuViewExample06';
import { ContextMenuViewExample07 } from './examples/ContextMenuViewExample07';
import { ContextMenuViewExample08 } from './examples/ContextMenuViewExample08';
import { ContextMenuViewExample09 } from './examples/ContextMenuViewExample09';
import { ContextMenuViewExample10 } from './examples/ContextMenuViewExample10';
import { ContextMenuViewExample11 } from './examples/ContextMenuViewExample11';
import { ContextMenuViewExample12 } from './examples/ContextMenuViewExample12';
import { ContextMenuViewExample13 } from './examples/ContextMenuViewExample13';
import { ContextMenuViewExample14 } from './examples/ContextMenuViewExample14';
import { ContextMenuViewExample15 } from './examples/ContextMenuViewExample15';


type ExampleListItem = {
  id: number;
  component: React.FC<ContextMenuExampleProps>;
};

const EXAMPLE_COMPONENTS = [
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
];

const EXAMPLE_ITEMS: ExampleListItem[] = EXAMPLE_COMPONENTS.map((item, index) => ({
  id: index + 1,
  component: item
}));

export default function App() {
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
  },
  exampleListItem: {
    marginBottom: 10,
  },
});
