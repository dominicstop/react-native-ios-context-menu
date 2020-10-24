import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView } from 'react-native';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';

export default function App() {

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView>
        <ContextMenuViewTest01/>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
  },
});
