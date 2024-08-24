import * as React from "react";
import { Image, StyleSheet } from "react-native";

import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";

import { HomeScreen } from "./components/HomeScreen";

import { SHARED_ENV } from "./constants/SharedEnv";
import { ROUTE_ITEMS } from "./constants/RouteItems";
import { ROUTE_KEYS } from "./constants/RouteKeys";

const shouldEnableTabs =
  SHARED_ENV.enableReactNavigation && SHARED_ENV.enableTabNavigation;

function NavigationBarBanner(){
  return (
    <Image
      source={(SHARED_ENV.shouldSetAppBackground
        ? require("./assets/tamagui-banner-rainbow-logo-white.png")
        : require("./assets/tamagui-banner-rainbow-logo-black.png")
      )}
      style={styles.navigationBarBannerImage}
    />
  );
};

function Tab1StackScreen() {
  if (shouldEnableTabs) {
    const Tab1Stack = createNativeStackNavigator();

    return (
      <Tab1Stack.Navigator initialRouteName='Home'>
        <Tab1Stack.Screen name='Home' component={HomeScreen} />
      </Tab1Stack.Navigator>
    );
  } else {
    return null;
  }
}

export default function App() {
  if (shouldEnableTabs) {
    const TabNavigator = createBottomTabNavigator();

    return (
      <NavigationContainer>
        <TabNavigator.Navigator>
          <TabNavigator.Screen name='Tab1' component={Tab1StackScreen} />
          <TabNavigator.Screen name='Tab2' component={HomeScreen} />
        </TabNavigator.Navigator>
      </NavigationContainer>
    );
  } else if (SHARED_ENV.enableReactNavigation) {
    const Stack = createNativeStackNavigator();

    return (
      <NavigationContainer>
        <Stack.Navigator
          initialRouteName={ROUTE_KEYS.home}
          screenOptions={{
            contentStyle: {
              backgroundColor: (SHARED_ENV.shouldSetAppBackground
                ? "black"
                : undefined
              ),
            },
            headerShadowVisible: false,
            headerStyle: {
              backgroundColor: (SHARED_ENV.shouldSetAppBackground
                ? "black"
                : undefined
              ),
            },
          }}
        >
          {ROUTE_ITEMS.map((item) => (
            <Stack.Screen
              key={item.routeKey}
              name={item.routeKey}
              component={item.component}
              options={{
                ...(item.routeKey === 'home' && {
                  headerTitle: NavigationBarBanner,
                  headerTitleAlign: "center",
                }),
              }}
            />
          ))}
        </Stack.Navigator>
      </NavigationContainer>
    );
  }

  return <HomeScreen />;
}

const styles = StyleSheet.create({
  navigationBarBannerImage: {
    height: 45,
    width: 115,
    resizeMode: "contain",
  }
});
