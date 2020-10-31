import * as React from 'react';
import { StyleSheet, SafeAreaView, ScrollView, View, Text, Switch } from 'react-native';

import * as Colors from './constants/Colors';

import { ContextMenuViewSimpleExample01 } from './components/ContextMenuViewSimpleExample01';
import { ContextMenuViewSimpleExample02 } from './components/ContextMenuViewSimpleExample02';
import { ContextMenuViewSimpleExample03 } from './components/ContextMenuViewSimpleExample03';
import { ContextMenuViewSimpleExample04 } from './components/ContextMenuViewSimpleExample04';
import { ContextMenuViewSimpleExample05 } from './components/ContextMenuViewSimpleExample05';
import { ContextMenuViewSimpleExample06 } from './components/ContextMenuViewSimpleExample06';
import { ContextMenuViewSimpleExample07 } from './components/ContextMenuViewSimpleExample07';
import { ContextMenuViewSimpleExample08 } from './components/ContextMenuViewSimpleExample08';
import { ContextMenuViewSimpleExample09 } from './components/ContextMenuViewSimpleExample09';
import { ContextMenuViewSimpleExample10 } from './components/ContextMenuViewSimpleExample10';

import { ContextMenuViewTest01 } from './components/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from './components/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from './components/ContextMenuViewTest03';
import { ContextMenuViewTest04 } from './components/ContextMenuViewTest04';
import { ContextMenuViewTest05 } from './components/ContextMenuViewTest05';
import { ContextMenuViewTest06 } from './components/ContextMenuViewTest06';

import { ContextMenuButtonSimpleExample01 } from './components/ContextMenuButton/ContextMenuButtonSimpleExample01';



const contextMenuViewItems = [
  ContextMenuViewSimpleExample01,
  ContextMenuViewSimpleExample02,
  ContextMenuViewSimpleExample03,
  ContextMenuViewSimpleExample04,
  ContextMenuViewSimpleExample05,
  ContextMenuViewSimpleExample06,
  ContextMenuViewSimpleExample07,
  ContextMenuViewSimpleExample08,
  ContextMenuViewSimpleExample09,
  ContextMenuViewSimpleExample10,
  ContextMenuViewTest01,
  ContextMenuViewTest02,
  ContextMenuViewTest03,
  ContextMenuViewTest04,
  ContextMenuViewTest05,
  ContextMenuViewTest06,
];

const contextMenuButtonItems = [
  ContextMenuButtonSimpleExample01
];

console.disableYellowBox = true;

export default function App() {
  const [useActionSheetFallback, setUseActionSheetFallback] = React.useState(false);
  const toggleUseActionSheetFallback = () => setUseActionSheetFallback(previousState => !previousState);

  return (
    <SafeAreaView style={styles.rootContainer}>
      <ScrollView contentContainerStyle={styles.scrollviewContainer}>
        <Text style={styles.textSectionTitle}>
          {'ContextMenuView'}
        </Text>
        <Text style={styles.textSectionSubtitle}>
          {'Examples and tests for `ContextMenuView`'}
        </Text>
        <View style={styles.headerContainer}>
          <Text>
            {'When the context menu is visible, the card wil turn purple.'}
          </Text>
          <View style={styles.headerRowContainer}>
            <Text style={styles.headerRowText}>
              {'useActionSheetFallback: '}
            </Text>
            <Switch
              onValueChange={toggleUseActionSheetFallback}
              value={useActionSheetFallback}
            />
          </View>
        </View>
        {contextMenuViewItems.map((element, index) => 
          React.createElement(element, { 
            key  : `context-menu-view-item-${index}`,
            index: (index + 1),
            // pass down props
            useActionSheetFallback,
          })
        )}
        <View style={{marginTop: 20}}/>
        <Text style={styles.textSectionTitle}>
          {'ContextMenuButton'}
        </Text>
        <Text style={styles.textSectionSubtitle}>
          {'Examples and tests for `ContextMenuButton`'}
        </Text>
        <View style={[styles.headerContainer, {backgroundColor: Colors.AMBER[50]}]}>
          <Text>
            {'When the context menu is visible, the button will turn yellow. \n\nNote: The `useActionSheetFallback` switch in the `ContextMenuView` section will also carry over here.'}
          </Text>
        </View>
        {contextMenuButtonItems.map((element, index) => 
          React.createElement(element, { 
            key  : `context-menu-button-item-${index}`,
            index: (index + 1),
            // pass down props
            useActionSheetFallback,
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
  textSectionTitle: {
    fontSize: 32,
    fontWeight: 'bold',
    marginHorizontal: 10,
  },
  textSectionSubtitle: {
    marginHorizontal: 10,
    fontSize: 16,
    fontWeight: '300',
    color: Colors.GREY[600],
    marginBottom: 5,
  },
  headerContainer: {
    borderRadius: 10,
    padding: 15,
    marginTop: 10,
    marginHorizontal: 20,
    backgroundColor: Colors.BLUE[100]
  },
  headerRowContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 7,
  },
  headerRowText: {
    flex: 1,
    fontWeight: 'bold'
  },
});
