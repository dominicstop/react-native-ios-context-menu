import { HomeScreen } from "../components/HomeScreen";
import { ContextMenuViewTest01Screen } from "../examples/ContextMenuViewTest01Screen";

import { Test01Screen } from "../screens/Test01Screen";
import { Test02Screen } from "../screens/Test02Screen";
import { Test03Screen } from "../screens/Test03Screen";
import { Test04Screen } from "../screens/Test04Screen";
import { Test05Screen } from "../screens/Test05Screen";
import { Test06Screen } from "../screens/Test06Screen";
import { Test07Screen } from "../screens/Test07Screen";
import { Test08Screen } from "../screens/Test08Screen";

import type { RouteKey } from "./RouteKeys";


export type RouteEntry = {
  routeKey: RouteKey
  component: React.ComponentType<{}>;
};

export const ROUTE_ITEMS: Array<RouteEntry> = [
  {
    routeKey: 'home',
    component: HomeScreen,
  },
  {
    routeKey: 'test01Screen',
    component: Test01Screen,
  },
  {
    routeKey: 'test02Screen',
    component: Test02Screen,
  },
  {
    routeKey: 'test03Screen',
    component: Test03Screen,
  },
  {
    routeKey: 'test04Screen',
    component: Test04Screen,
  },
  {
    routeKey: 'test05Screen',
    component: Test05Screen,
  },
  {
    routeKey: 'test06Screen',
    component: Test06Screen,
  },
  {
    routeKey: 'test07Screen',
    component: Test07Screen,
  },
  {
    routeKey: 'test08Screen',
    component: Test08Screen,
  },
  {
    routeKey: 'contextMenuTest01',
    component: ContextMenuViewTest01Screen,
  },
];