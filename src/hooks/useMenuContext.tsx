import { useContext } from 'react';

import { ContextMenuViewContext } from '../context/ContextMenuViewContext';


export function useMenuContext() {
  const context = useContext(ContextMenuViewContext);

  if(context == null){
    throw new Error(
      "unable to get ContextMenuViewContext"
    );
  };

  return context;
};