import { MenuActionKeys, MenuConfigKeys, MenuOptions, MenuElementAtrributes } from '../Enums';
import * as Helpers from './helpers';

// TODO: Refactor/cleanup...

class ActionSheetFallbackHelpers {
  /** is the object a `MenuAction` item */
  static isObjectMenuAction(object){
    return (
      (object?.[MenuActionKeys.actionKey     ] != null) ||
      (object?.[MenuActionKeys.actionTitle   ] != null) ||
      (object?.[MenuActionKeys.menuAttributes] != null) ||
      (object?.[MenuActionKeys.menuAttributes] != null)
    );
  };
  
  /** is the object a `MenuObject` item */
  static isObjectMenuConfig(object){
    return (
      (object?.[MenuConfigKeys.menuTitle  ] != null) ||
      (object?.[MenuConfigKeys.menuItems  ] != null) ||
      (object?.[MenuConfigKeys.menuOptions] != null)
    );
  };

  /** based on the `indexPath`, return the corresponding `MenuConfig` item */
  static getItemFromMenuConfig(menuConfig, indexPath){
    if(indexPath  == null) return null;
    if(menuConfig == null) return null;

    let currentObject = menuConfig;

    for (const index of indexPath) {
      if(ActionSheetFallbackHelpers.isObjectMenuAction(currentObject)){
        return currentObject;

      } else if (currentObject == null || !ActionSheetFallbackHelpers.isObjectMenuConfig(currentObject)){
        return null;
      };

      currentObject = currentObject?.[MenuConfigKeys.menuItems][index];
    };

    return currentObject;
  };

  /** handle inline submenu's by hoisting submenu action to the parent menu */
  static flattenMenuConfig(menuConfig){
    if(menuConfig == null) return null;
    let indexPath = [0];
    let currentParent = menuConfig;

    const incrementCurrentIndexPath = () => {
      const indexPathCount = indexPath.length;
      // increment last index path
      indexPath[indexPathCount - 1]++;
    };

    const getCurrentIndexPath = () => {
      const indexPathCount = indexPath.length;
      return indexPath[indexPathCount - 1];
    };

    const getCurrentParentItemsCount = () => {
      return currentParent
        ?.[MenuConfigKeys.menuItems]
        ?.length ?? 0;
    };

    const didReachEnd = () => {
      return getCurrentIndexPath() >= (getCurrentParentItemsCount() - 1);
    };
    
    // traverse menu config until last item reached
    while(true){
      let currentItem = ActionSheetFallbackHelpers
        .getItemFromMenuConfig(menuConfig, indexPath);

      if (ActionSheetFallbackHelpers.isObjectMenuConfig(currentItem)){
        // current item is menu config, check if inline submenu
        const isInlineSubmenu = currentItem?.[MenuConfigKeys.menuOptions]
          ?.includes(MenuOptions.displayInline) ?? false;

        const inlineSubmenuItemsCount = 
          currentItem?.[MenuConfigKeys.menuItems]?.length ?? 0;

        if(isInlineSubmenu && inlineSubmenuItemsCount > 0){
          const inlineMenu = currentParent?.[MenuConfigKeys.menuItems]
            .splice(getCurrentIndexPath(), 1);

          const inlineMenuItems = 
            inlineMenu?.[0]?.[MenuConfigKeys.menuItems] ?? [];

          currentParent?.[MenuConfigKeys.menuItems]
            .splice(getCurrentIndexPath(), 0, ...inlineMenuItems)

        } else {
          // update currentParent
          currentParent = ActionSheetFallbackHelpers.getItemFromMenuConfig(menuConfig, indexPath);
          // and traverse down...
          indexPath.push(0);
        };

      } else if(didReachEnd()){
        // reached last item, go to next item
        indexPath.pop()
        incrementCurrentIndexPath();

        const nextIndexPath  = indexPath.slice(0, indexPathCount - 1);
        const indexPathCount = indexPath.length;

        currentParent = ((indexPathCount <= 0)
          ? menuConfig
          : ActionSheetFallbackHelpers.getItemFromMenuConfig(menuConfig, nextIndexPath)
        );

        // last menu config item reached, stop...
        if(didReachEnd() || indexPath.length < 1) break;

      } else if(ActionSheetFallbackHelpers.isObjectMenuAction(currentItem)){
        // current item is menu action, skip...
        incrementCurrentIndexPath();
        
      } else {
        // current item unknown item, skip...
        incrementCurrentIndexPath();
      };
    };

    return menuConfig;
  };
  
  /** returns the index of the first destructive action */
  static getdestructiveButtonIndex(menuItems){
    if(menuItems == null) return null;
    for (let index = 0; index < menuItems.length; index++) {
      const menuItem = menuItems[index];

      const isDestructiveAction = menuItem
        ?.[MenuActionKeys.menuAttributes]
        ?.includes(MenuElementAtrributes.destructive) ?? false;

      const isDestructiveMenu = menuItem
        ?.[MenuConfigKeys.menuOptions]
        ?.includes(MenuOptions.destructive) ?? false;

      if(isDestructiveAction || isDestructiveMenu){
        return index;
      };
    };

    return null;
  };

  /** remove disabled/hidden menu actions */
  static filterMenuItems(menuItems = []){
    if(menuItems == null) return [];

    return menuItems.filter(menuItem => {
      const isDisabledAction = menuItem
        ?.[MenuActionKeys.menuAttributes]
        ?.includes(MenuElementAtrributes.disabled) ?? false;

      const isHiddenAction = menuItem
        ?.[MenuActionKeys.menuAttributes]
        ?.includes(MenuElementAtrributes.hidden) ?? false;
      
      return (!isDisabledAction && !isHiddenAction);
    });
  };
};

export class ActionSheetFallback {
  /** based on a `MenuConfig` object, show an `ActionSheetIOS` menu  */
  static async show(menuConfig = {}){
    let indexPath = [];

    let actionSheetOptions     = [];
    let cancelButtonIndex      = 0;
    let destructiveButtonIndex = null;

    const menuConfigCopy = JSON.parse(
      JSON.stringify(menuConfig)
    );

    // handle 'inlineMenu' submenu's
    ActionSheetFallbackHelpers.flattenMenuConfig(menuConfigCopy);

    while(true){
      const menuItem = 
        ActionSheetFallbackHelpers.getItemFromMenuConfig(menuConfigCopy, indexPath);

      // selected item is an action, exit...
      if(ActionSheetFallbackHelpers.isObjectMenuAction(menuItem)){
        return menuItem;
      };

      // selected item is menu, get submenu and remove hidden/disable actions
      const menuItems = ActionSheetFallbackHelpers.filterMenuItems(menuItem?.[MenuConfigKeys.menuItems] ?? []);
      // add menu items to action sheet
      actionSheetOptions = menuItems.map(item => (
        item?.[MenuActionKeys.actionTitle] ??
        item?.[MenuConfigKeys.menuTitle  ] ?? null
      ));

      // set destructive index and offset by 1 bc of cancel button
      destructiveButtonIndex = ActionSheetFallbackHelpers.getdestructiveButtonIndex(menuItems);
      if(destructiveButtonIndex != null) destructiveButtonIndex++;
      
      // wait for selected item
      const selectedIndex = await Helpers.asyncActionSheet({
        // action sheet config
        ...((cancelButtonIndex      != null) && {cancelButtonIndex     }),
        ...((destructiveButtonIndex != null) && {destructiveButtonIndex}),
        options: ['cancel', ...actionSheetOptions],
      });

      // guard: cancel button pressed, exit...
      if(selectedIndex === cancelButtonIndex) return null;

      // push selected index to indexPath and loop
      indexPath.push(selectedIndex - 1);
    };
  };
};
