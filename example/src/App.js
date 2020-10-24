import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView } from 'react-native';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from './components/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from './components/ContextMenuViewTest03';
import { ContextMenuViewTest04 } from './components/ContextMenuViewTest04';
import { ContextMenuViewTest05 } from './components/ContextMenuViewTest05';
import { ContextMenuViewTest06 } from './components/ContextMenuViewTest06';
import { ContextMenuViewTest07 } from './components/ContextMenuViewTest07';

export default function App() {

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView contentContainerStyle={styles.scrollviewContainer}>
        <ContextMenuViewTest01/>
        <ContextMenuViewTest02/>
        <ContextMenuViewTest03/>
        <ContextMenuViewTest04/>
        <ContextMenuViewTest05/>
        <ContextMenuViewTest06/>
        <ContextMenuViewTest07/>
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
