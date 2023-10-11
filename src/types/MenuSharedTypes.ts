import type { MenuElementConfig } from 'src/types/MenuConfig';


export type DeferredElementProvider = ( 
  deferredID: string, 
  completion: (items: MenuElementConfig[]) => void
) => void;
