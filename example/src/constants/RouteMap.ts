import { ROUTE_ITEMS, type RouteEntry } from "./RouteItems";
import type { RouteKey } from "./RouteKeys";


export const ROUTE_MAP: Record<RouteKey, RouteEntry> = (() => {
  const map: Record<string, RouteEntry> = {};

  for (const routeItem of ROUTE_ITEMS) {
    map[routeItem.routeKey] = routeItem;
  };

  return map;
})();