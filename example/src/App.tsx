import * as React from 'react';

import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

import { HomeScreen } from './screens/HomeScreen';
import { TestScreen } from './screens/Test01Screen';

import { SHARED_ENV } from './constants/SharedEnv';


const Tab       = SHARED_ENV.enableReactNavigation && createBottomTabNavigator();
const Tab1Stack = SHARED_ENV.enableReactNavigation && createNativeStackNavigator();

function Tab1StackScreen() {
  return (
    <Tab1Stack.Navigator initialRouteName="Home">
      <Tab1Stack.Screen name="Home" component={HomeScreen} />
      <Tab1Stack.Screen name="Test" component={TestScreen} />
    </Tab1Stack.Navigator>
  );
};

export default function App() {
  return SHARED_ENV.enableReactNavigation ? (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="Tab1" component={Tab1StackScreen} />
        <Tab.Screen name="Tab2" component={HomeScreen} />
      </Tab.Navigator>
    </NavigationContainer>
  ):(
    <HomeScreen/>
  );
};