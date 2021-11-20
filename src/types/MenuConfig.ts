import type { ImageItemConfig } from "./ImageItemConfig";
import type { IconConfig } from "./MenuIconConfig";

/** Maps to `UIMenu.Options` */
// TODO: Next Major Version - Once `Enums.ts` is removed, rename back to `MenuOptions` 
export type UIMenuOptions = 'destructive' | 'displayInline';

/** Maps to `UIMenuElement.State` */
// TODO: Next Major Version - Rename to `MenuElementState`
export type MenuState = 'on' | 'off' | 'mixed';

/** Maps to `MenuElement.Attributes` */
// TODO: Next Major Version - Rename to `MenuElementAttributes`
export type MenuAttributes = 'hidden' | 'disabled' | 'destructive';

export type MenuActionConfig = {
  // TODO: Next Major Version - Make this required
  type?: 'action';

  actionKey: string;
  actionTitle: string;

  /** 
   * Requires iOS 15 or later.
   * Text that appears below the menu action title.
   * 
   * Previously, on iOS 13 and 14, the menu action's subtitle was set via 
   * `MenuActionConfig.discoverabilityTitle`.
   * */
  actionSubtitle?: string;
  
  menuState?: MenuState;
  menuAttributes?: MenuAttributes;

  discoverabilityTitle?: string;

  /**
   * `IconConfig` is deprecated, use `ImageItemConfig` instead.
   * Used to configure what icon or image to show in the menu action.
   */
  icon?: IconConfig | ImageItemConfig;
};

export type MenuConfig = {
  // TODO: Next Major Version - Make this required
  type?: 'menu';

  menuTitle: string;

  menuOptions?: Array<UIMenuOptions>;
  menuItems?: Array<MenuConfig | MenuActionConfig>;

  /**
   * `IconConfig` is deprecated, use `ImageItemConfig` instead.
   * Used to configure what icon or image to show in the submenu.
   * 
   * Note: The icon is only shown if the menu is a submenu. If the menu
   * is the root menu, the icon will not be visible.
   */
  icon?: IconConfig | ImageItemConfig;
};