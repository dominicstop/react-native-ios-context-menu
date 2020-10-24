import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView } from 'react-native';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from './components/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from './components/ContextMenuViewTest03';

export default function App() {

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView contentContainerStyle={styles.scrollviewContainer}>
        <ContextMenuViewTest01/>
        <ContextMenuViewTest02/>
        <ContextMenuViewTest03/>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
  },
  scrollviewContainer: {
    paddingBottom: 30,
  },
});
