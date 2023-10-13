import * as React from 'react';
import { StyleSheet, View, ViewStyle } from 'react-native';

export function TriangleView(props: {
  style?: ViewStyle;
  width?: number;
  height?: number;
  color?: string;
  children?: JSX.Element | JSX.Element[]; 
}){

  const { width, height, color } = props;

  const shapeWidth  = width  ?? ((height == null) ? width : 30);
  const shapeHeight = height ?? ((width  == null) ? height: 30);

  const containerStyle = {
    borderLeftWidth  : shapeHeight   ,
    borderRightWidth : shapeHeight   ,
    borderBottomWidth: shapeWidth    ,
    borderBottomColor: color ?? "red",
  };

  return (
    <View style={[styles.triangleContainer, containerStyle, props.style]}>
      {props.children}
    </View>
  );
};

export function CircleView(props: {
  style?: ViewStyle;
  size?: number;
  color?: string;
  children?: JSX.Element | JSX.Element[]; 
}){

  const size = props.size ?? 30;

  const containerStyle = {
    height: size,
    aspectRatio: 1,
    borderRadius: size/2,
    backgroundColor: props.color ?? 'white',
  };

  return (
    <View style={[containerStyle, props.style]}>
      {props.children}
    </View>
  );
};

const styles = StyleSheet.create({
  triangleContainer: {
    width: 0,
    height: 0,
    backgroundColor: "transparent",
    borderStyle: "solid",
    borderLeftColor: "transparent",
    borderRightColor: "transparent",
  },
});