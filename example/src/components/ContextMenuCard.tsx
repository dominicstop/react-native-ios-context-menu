import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { useMenuContext } from 'react-native-ios-context-menu';

import * as Colors from '../constants/Colors';


export function ContextMenuCard(props: {
  index?: number;
  title?: string;
  subtitle?: string;
  description?: string[];
  children?: JSX.Element[];

}) {
  const menuContext = useMenuContext();

  const titleContainerStyle = {
    backgroundColor: (menuContext.isMenuVisible
      ? Colors.PURPLE.A700
      : Colors.BLUE  .A700
    )
  };

  const bodyContainerStyle = {
    backgroundColor: (menuContext.isMenuVisible
      ? Colors.PURPLE[100]
      : Colors.BLUE  [100]
    )
  };

  const descriptionMain = props.description?.[0];
  const descriptionSub  = props.description?.slice(1);

  return (
    <View style={styles.rootContainer}>
      <View style={[styles.headerContainer, titleContainerStyle]}>
        <Text style={styles.headerTitleIndexText}>
            {`${props.index ?? 0}. `}
          </Text>
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitleText}>
            {props.title ?? 'N/A'}
          </Text>
          {props.subtitle && (
            <Text style={styles.headerSubtitleText}>
              {props.subtitle}
            </Text>
          )}
        </View>
      </View>
      <View style={[styles.bodyContainer, bodyContainerStyle]}>
        {descriptionMain && (
          <Text style={styles.bodyDescriptionText}>
            <Text style={styles.bodyDescriptionLabelText}>
              {'Description: '}
            </Text>
            {descriptionMain}
          </Text>
        )}
        {descriptionSub?.map((description, index) => (
          <Text 
            key={`desc-${index}`}
            style={[styles.bodyDescriptionText, styles.bodyDescriptionSubText]}
          >
            {description}
          </Text>
        ))}
        {props.children}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainer: {
    borderRadius: 10,
    overflow: 'hidden',
  },
  headerContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 15,
    paddingVertical: 8,
  },
  headerTitleContainer: {
    marginLeft: 5,
  },
  headerTitleText: {
    flex: 1,
    fontSize: 16,
    fontWeight: '700',
    color: 'white',
  },
  headerTitleIndexText: {
    fontSize: 16,
    fontWeight: '800',
    color: 'rgba(255,255,255,0.75)',
  },
  headerSubtitleText: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.75)',
    fontWeight: '300',
  },
  bodyContainer: {
    paddingHorizontal: 12,
    paddingTop: 7,
    paddingBottom: 10,
  },
  bodyDescriptionText: {
    fontWeight: '300',
    color: 'rgba(0,0,0,0.75)'
  },
  bodyDescriptionLabelText: {
    color: Colors.BLUE[1100],
    fontWeight: 'bold',
  },
  bodyDescriptionSubText: {
    marginTop: 10,
  },
});
