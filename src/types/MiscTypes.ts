
export type PointPreset = 
  | 'top' 
  | 'bottom' 
  | 'left' 
  | 'right'
  | 'bottomLeft' 
  | 'bottomRight' 
  | 'topLeft' 
  | 'topRight';

export type Point = {
  x: number;
  y: number;
};

/** Object return by `DynamicColorIOS` */
export type DynamicColor = {
  dynamic: {
    dark: string;
    light: string;
  };
};