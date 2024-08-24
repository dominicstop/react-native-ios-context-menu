import { ContextMenuViewExample01 } from "../examples/ContextMenuViewExample01";
import type { ExampleItemProps } from "../examples/SharedExampleTypes";
import type { RouteEntry } from "./RouteItems";

import { ROUTE_MAP } from "./RouteMap";


type ExampleItemBase = {
  component: unknown;
};

export type ExampleItemRoute = ExampleItemBase & RouteEntry & {
  type: 'screen';
  title?: string;
  subtitle?: string;
  desc?: Array<string>;
};

export type ExampleItemCard = ExampleItemBase & {
  type: 'card';
}

export type ExampleItem = 
  | ExampleItemRoute
  | ExampleItemCard;

export type ExampleListItem = {
  id: number;
  component: React.FC<ExampleItemProps>;
};

export const EXAMPLE_ITEMS: Array<ExampleItem> = (() => {
  
  const screenItems: Array<ExampleItemRoute> = [
    {
      type: 'screen',
      ...ROUTE_MAP.contextMenuTest01,
    }
  ];

  const cardItems: Array<ExampleItemCard> = [
    {
      type: 'card',
      component: ContextMenuViewExample01,
    },
  ]; 

  // if (SHARED_ENV.enableReactNavigation) {
  //   items.splice(0, 0, ...[DebugControls]);
  // }

  return [...screenItems, ...cardItems];
})();