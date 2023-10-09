import { StyleSheet, Text, View } from 'react-native';

import * as ReactNativeIosContextMenu from 'react-native-ios-context-menu';

export default function App() {
  return (
    <View style={styles.container}>
      <Text>{ReactNativeIosContextMenu.hello()}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
