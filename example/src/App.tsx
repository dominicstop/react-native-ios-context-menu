import * as React from 'react';
import { StyleSheet, SafeAreaView, FlatList, ListRenderItem } from 'react-native';

import type { ContextMenuExampleProps } from './examples/SharedExampleTypes';

import { ContextMenuViewExample01 } from './examples/ContextMenuViewExample01';
import { ContextMenuViewExample02 } from './examples/ContextMenuViewExample02';


type ExampleListItem = {
  id: number;
  component: React.FC<ContextMenuExampleProps>;
};

const EXAMPLE_COMPONENTS = [
  ContextMenuViewExample01,
  ContextMenuViewExample02,
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
