import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';

export default function App() {

  return (
    <View style={styles.container}>
      <ContextMenuViewTest01/>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    //alignItems: 'center',
    //justifyContent: 'center',
  },
});
