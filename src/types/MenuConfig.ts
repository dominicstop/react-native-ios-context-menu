/** Maps to `UIMenu.Options` */
export type MenuOptions = 'destructive' | 'displayInline';

/** Maps to `UIMenuElement.State` */
// TODO: Rename to `UIMenuElementState`
export type MenuState = 'on' | 'off' | 'mixed';

/** Maps to `MenuElement.Attributes` */
// TODO: Rename to `MenuElementAttributes`
export type MenuAttributes = 'hidden' | 'disabled' | 'destructive';

export type MenuActionConfig = {
  actionKey: string;
  actionTitle: string;
  
  menuState: MenuState;
  menuAttributes: MenuAttributes;

  discoverabilityTitle: string;
  icon: any; // TODO
  
  // subtitle - TODO: TBA
};

export type MenuConfig = {
  menuTitle: string;
  menuOptions: Array<MenuOptions>;
  menuItems: Array<MenuConfig | MenuActionConfig>;
  icon: any; // TODO
};