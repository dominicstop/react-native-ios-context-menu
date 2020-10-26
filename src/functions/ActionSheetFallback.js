import { MenuActionKeys, MenuConfigKeys } from '../Enums';
import * as Helpers from './helpers';


export class ActionSheetFallback {

  static isObjectMenuAction(object){
    if(object == null) return false;
    return (
      (object?.[MenuActionKeys.actionKey  ] != null) &&
      (object?.[MenuActionKeys.actionTitle] != null)
    );
  };

  static isObjectMenuConfig(object){
    if(object == null) return false;
    return (object?.[MenuConfigKeys.menuTitle] != null);
  };

  static getItemFromMenuConfig(menuConfig, indexPath){
    if(indexPath  == null) return null;
    if(menuConfig == null) return null;

    let currentObject = {...menuConfig};

    for (const index of indexPath) {
      console.log(`getItemFromMenuConfig - ${index} - ${JSON.stringify(indexPath)}`);

      if(ActionSheetFallback.isObjectMenuAction(currentObject)){
        console.log(`getItemFromMenuConfig - currentObject: MenuAction`);

        return currentObject;

      } else if (currentObject == null || !ActionSheetFallback.isObjectMenuConfig(currentObject)){
        console.log(`getItemFromMenuConfig - currentObject: null`);
        
        return null;
      };

      console.log(`getItemFromMenuConfig - currentObject: ${JSON.stringify(currentObject)}`);
      currentObject = currentObject?.[MenuConfigKeys.menuItems][index];
    };

    return currentObject;
  };

  static async show(menuConfig = {}){
    let indexPath = [];

    let actionSheetOptions     = [];
    let cancelButtonIndex      = 0;
    let destructiveButtonIndex = null;

    while(true){
      const menuItem = 
        ActionSheetFallback.getItemFromMenuConfig(menuConfig, indexPath);

      if(ActionSheetFallback.isObjectMenuAction(menuItem)){
        alert(JSON.stringify(menuItem));
        return menuItem;
      };

      console.log(`show - menuItem: ${JSON.stringify(menuItem)}`);

      const menuItems = menuItem?.[MenuConfigKeys.menuItems] ?? [];
      actionSheetOptions = menuItems.map(item => (
        item?.[MenuActionKeys.actionTitle] ??
        item?.[MenuConfigKeys.menuTitle  ] ?? null
      ));
      
      console.log(`show - menuItems: ${JSON.stringify(menuItems)}`);
      console.log(`show - actionSheetOptions: ${JSON.stringify(actionSheetOptions)}`);


      const selectedIndex = await Helpers.asyncActionSheet({
        // action sheet config
        ...((cancelButtonIndex      != null) && {cancelButtonIndex     }),
        ...((destructiveButtonIndex != null) && {destructiveButtonIndex}),
        options: ['cancel', ...actionSheetOptions],
      });

      console.log(`show - selectedIndex: ${selectedIndex}`);


      // guard: cancel button pressed, exit...
      if(selectedIndex === cancelButtonIndex) return;

      indexPath.push(selectedIndex - 1);
      
    };
  };
};
