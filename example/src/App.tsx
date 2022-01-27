import * as React from 'react';
import { StyleSheet, SafeAreaView, FlatList, ListRenderItem, View, Text, TouchableOpacity } from 'react-native';

import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import type { ContextMenuExampleProps } from './examples/SharedExampleTypes';

import { ContextMenuViewExample01 } from './examples/ContextMenuViewExample01';
import { ContextMenuViewExample02 } from './examples/ContextMenuViewExample02';
import { ContextMenuViewExample03 } from './examples/ContextMenuViewExample03';
import { ContextMenuViewExample04 } from './examples/ContextMenuViewExample04';
import { ContextMenuViewExample05 } from './examples/ContextMenuViewExample05';
import { ContextMenuViewExample06 } from './examples/ContextMenuViewExample06';
import { ContextMenuViewExample07 } from './examples/ContextMenuViewExample07';
import { ContextMenuViewExample08 } from './examples/ContextMenuViewExample08';
import { ContextMenuViewExample09 } from './examples/ContextMenuViewExample09';
import { ContextMenuViewExample10 } from './examples/ContextMenuViewExample10';
import { ContextMenuViewExample11 } from './examples/ContextMenuViewExample11';
import { ContextMenuViewExample12 } from './examples/ContextMenuViewExample12';
import { ContextMenuViewExample13 } from './examples/ContextMenuViewExample13';
import { ContextMenuViewExample14 } from './examples/ContextMenuViewExample14';
import { ContextMenuViewExample15 } from './examples/ContextMenuViewExample15';
import { ContextMenuViewExample16 } from './examples/ContextMenuViewExample16';
import { ContextMenuViewExample17 } from './examples/ContextMenuViewExample17';
import { ContextMenuViewExample18 } from './examples/ContextMenuViewExample18';

import { ContextMenuViewTest01 } from './examples/ContextMenuViewTest01';
import { ContextMenuViewTest02 } from './examples/ContextMenuViewTest02';
import { ContextMenuViewTest03 } from './examples/ContextMenuViewTest03';
import { ContextMenuViewTest04 } from './examples/ContextMenuViewTest04';
import { ContextMenuViewTest05 } from './examples/ContextMenuViewTest05';
import { ContextMenuViewTest06 } from './examples/ContextMenuViewTest06';
import { ContextMenuViewTest07 } from './examples/ContextMenuViewTest07';
import { ContextMenuViewTest08 } from './examples/ContextMenuViewTest08';

import { ContextMenuButtonExample01 } from './examples/ContextMenuButtonExample01';
import { ContextMenuButtonExample02 } from './examples/ContextMenuButtonExample02';


type ExampleListItem = {
  id: number;
  component: React.FC<ContextMenuExampleProps>;
};

const EXAMPLE_COMPONENTS = [
  ContextMenuViewExample01,
  ContextMenuViewExample02,
  ContextMenuViewExample03,
  ContextMenuViewExample04,
  ContextMenuViewExample05,
  ContextMenuViewExample06,
  ContextMenuViewExample07,
  ContextMenuViewExample08,
  ContextMenuViewExample09,
  ContextMenuViewExample10,
  ContextMenuViewExample11,
  ContextMenuViewExample12,
  ContextMenuViewExample13,
  ContextMenuViewExample14,
  ContextMenuViewExample15,
  ContextMenuViewExample16,
  ContextMenuViewExample17,
  ContextMenuViewExample18,
  ContextMenuViewTest01,
  ContextMenuViewTest02,
  ContextMenuViewTest03,
  ContextMenuViewTest04,
  ContextMenuViewTest05,
  ContextMenuViewTest06,
  ContextMenuViewTest07,
  ContextMenuViewTest08,
  ContextMenuButtonExample01,
  ContextMenuButtonExample02,
];

const EXAMPLE_ITEMS: ExampleListItem[] = EXAMPLE_COMPONENTS.map((item, index) => ({
  id: index + 1,
  component: item
}));

export function HomeScreen(props) {
  const renderItem: ListRenderItem<ExampleListItem>  = ({ item })  => (
    React.createElement(item.component, {
      index: item.id,
      style: styles.exampleListItem
    })
  );

  return (
    <SafeAreaView>
      <TouchableOpacity
        onPress={() => {
          props.navigation.navigate('Test');
        }}
      >
        <Text>
          Push
        </Text>
      </TouchableOpacity>
      <FlatList
        contentContainerStyle={styles.scrollContentContainer}
        data={EXAMPLE_ITEMS}
        renderItem={renderItem}
        keyExtractor={(item) => `item-${item.id}`}
      />
    </SafeAreaView>
  );
};

const TestScreen = () => {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text>Test Screen</Text>
    </View>
  );
};

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Test" component={TestScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  scrollContentContainer: {
    paddingHorizontal: 10,
    paddingBottom: 100,
    paddingTop: 20,
  },
  exampleListItem: {
    marginBottom: 15,
  },
});
