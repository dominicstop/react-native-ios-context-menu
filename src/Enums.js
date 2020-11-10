
/** Used for `MenuConfigKeys.imageType` or `MenuActionKeys.imageType` */
export const ImageTypes = {
  'NONE'  : 'NONE'  ,
  'SYSTEM': 'SYSTEM',
  'ASSET' : 'ASSET' ,
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
  imageType           : 'imageType'           , // optional - ImageTypes item
  imageValue          : 'imageValue'          , // optional - string value
  menuState           : 'menuState'           , // optional - MenuElementState item
  menuAttributes      : 'menuAttributes'      , // optional - MenuElementAtrributes item
  discoverabilityTitle: 'discoverabilityTitle', // optional - string value
};

export const MenuConfigKeys = {
  menuTitle  : 'menuTitle'  , // required - string
  menuOptions: 'menuOptions', // optional - array of MenuOptions
  imageType  : 'imageType'  , // optional - ImageTypes item
  imageValue : 'imageValue' , // optional - string value
  menuItems  : 'menuItems'  , // optional - array of MenuConfigKeys/MenuActionKeys
};