import { ContextMenuViewExample01 } from "../examples/ContextMenuViewExample01";
import { ContextMenuViewExample02 } from "../examples/ContextMenuViewExample02";
import { ContextMenuViewExample03 } from "../examples/ContextMenuViewExample03";
import { ContextMenuViewExample04 } from "../examples/ContextMenuViewExample04";
import { ContextMenuViewExample05 } from "../examples/ContextMenuViewExample05";
import { ContextMenuViewExample06 } from "../examples/ContextMenuViewExample06";
import { ContextMenuViewExample07 } from "../examples/ContextMenuViewExample07";
import { ContextMenuViewExample08 } from "../examples/ContextMenuViewExample08";
import { ContextMenuViewExample09 } from "../examples/ContextMenuViewExample09";
import { ContextMenuViewExample10 } from "../examples/ContextMenuViewExample10";
import { ContextMenuViewExample11 } from "../examples/ContextMenuViewExample11";
import { ContextMenuViewExample12 } from "../examples/ContextMenuViewExample12";
import { ContextMenuViewExample13 } from "../examples/ContextMenuViewExample13";
import { ContextMenuViewExample14 } from "../examples/ContextMenuViewExample14";
import { ContextMenuViewExample15 } from "../examples/ContextMenuViewExample15";
import { ContextMenuViewExample15_02 } from "../examples/ContextMenuViewExample15_02";
import { ContextMenuViewExample16 } from "../examples/ContextMenuViewExample16";
import { ContextMenuViewExample17 } from "../examples/ContextMenuViewExample17";
import { ContextMenuViewExample18 } from "../examples/ContextMenuViewExample18";
import { ContextMenuViewExample19 } from "../examples/ContextMenuViewExample19";
import { ContextMenuViewExample20 } from "../examples/ContextMenuViewExample20";
import { ContextMenuViewExample21 } from "../examples/ContextMenuViewExample21";
import { ContextMenuViewExample22 } from "../examples/ContextMenuViewExample22";
import { ContextMenuViewExample23 } from "../examples/ContextMenuViewExample23";
import { ContextMenuViewExample24 } from "../examples/ContextMenuViewExample24";
import { ContextMenuViewExample25 } from "../examples/ContextMenuViewExample25";
import { ContextMenuViewExample26 } from "../examples/ContextMenuViewExample26";
import { ContextMenuViewExample27 } from "../examples/ContextMenuViewExample27";
import { ContextMenuViewExample28 } from "../examples/ContextMenuViewExample28";

import { ContextMenuViewTest01 } from "../examples/ContextMenuViewTest01";
import { ContextMenuViewTest02 } from "../examples/ContextMenuViewTest02";
import { ContextMenuViewTest03 } from "../examples/ContextMenuViewTest03";
import { ContextMenuViewTest04 } from "../examples/ContextMenuViewTest04";
import { ContextMenuViewTest05 } from "../examples/ContextMenuViewTest05";
import { ContextMenuViewTest06 } from "../examples/ContextMenuViewTest06";
import { ContextMenuViewTest07 } from "../examples/ContextMenuViewTest07";
import { ContextMenuViewTest08 } from "../examples/ContextMenuViewTest08";
import { ContextMenuViewTest09 } from "../examples/ContextMenuViewTest09";
import { ContextMenuViewTest10 } from "../examples/ContextMenuViewTest10";

import { ContextMenuAuxPreviewExample01} from "../examples/ContextMenuAuxPreviewExample01";
import { ContextMenuAuxPreviewExample02} from "../examples/ContextMenuAuxPreviewExample02";
import { ContextMenuAuxPreviewExample03} from "../examples/ContextMenuAuxPreviewExample03";
import { ContextMenuAuxPreviewExample04} from "../examples/ContextMenuAuxPreviewExample04";
import { ContextMenuAuxPreviewExample05} from "../examples/ContextMenuAuxPreviewExample05";
import { ContextMenuAuxPreviewExample06} from "../examples/ContextMenuAuxPreviewExample06";
import { ContextMenuAuxPreviewExample07} from "../examples/ContextMenuAuxPreviewExample07";
import { ContextMenuAuxPreviewExample08} from "../examples/ContextMenuAuxPreviewExample08";
import { ContextMenuAuxPreviewExample09} from "../examples/ContextMenuAuxPreviewExample09";
import { ContextMenuAuxPreviewExample10} from "../examples/ContextMenuAuxPreviewExample10";
import { ContextMenuAuxPreviewExample11} from "../examples/ContextMenuAuxPreviewExample11";
import { ContextMenuAuxPreviewExample12} from "../examples/ContextMenuAuxPreviewExample12";
import { ContextMenuAuxPreviewExample13} from "../examples/ContextMenuAuxPreviewExample13";
import { ContextMenuAuxPreviewExample14} from "../examples/ContextMenuAuxPreviewExample14";
import { ContextMenuAuxPreviewExample15} from "../examples/ContextMenuAuxPreviewExample15";
import { ContextMenuAuxPreviewExample16} from "../examples/ContextMenuAuxPreviewExample16";

import { ContextMenuAuxPreviewTest01 } from "../examples/ContextMenuAuxPreviewTest01";
import { ContextMenuAuxPreviewTest02 } from "../examples/ContextMenuAuxPreviewTest02";

import { ContextMenuButtonExample01 } from "../examples/ContextMenuButtonExample01";
import { ContextMenuButtonExample02 } from "../examples/ContextMenuButtonExample02";
import { ContextMenuButtonExample03 } from "../examples/ContextMenuButtonExample03";
import { ContextMenuButtonExample04 } from "../examples/ContextMenuButtonExample04";

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
    // `ContextMenuView` Examples
    {
      type: 'card',
      component: ContextMenuViewExample01,
    },
    {
      type: 'card',
      component: ContextMenuViewExample02,
    },
    {
      type: 'card',
      component: ContextMenuViewExample03,
    },
    {
      type: 'card',
      component: ContextMenuViewExample04,
    },
    {
      type: 'card',
      component: ContextMenuViewExample05,
    },
    {
      type: 'card',
      component: ContextMenuViewExample06,
    },
    {
      type: 'card',
      component: ContextMenuViewExample07,
    },
    {
      type: 'card',
      component: ContextMenuViewExample08,
    },
    {
      type: 'card',
      component: ContextMenuViewExample09,
    },
    {
      type: 'card',
      component: ContextMenuViewExample10,
    },
    {
      type: 'card',
      component: ContextMenuViewExample11,
    },
    {
      type: 'card',
      component: ContextMenuViewExample12,
    },
    {
      type: 'card',
      component: ContextMenuViewExample13,
    },
    {
      type: 'card',
      component: ContextMenuViewExample14,
    },
    {
      type: 'card',
      component: ContextMenuViewExample15,
    },
    {
      type: 'card',
      component: ContextMenuViewExample15_02,
    },
    {
      type: 'card',
      component: ContextMenuViewExample16,
    },
    {
      type: 'card',
      component: ContextMenuViewExample17,
    },
    {
      type: 'card',
      component: ContextMenuViewExample18,
    },
    {
      type: 'card',
      component: ContextMenuViewExample19,
    },
    {
      type: 'card',
      component: ContextMenuViewExample20,
    },
    {
      type: 'card',
      component: ContextMenuViewExample21,
    },
    {
      type: 'card',
      component: ContextMenuViewExample22,
    },
    {
      type: 'card',
      component: ContextMenuViewExample23,
    },
    {
      type: 'card',
      component: ContextMenuViewExample24,
    },
    {
      type: 'card',
      component: ContextMenuViewExample25,
    },
    {
      type: 'card',
      component: ContextMenuViewExample26,
    },
    {
      type: 'card',
      component: ContextMenuViewExample27,
    },
    {
      type: 'card',
      component: ContextMenuViewExample28,
    },

    // context menu aux. preview examples
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample01,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample02,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample03,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample04,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample05,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample06,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample07,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample08,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample09,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample10,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample11,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample12,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample13,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample14,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample15,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewExample16,
    },

    // `ContextMenuView` Test
    {
      type: 'card',
      component: ContextMenuViewTest01,
    },
    {
      type: 'card',
      component: ContextMenuViewTest02,
    },
    {
      type: 'card',
      component: ContextMenuViewTest03,
    },
    {
      type: 'card',
      component: ContextMenuViewTest04,
    },
    {
      type: 'card',
      component: ContextMenuViewTest05,
    },
    {
      type: 'card',
      component: ContextMenuViewTest06,
    },
    {
      type: 'card',
      component: ContextMenuViewTest07,
    },
    {
      type: 'card',
      component: ContextMenuViewTest08,
    },
    {
      type: 'card',
      component: ContextMenuViewTest09,
    },
    {
      type: 'card',
      component: ContextMenuViewTest10,
    },

    // ContextMenu Aux. Preview tests
    {
      type: 'card',
      component: ContextMenuAuxPreviewTest01,
    },
    {
      type: 'card',
      component: ContextMenuAuxPreviewTest02,
    },

    // `ContextMenuButton` examples
    {
      type: 'card',
      component: ContextMenuButtonExample01
    },
    {
      type: 'card',
      component: ContextMenuButtonExample02
    },
    {
      type: 'card',
      component: ContextMenuButtonExample03
    },
    {
      type: 'card',
      component: ContextMenuButtonExample04
    },
  ]; 

  // if (SHARED_ENV.enableReactNavigation) {
  //   items.splice(0, 0, ...[DebugControls]);
  // }

  return [...screenItems, ...cardItems];
})();