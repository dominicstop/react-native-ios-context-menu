import { HomeScreen } from "../components/HomeScreen";
import { ContextMenuViewTest01Screen } from "../examples/ContextMenuViewTest01Screen";

import type { RouteKey } from "./RouteKeys";


export type RouteEntry = {
  routeKey: RouteKey
  component: React.ComponentType<{}>;
};

export const ROUTE_ITEMS: Array<RouteEntry> = [
  {
    routeKey: 'home',
    component: HomeScreen,
  }, {
    routeKey: 'contextMenuTest01',
    component: ContextMenuViewTest01Screen,
  },
];