import * as React from 'react';
import { StyleSheet, View, Text, ViewStyle } from 'react-native';

import * as Colors from '../../constants/Colors';

/**
 * ```
 * ┌─────────────────────────────┐
 * │ Property            'Value' │
 * │ Object                      │
 * │  Property           'Value' │
 * │  Property           'Value' │
 * └─────────────────────────────┘
 * ```
 */                               
export function ObjectPropertyDisplay<T extends Object>(props: {
  object?: T,
  style?: ViewStyle,
}){

  const hasObject = props.object != null;

  const objectKeys = (hasObject
    ? Object.keys(props.object)
    : []
  ) as Array<keyof T>;

  return hasObject? (
    <View style={[
      styles.rootContainerBase, 
      styles.rootContainerWhenHasObject,
      props.style
    ]}>
      {objectKeys.map((objKey, index) => {
        const value = props.object[objKey];
        const isValueObj = (typeof value === 'object' && value !== null);

        return isValueObj?(
          <View key={`container-${objKey}-${index}`}>
            <Text 
              key={`label-${objKey}-${index}`}
              style={[styles.propertyLabelText, styles.propertyLabelObjectText]}
            >
              {`${objKey}: `}
            </Text>
            <ObjectPropertyDisplay
              key={`value-ObjectPropertyDisplay-${objKey}-${index}`}
              object={value}
              style={styles.objectPropertyDisplay}
            />
          </View>
        ):(
          <View 
            key={`container-${objKey}-${index}`}
            style={styles.rowContainer}
          >
            <Text 
              key={`label-${objKey}-${index}`}
              style={styles.propertyLabelText}
            >
              {`${objKey}: `}
            </Text>
            <Text 
              key={`value-${objKey}-${index}`}
              style={styles.propertyValueText}
            >
              {isValueObj? `...`: `'${props.object[objKey]}'`}
            </Text>
          </View>
        );
      })}
    </View>
  ):(
    <View style={[
      styles.rootContainerBase, 
      styles.rootContainerWhenEmptyObject, 
      props.style
    ]}>
      <Text style={styles.emptyObjectText}>
        {'Nothing to show'}
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainerBase: {
    marginTop: 12,
    paddingHorizontal: 12,
    paddingVertical: 10,
    backgroundColor: Colors.INDIGO[100],
    borderRadius: 10,
  },
  rootContainerWhenEmptyObject: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  rootContainerWhenHasObject: {
    flexDirection: 'column',
    paddingVertical: 5,
  },
  propertyLabelText: {
    flex: 1,
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1100],
    opacity: 0.75,
  },
  propertyLabelObjectText: {
    flex: 0,
  },
  propertyValueText: {
    fontSize: 16,
    fontWeight: '500',
    color: Colors.PURPLE[1100],
    opacity: 0.4,
  },
  objectPropertyDisplay: {
    marginTop: 0,
    paddingHorizontal: 7,
    paddingVertical: 5,
  },
  rowContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  emptyObjectText: {
    opacity: 0.75
  },
});