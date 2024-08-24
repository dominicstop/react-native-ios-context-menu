import React from 'react';

// import type { ContextMenuButton } from '../components/ContextMenuButton';

export type ContextMenuButtonContextProps = {
  isMenuVisible: boolean;
  // TODO: WIP - to be re-impl.
  // getRefToContextMenuButton: () => ContextMenuButton;
};

export const ContextMenuButtonContext = 
  React.createContext<Partial<ContextMenuButtonContextProps>>({});