import type { MenuElementConfig } from './MenuConfig';


export type DeferredElementProvider = ( 
  deferredID: string, 
  completion: (items: MenuElementConfig[]) => void
) => void;
