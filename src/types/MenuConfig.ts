/** Maps to `UIMenu.Options` */
export type MenuOptions = 'destructive' | 'displayInline';

/** Maps to `UIMenuElement.State` */
export type MenuElementState = 'on' | 'off' | 'mixed';

/** Maps to `MenuElement.Attributes` */
export type MenuElementAttributes = 'hidden' | 'disabled' | 'destructive';

export type MenuActionConfig = {
  actionKey: string;
  actionTitle: string;
  discoverabilityTitle: string;

  menuState: MenuElementState;
  menuAttributes: MenuElementAttributes;

  icon: any; // TODO
  // actionSubtitle - TODO: TBA
};

export type MenuConfig = {
  menuTitle: string;
  menuOptions: Array<MenuOptions>;
  menuItems: Array<MenuConfig | MenuActionConfig>;
  icon: any; // TODO
};