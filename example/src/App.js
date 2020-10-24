import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView } from 'react-native';

import { ContextMenuViewSimpleExample01 } from './components/ContextMenuViewSimpleExample01';
import { ContextMenuViewSimpleExample02 } from './components/ContextMenuViewSimpleExample02';
import { ContextMenuViewSimpleExample03 } from './components/ContextMenuViewSimpleExample03';
import { ContextMenuViewSimpleExample04 } from './components/ContextMenuViewSimpleExample04';
import { ContextMenuViewSimpleExample05 } from './components/ContextMenuViewSimpleExample05';
import { ContextMenuViewSimpleExample06 } from './components/ContextMenuViewSimpleExample06';
import { ContextMenuViewSimpleExample07 } from './components/ContextMenuViewSimpleExample07';
import { ContextMenuViewSimpleExample08 } from './components/ContextMenuViewSimpleExample08';


const items = [
  ContextMenuViewSimpleExample01,
  ContextMenuViewSimpleExample02,
  ContextMenuViewSimpleExample03,
  ContextMenuViewSimpleExample04,
  ContextMenuViewSimpleExample05,
  ContextMenuViewSimpleExample06,
  ContextMenuViewSimpleExample07,
  ContextMenuViewSimpleExample08,
];

export default function App() {

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView contentContainerStyle={styles.scrollviewContainer}>
        {items.map((element, index) => 
          React.createElement(element, { 
            key  : `item-${index}`,
            index: (index + 1), 
          })
        )}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
  },
  scrollviewContainer: {
    paddingBottom: 30,
  },
});
