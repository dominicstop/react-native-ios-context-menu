import { StyleSheet, View, Text } from 'react-native';

import { Colors } from 'react-native-ios-utilities';
import { RNIContextMenuView } from 'react-native-ios-context-menu';

export function ContextMenuViewTest01Screen() {
  return (
    <View style={styles.container}>
      <RNIContextMenuView
        style={styles.contextMenuContainer}
      >
        <Text style={styles.label}>
          {'❤️🧡💛💚💙💜'}
        </Text>
      </RNIContextMenuView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
  },
  contextMenuContainer: {
    paddingHorizontal: 8,
    paddingVertical: 6,
    borderRadius: 8,
    overflow: 'hidden',
    backgroundColor: Colors.PURPLE[100],
    alignItems: 'center',
    justifyContent: 'center',
  },
  label: {
    fontSize: 14,
  },
});
