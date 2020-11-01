/** Used for `ContextMenuView` `PreviewType` prop */
export const PreviewType = {
  'DEFAULT': 'DEFAULT',
  'CUSTOM' : 'CUSTOM' ,
};

/** Used for `MenuConfigKeys.imageType` or `MenuActionKeys.imageType` */
export const ImageTypes = {
  'NONE'  : 'NONE'  ,
  'URL '  : 'URL'   ,
  'SYSTEM': 'SYSTEM',
};

/** Used for `MenuConfigKeys.menuOptions` */
export const MenuOptions = {
  destructive  : 'destructive'  ,
  displayInline: 'displayInline',
};

/** Used for `MenuActionKeys.menuAttributes` */
export const MenuElementAtrributes = {
  hidden     : 'hidden'     ,
  disabled   : 'disabled'   ,
  destructive: 'destructive',
};

/** Used for `MenuActionKeys.menuState` */
export const MenuElementState = {
  on   : 'on'   ,
  off  : 'off'  ,
  mixed: 'mixed',
};

export const MenuActionKeys = {
  actionKey     : 'actionKey'     , // required - string: unique identifier
  actionTitle   : 'actionTitle'   , // required - string value
  imageType     : 'imageType'     , // optional - ImageTypes item
  imageValue    : 'imageValue'    , // optional - string value
  menuState     : 'menuState'     , // optional - MenuElementState item
  menuAttributes: 'menuAttributes', // optional - MenuElementAtrributes item
};

export const MenuConfigKeys = {
  menuTitle  : 'menuTitle'  , // required - string
  menuOptions: 'menuOptions', // optional - array of MenuOptions
  imageType  : 'imageType'  , // optional - ImageTypes item
  imageValue : 'imageValue' , // optional - string value
  menuItems  : 'menuItems'  , // optional - array of MenuConfigKeys/MenuActionKeys
};