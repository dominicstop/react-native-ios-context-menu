import { useContext } from 'react';

import { ContextMenuButtonContext } from '../context/ContextMenuButtonContext';


export function useMenuButtonContext() {
  const context = useContext(ContextMenuButtonContext);

  if(context == null){
    throw new Error(
      "unable to get ContextMenuButtonContext"
    );
  };

  return context;
};