import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView, View, Text } from 'react-native';

import * as Colors from './constants/Colors';

import { ContextMenuViewSimpleExample01 } from './components/ContextMenuViewSimpleExample01';
import { ContextMenuViewSimpleExample02 } from './components/ContextMenuViewSimpleExample02';
import { ContextMenuViewSimpleExample03 } from './components/ContextMenuViewSimpleExample03';
import { ContextMenuViewSimpleExample04 } from './components/ContextMenuViewSimpleExample04';
import { ContextMenuViewSimpleExample05 } from './components/ContextMenuViewSimpleExample05';
import { ContextMenuViewSimpleExample06 } from './components/ContextMenuViewSimpleExample06';
import { ContextMenuViewSimpleExample07 } from './components/ContextMenuViewSimpleExample07';
import { ContextMenuViewSimpleExample08 } from './components/ContextMenuViewSimpleExample08';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from './components/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from './components/ContextMenuViewTest03';
import { ContextMenuViewTest04 } from './components/ContextMenuViewTest04';
import { ContextMenuViewTest05 } from './components/ContextMenuViewTest05';
import { ContextMenuViewTest06 } from './components/ContextMenuViewTest06';


const items = [
  ContextMenuViewSimpleExample01,
  ContextMenuViewSimpleExample02,
  ContextMenuViewSimpleExample03,
  ContextMenuViewSimpleExample04,
  ContextMenuViewSimpleExample05,
  ContextMenuViewSimpleExample06,
  ContextMenuViewSimpleExample07,
  ContextMenuViewSimpleExample08,
  ContextMenuViewTest01,
  ContextMenuViewTest02,
  ContextMenuViewTest03,
  ContextMenuViewTest04,
  ContextMenuViewTest05,
  ContextMenuViewTest06,
];

export default function App() {

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView contentContainerStyle={styles.scrollviewContainer}>
        <View style={styles.headerContainer}>
          <Text>
            {'When the context menu is visible, the card wil turn purple.'}
          </Text>
        </View>
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
  headerContainer: {
    borderRadius: 10,
    padding: 15,
    marginTop: 10,
    marginHorizontal: 20,
    backgroundColor: Colors.BLUE[100]
  },
});
