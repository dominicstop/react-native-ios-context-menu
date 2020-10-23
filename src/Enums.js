export const ImageTypes = {
  'NONE'  : 'NONE'  ,
  'URL '  : 'URL'   ,
  'SYSTEM': 'SYSTEM',
};

export const MenuOptions = {
  destructive  : 'destructive'  ,
  displayInline: 'displayInline',
};

export const MenuElementAtrributes = {
  hidden     : 'hidden'     ,
  disabled   : 'disabled'   ,
  destructive: 'destructive',
};

export const MenuElementState = {
  on   : 'on'   ,
  off  : 'off'  ,
  mixed: 'mixed',
};

export const MenuItemKeys = {
  key           : 'key'           , // required - unique identifier
  title         : 'title'         , // required - string value
  imageType     : 'imageType'     , // optional - ImageTypes item
  imageValue    : 'imageValue'    , // optional - string value
  menuState     : 'menuState'     , // optional - MenuElementState item
  menuAttributes: 'menuAttributes', // optional - MenuElementAtrributes item
  submenuItems  : 'submenuItems'  , // optional - array of MenuItemKeys
};