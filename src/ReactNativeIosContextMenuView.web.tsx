import * as React from 'react';

import { ReactNativeIosContextMenuViewProps } from './ReactNativeIosContextMenu.types';

export default function ReactNativeIosContextMenuView(props: ReactNativeIosContextMenuViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
