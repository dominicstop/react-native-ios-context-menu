import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

// import {  } from "react-native-ios-utilities";
import { ContextMenuView } from "react-native-ios-context-menu";

export function BasicUsageExample01() {
  return (
    <ContextMenuView
      style={styles.menuContainer}
      menuConfig={{
        menuTitle: 'BasicUsageExample01',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
        }],
      }}
    >
      <Text style={styles.text}>
        Press And Hold To Show Context Menu
      </Text>
    </ContextMenuView>
  );
};

export default function App() {
  return (
    <View style={styles.container}>
      <StatusBar style="auto" />
      <BasicUsageExample01/>
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
  menuContainer: {
    margin: 10,
    padding: 10,
  },
  text: {
    fontSize: 16,
  },
});
