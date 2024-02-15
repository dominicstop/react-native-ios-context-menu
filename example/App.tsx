import * as React from 'react';

import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

import { HomeScreen } from './src/screens/HomeScreen';

import { TestScreen } from './src/screens/Test01Screen';
import { Test02Screen } from './src/screens/Test02Screen';
import { Test03Screen } from './src/screens/Test03Screen';
import { Test04Screen } from './src/screens/Test04Screen';
import { Test05Screen } from './src/screens/Test05Screen';
import { Test07Screen } from './src/screens/Test07Screen';


import { SHARED_ENV } from './src/constants/SharedEnv';
import { View } from 'react-native';


const shouldEnableTabs = 
  SHARED_ENV.enableReactNavigation && SHARED_ENV.enableTabNavigation;

function Tab1StackScreen() {
  if(shouldEnableTabs){
    const Tab1Stack = createNativeStackNavigator();

    return (
    <Tab1Stack.Navigator initialRouteName="Home">
      <Tab1Stack.Screen 
        name="Home" 
        component={HomeScreen}
      />
      <Tab1Stack.Screen 
        name="Test" 
        component={TestScreen}
      />
    </Tab1Stack.Navigator>
  );

  } else {
    return null;
  };
};

export default function App() {
  if(SHARED_ENV.shouldRenderNothing){
    return (
      <View/>
    );
  };
  
  if(shouldEnableTabs){
    const TabNavigator = createBottomTabNavigator();

    return(
      <NavigationContainer>
        <TabNavigator.Navigator>
          <TabNavigator.Screen 
            name="Tab1" 
            component={Tab1StackScreen}
          />
          <TabNavigator.Screen 
            name="Tab2" 
            component={HomeScreen}
          />
        </TabNavigator.Navigator>
      </NavigationContainer>
    );
  } else if(SHARED_ENV.enableReactNavigation){
    const Stack = createNativeStackNavigator();

    return(
      <NavigationContainer>
        <Stack.Navigator initialRouteName="Home">
          <Stack.Screen 
            name="Home" 
            component={HomeScreen}
          />
          <Stack.Screen 
            name="Test" 
            component={TestScreen}
          />
          <Stack.Screen 
            name="Test02" 
            component={Test02Screen}
          />
          <Stack.Screen 
            name="Test03" 
            component={Test03Screen}
          />
          <Stack.Screen 
            name="Test04" 
            component={Test04Screen}
          />
          <Stack.Screen 
            name="Test05" 
            component={Test05Screen}
          />
          <Stack.Screen
            name="Test07"
            component={Test07Screen}
          />
        </Stack.Navigator>
      </NavigationContainer>
    );
  };

  return (
    <HomeScreen/>
  );
};