import { MenuActionKeys, MenuConfigKeys, MenuOptions, MenuElementAtrributes } from '../Enums';
import * as Helpers from './helpers';


export class ActionSheetFallback {

  static isObjectMenuAction(object){
    if(object == null) return false;
    return (
      (object?.[MenuActionKeys.actionKey     ] != null) ||
      (object?.[MenuActionKeys.actionTitle   ] != null) ||
      (object?.[MenuActionKeys.menuAttributes] != null) ||
      (object?.[MenuActionKeys.menuAttributes] != null)
    );
  };

  static isObjectMenuConfig(object){
    if(object == null) return false;
    return (
      (object?.[MenuConfigKeys.menuTitle  ] != null) ||
      (object?.[MenuConfigKeys.menuItems  ] != null) ||
      (object?.[MenuConfigKeys.menuOptions] != null)
    );
  };

  static getItemFromMenuConfig(menuConfig, indexPath){
    if(indexPath  == null) return null;
    if(menuConfig == null) return null;

    let currentObject = menuConfig;

    for (const index of indexPath) {
      if(ActionSheetFallback.isObjectMenuAction(currentObject)){
        return currentObject;

      } else if (currentObject == null || !ActionSheetFallback.isObjectMenuConfig(currentObject)){
        return null;
      };

      currentObject = currentObject?.[MenuConfigKeys.menuItems][index];
    };

    return currentObject;
  };

  // handle inline submenu's
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

    const getPrevIndexPath = () => {
      const indexPathCount = indexPath.length;
      return indexPath?.[indexPathCount - 2] ?? null;
    };

    const getCurrentParentItemsCount = () => {
      return currentParent
        ?.[MenuConfigKeys.menuItems]
        ?.length ?? 0;
    };

    const didReachEnd = () => {
      return getCurrentIndexPath() >= (getCurrentParentItemsCount() - 1);
    };
    
    // traverse menu config until last
    while(true){
      let currentItem =
        ActionSheetFallback.getItemFromMenuConfig(menuConfig, indexPath);

      if (ActionSheetFallback.isObjectMenuConfig(currentItem)){
        // current item is menu config, check if inline submenu
        const isInlineSubmenu = currentItem?.[MenuConfigKeys.menuOptions]
          ?.includes(MenuOptions.displayInline) ?? false;

        const inlineSubmenuItemsCount = currentItem?.[MenuConfigKeys.menuItems]
          ?.length ?? 0;

        console.log(
            `flatten - currentItem is: menu`
          + ` - indexPath: ${JSON.stringify(indexPath)}`
          + ` - inlineSubmenuItemsCount: ${inlineSubmenuItemsCount}`
          + ` - isInlineSubmenu: ${isInlineSubmenu}`
        );

        if(isInlineSubmenu && inlineSubmenuItemsCount > 0){
          const inlineMenu = currentParent?.[MenuConfigKeys.menuItems]
            .splice(getCurrentIndexPath(), 1);

          const inlineMenuItems = 
            inlineMenu?.[0]?.[MenuConfigKeys.menuItems] ?? [];

          console.log(
              `flatten - spliced finished`
            + `\n - removed item: ${JSON.stringify(inlineMenu)}`
            + `\n - inlineMenuItems: ${JSON.stringify(inlineMenuItems)}`
            + `\n - currentParent menuItems count: ${currentParent?.[MenuConfigKeys.menuItems]?.length}`
            + `\n - adding inlineMenuItems at index: ${getCurrentIndexPath()}`
          );

          currentParent?.[MenuConfigKeys.menuItems]
            .splice(getCurrentIndexPath(), 0, ...inlineMenuItems)

        } else {
          // update currentParent
          currentParent = 
            ActionSheetFallback.getItemFromMenuConfig(menuConfig, indexPath);
            
          // and traverse down...
          indexPath.push(0);
        };

      } else if(didReachEnd()){
        // reached last menuConfig item, break...
        console.log('end reached, indexPath: ' + JSON.stringify(indexPath));
        console.log(`removing last index item: ${indexPath.pop()}`);
        console.log('new indexPath: ' + JSON.stringify(indexPath));

        const indexPathCount = indexPath.length;

        incrementCurrentIndexPath();
        if(indexPathCount <= 0){
          currentParent = menuConfig;
        } else {
          console.log(`indexPath slice`);
          currentParent = ActionSheetFallback.getItemFromMenuConfig(
            menuConfig, 
            indexPath.slice(0, indexPathCount - 1)
          );
        };

        console.log('incrementing last index path: ' + JSON.stringify(indexPath));
        console.log('currentParent updated: ' + JSON.stringify(currentParent));
        console.log('didReachEnd: ' + didReachEnd());
        console.log('indexPath count: ' + indexPath.length);

        if(didReachEnd() || indexPath.length < 1){
          break;
        };

      } else if(ActionSheetFallback.isObjectMenuAction(currentItem)){
        // current item is menu action, skip...
        incrementCurrentIndexPath();
        
      } else {
        // current item unknown item, skip...
        incrementCurrentIndexPath();
      };
    };

    return menuConfig;
  };

  static getdestructiveButtonIndex(menuItems){
    if(menuItems == null) return null;
    for (let index = 0; index < menuItems.length; index++) {
      const menuItem = menuItems[index];

      const isDestructiveAction = menuItem
        ?.[MenuActionKeys.menuAttributes]
        ?.includes(MenuElementAtrributes.destructive) ?? false;

      console.log({isDestructiveAction});

      const isDestructiveMenu = menuItem
        ?.[MenuConfigKeys.menuOptions]
        ?.includes(MenuOptions.destructive) ?? false;

      console.log({isDestructiveMenu});


      if(isDestructiveAction || isDestructiveMenu){
        return index;
      };
    };

    return null;
  };

  /** remove disabled/hidden menu actions */
  static filterMenuItems(menuItems = []){
    if(menuItems == null) return null;

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

  // todo make deep copy
  static async show(menuConfig = {}){
    let indexPath = [];

    let actionSheetOptions     = [];
    let cancelButtonIndex      = 0;
    let destructiveButtonIndex = null;

    const menuConfigCopy = JSON.parse(
      JSON.stringify(menuConfig)
    );

    ActionSheetFallback.flattenMenuConfig(menuConfigCopy);

    while(true){
      const menuItem = 
        ActionSheetFallback.getItemFromMenuConfig(menuConfigCopy, indexPath);

      // selected item is an action, exit...
      if(ActionSheetFallback.isObjectMenuAction(menuItem)){
        alert(JSON.stringify(menuItem));
        return menuItem;
      };

      console.log(`show - menuItem: ${JSON.stringify(menuItem)}`);

      // selected item is menu, get submenu and remove hidden/disable actions
      const menuItems = ActionSheetFallback.filterMenuItems(menuItem?.[MenuConfigKeys.menuItems] ?? []);
      // add menu items to action sheet
      actionSheetOptions = menuItems.map(item => (
        item?.[MenuActionKeys.actionTitle] ??
        item?.[MenuConfigKeys.menuTitle  ] ?? null
      ));

      // set destructive index and offset by 1 bc of cancel button
      destructiveButtonIndex = ActionSheetFallback.getdestructiveButtonIndex(menuItems);
      if(destructiveButtonIndex != null) destructiveButtonIndex++;
      
      console.log(`show - menuItems: ${JSON.stringify(menuItems)}`);
      console.log(`destructiveButtonIndex: ${destructiveButtonIndex}`);
      console.log(`show - actionSheetOptions: ${JSON.stringify(actionSheetOptions)}`);


      // wait for selected item
      const selectedIndex = await Helpers.asyncActionSheet({
        // action sheet config
        ...((cancelButtonIndex      != null) && {cancelButtonIndex     }),
        ...((destructiveButtonIndex != null) && {destructiveButtonIndex}),
        options: ['cancel', ...actionSheetOptions],
      });

      console.log(`show - selectedIndex: ${selectedIndex}`);


      // guard: cancel button pressed, exit...
      if(selectedIndex === cancelButtonIndex) return;

      // push selected index to indexPath and loop
      indexPath.push(selectedIndex - 1);
    };
  };
};
