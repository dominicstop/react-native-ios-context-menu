import React from 'react';
import type { ContextMenuButton } from '../components/ContextMenuButton';


export type ContextMenuButtonContextProps = {
  isMenuVisible: boolean;
  getRefToContextMenuButton: () => ContextMenuButton;
};

export const ContextMenuButtonContext = 
  React.createContext<Partial<ContextMenuButtonContextProps>>({});