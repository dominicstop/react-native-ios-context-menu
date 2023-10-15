
import * as Helpers from './Helpers';

import type { MenuActionConfig, MenuConfig, MenuElementConfig } from '../types/MenuConfig';

// TODO: Refactor/cleanup...
// TODO: Fix types + remove `@ts-ignore`

class ActionSheetFallbackHelpers {
  /** is the object a `MenuAction` item */
  static isObjectMenuAction(object: object): object is MenuActionConfig {
    return (
      // required properties --------
      ('actionKey'      in object) ||
      ('actionTitle'    in object) ||

      // optional properties --------------
      ('menuState'            in object) ||
      ('menuAttributes'       in object)
    );
  };
  
  /** is the object a `MenuObject` item */
  static isObjectMenuConfig(object: object): object is MenuConfig {
    return (
      // required properties --------
      ('menuTitle'      in object) ||

      // optional properties -----
      ('menuOptions' in object) ||
      ('menuItems'   in object)
    );
  };

  /** based on the `indexPath`, return the corresponding `MenuConfig` item */
  static getItemFromMenuConfig(menuConfig: MenuConfig, indexPath: Array<number>){
    if(indexPath  == null) return null;
    if(menuConfig == null) return null;

    let currentObject: MenuElementConfig | undefined = menuConfig;

    for (const index of indexPath) {
      if(currentObject == null){
        return null;

      } else if(currentObject?.type === 'deferred') {
        return null;

      } else if(ActionSheetFallbackHelpers.isObjectMenuAction(currentObject)){
        return currentObject;

      } else if (!ActionSheetFallbackHelpers.isObjectMenuConfig(currentObject)){
        return null;
      };

      currentObject = currentObject?.menuItems?.[index];
    };

    return currentObject;
  };

  /** handle inline submenu's by hoisting submenu action to the parent menu */
  static flattenMenuConfig(menuConfig: MenuConfig){
    if(menuConfig == null) return null;

    let indexPath = [0];
    let currentParent = menuConfig;

    const incrementCurrentIndexPath = () => {
      const indexPathCount = indexPath.length;
      // increment last index path
      indexPath[indexPathCount - 1]++;
    };

    const getCurrentIndexPath = () => 
      (indexPath[indexPath.length - 1]);

    const getCurrentParentItemsCount = () => 
      (currentParent?.menuItems?.length ?? 0);

    const didReachEnd = () => 
      (getCurrentIndexPath() >= (getCurrentParentItemsCount() - 1));
    
    // traverse menu config until last item reached
    while(true){
      let currentItem = ActionSheetFallbackHelpers
        .getItemFromMenuConfig(menuConfig, indexPath);

      const isCurrentItemEmpty = (currentItem == null);

      if (!isCurrentItemEmpty && ActionSheetFallbackHelpers.isObjectMenuConfig(currentItem!)){
        // current item is menu config, check if inline submenu
        const isInlineSubmenu = 
          currentItem!.menuOptions?.includes('displayInline') ?? false;

        const inlineSubmenuItemsCount = 
          currentItem!.menuItems?.length ?? 0;

        if(isInlineSubmenu && inlineSubmenuItemsCount > 0){
          const inlineMenu = 
            currentParent?.menuItems!.splice(getCurrentIndexPath(), 1);

          const inlineMenuItems = 
            // @ts-ignore
            inlineMenu?.[0]?.menuItems ?? [];

          currentParent?.menuItems!.splice(
            getCurrentIndexPath(), 0, ...inlineMenuItems
          );

        } else {
          // update currentParent
          // @ts-ignore
          currentParent = ActionSheetFallbackHelpers.getItemFromMenuConfig(menuConfig, indexPath);
          // and traverse down...
          indexPath.push(0);
        };

      } else if(didReachEnd()){
        // reached last item, go to next item
        indexPath.pop()
        incrementCurrentIndexPath();

        const indexPathCount = indexPath.length;
        const nextIndexPath  = indexPath.slice(0, indexPathCount - 1);

        // @ts-ignore
        currentParent = ((indexPathCount <= 0)
          ? menuConfig
          : ActionSheetFallbackHelpers.getItemFromMenuConfig(menuConfig, nextIndexPath)
        );

        // last menu config item reached, stop...
        if(didReachEnd() || indexPath.length < 1) break;

      } else if(ActionSheetFallbackHelpers.isObjectMenuAction(currentItem!)){
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
  static getdestructiveButtonIndex(menuItems: MenuConfig['menuItems']){
    if(menuItems == null) return null;
    for (let index = 0; index < menuItems.length; index++) {
      const menuItem = menuItems[index];

      // @ts-ignore
      const isDestructiveAction = menuItem?.menuAttributes
        ?.includes('destructive') ?? false;

      // @ts-ignore
      const isDestructiveMenu = menuItem?.menuOptions
        ?.includes('destructive') ?? false;

      if(isDestructiveAction || isDestructiveMenu){
        return index;
      };
    };

    return null;
  };

  /** remove disabled/hidden menu actions */
  static filterMenuItems(menuItems: MenuConfig['menuItems'] = []){
    if(menuItems == null) return [];

    return menuItems.filter(menuItem => {
      // @ts-ignore
      const isDisabledAction = menuItem?.menuAttributes
        ?.includes('disabled') ?? false;

      // @ts-ignore
      const isHiddenAction = menuItem?.menuAttributes
        ?.includes('hidden') ?? false;

      const isDeferredElement = menuItem?.type === 'deferred';
      
      return (
        !isDisabledAction && 
        !isHiddenAction && 
        !isDeferredElement
      );
    }) as Array<MenuConfig | MenuActionConfig>;
  };
};

export class ActionSheetFallback {
  /** based on a `MenuConfig` object, show an `ActionSheetIOS` menu  */
  static async show(menuConfig: MenuConfig){
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
      if(ActionSheetFallbackHelpers.isObjectMenuAction(menuItem!)){
        return menuItem;
      };

      // selected item is menu, get submenu and remove hidden/disable actions
      // @ts-ignore
      const menuItems = ActionSheetFallbackHelpers.filterMenuItems(menuItem?.menuItems ?? []);
      // add menu items to action sheet
      // @ts-ignore
      actionSheetOptions = menuItems.map(item => (
        // @ts-ignore
        item?.actionTitle ??
        // @ts-ignore
        item?.menuTitle   ?? null
      ));

      // set destructive index and offset by 1 bc of cancel button
      // @ts-ignore
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
      // @ts-ignore
      indexPath.push(selectedIndex - 1);
    };
  };
};
