import type { MenuElementConfig } from '../types/MenuConfig';


export type DeferredElementProvider = ( 
  deferredID: string, 
  completion: (items: MenuElementConfig[]) => void
) => void;
