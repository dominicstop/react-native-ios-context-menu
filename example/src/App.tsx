import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView } from 'react-native';

import { ContextMenuViewExample01 } from './examples/ContextMenuViewExample01';


export default function App() {
  let index = 1;

  return (
    <ScrollView contentContainerStyle={styles.scrollContentContainer}>
      <ContextMenuViewExample01 index={index++}/>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  scrollContentContainer: {
    paddingHorizontal: 10,
    paddingBottom: 100,
  },
});
