/** Used for `IconConfigKeys.iconType` or `IconConfigKeys.iconType` */
export const IconTypes = {
  'NONE'   : 'NONE'   ,
  'SYSTEM' : 'SYSTEM' ,
  'ASSET'  : 'ASSET'  ,
  'REQUIRE': 'REQUIRE',
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

/** Used for `PreviewConfigKeys.previewType` */
export const PreviewType = {
  'DEFAULT': 'DEFAULT',
  'CUSTOM' : 'CUSTOM' ,
};

/** Used for `PreviewConfigKeys.previewSize` */
export const PreviewSize = {
  'INHERIT': 'INHERIT' ,
  'STRETCH': 'STRETCH' ,
};

/** Used for `PreviewConfigKeys.preferredCommitStyle` */
export const CommitStyle = {
  'pop'    : 'pop'     ,
  'dismiss': 'dismiss' ,
};

export const IconConfigKeys = {
  iconType : 'iconType',
  iconValue: 'iconValue',
  iconTint : 'iconTint',
};

export const PreviewConfigKeys = {
  previewType         : 'previewType'         , // optional - PreviewType value
  previewSize         : 'previewSize'         , // optional - PreviewSize value
  isResizeAnimated    : 'isResizeAnimated'    , // optional - bool
  borderRadius        : 'borderRadius'        , // optional - number
  backgroundColor     : 'backgroundColor'     , // optional - string
  preferredCommitStyle: 'preferredCommitStyle', // optional - CommitStyle value
};

export const MenuActionKeys = {
  actionKey           : 'actionKey'           , // required - string: unique identifier
  actionTitle         : 'actionTitle'         , // required - string value
  icon                : 'icon'                , // optional - IconKeys object
  menuState           : 'menuState'           , // optional - MenuElementState item
  menuAttributes      : 'menuAttributes'      , // optional - MenuElementAtrributes item
  discoverabilityTitle: 'discoverabilityTitle', // optional - string value
};

export const MenuConfigKeys = {
  menuTitle  : 'menuTitle'  , // required - string
  menuOptions: 'menuOptions', // optional - array of MenuOptions
  icon       : 'icon'       , // optional - IconKeys object
  menuItems  : 'menuItems'  , // optional - array of MenuConfigKeys/MenuActionKeys
};