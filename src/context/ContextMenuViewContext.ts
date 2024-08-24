import React from 'react';

import type { ContextMenuView } from '../components/ContextMenuView';

export type ContextMenuViewContextProps = {
  isMenuVisible: boolean;
  getRefToContextMenuView: () => ContextMenuView;
};

export const ContextMenuViewContext = 
  React.createContext<Partial<ContextMenuViewContextProps>>({});