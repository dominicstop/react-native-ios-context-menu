import React from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';
import Proptypes from 'prop-types';

import * as Colors from '../constants/Colors';

import { ContextMenuButton } from 'react-native-ios-context-menu';


export class ExampleContextMenuButtonItem extends React.Component {
  static proptypes = {
    title      : Proptypes.string,
    subtitle   : Proptypes.string,
    desc       : Proptypes.string,
    index      : Proptypes.number,
    buttonTitle: Proptypes.string,
  };

  render(){
    const { title, subtitle, desc, index,  buttonTitle, children, ...props } = this.props;

    return(
      <View style={styles.rootContainer}>
        <View style={styles.titleContainer}>
          <Text style={styles.textTitleIndex}>
            {`${index ?? 0}. `}
          </Text>
          <Text style={styles.textTitle}>
            {title ?? 'N/A'}
            {subtitle && (
              <Text style={styles.textSubtitle}>
                {` (${subtitle})`}
              </Text>
            )}
          </Text>
        </View>
        <View style={styles.subtitleContainer}>
          <Text style={styles.textDescription}>
            <Text style={styles.textDescriptionLabel}>
              {'Description: '}
            </Text>
            {desc ?? "N/A"}
          </Text>
          {children}
        </View>
        <View style={styles.buttonContainer}>
          <ContextMenuButton
            style={styles.contextMenuButtonA}
            {...props}
          >
            <Text style={styles.textContextMenuButtonA}>
              {buttonTitle ?? '⭐️ Context Menu Button'}
            </Text>
          </ContextMenuButton>
          <ContextMenuButton
            style={styles.contextMenuButtonB}
            {...props}
          >
            <Text style={styles.textContextMenuButtonB}>
              {'⭐️'}
            </Text>
          </ContextMenuButton>
        </View>
      </View>
    );
  };
};

const styles = StyleSheet.create({
  rootContainer: {
    borderRadius: 10,
    margin: 20,
    overflow: 'hidden',
    backgroundColor: Colors.AMBER[50]
  },
  titleContainer: {
    flexDirection: 'row',
    paddingHorizontal: 15,
    paddingVertical: 8,
    alignItems: 'center',
    backgroundColor: Colors.AMBER.A700
  },
  textTitle: {
    fontSize: 17,
    fontWeight: '700',
    color: 'white',
    marginLeft: 2,
  },
  textTitleIndex: {
    fontSize: 17,
    fontWeight: '700',
    color: 'rgba(255,255,255,0.75)',
  },
  textSubtitle: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.75)',
    fontWeight: '300',
  },
  subtitleContainer: {
    paddingHorizontal: 15,
    paddingVertical: 10,
  },
  textDescription: {
    fontWeight: '300',
    color: 'rgba(0,0,0,0.75)'
  },
  textDescriptionLabel: {
    color: Colors.AMBER[1100],
    fontWeight: 'bold',
  },
  buttonContainer: {
    flexDirection: 'row',
    margin: 10,
  },
  contextMenuButtonA: {
    flex: 1,
    padding: 10,
    backgroundColor: Colors.ORANGE.A700,
    borderRadius: 10,
  },
  textContextMenuButtonA: {
    color: 'white',
    fontWeight: '500'
  },
  contextMenuButtonB: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 10,
    marginLeft: 10,
    backgroundColor: Colors.ORANGE.A700,
    borderRadius: 10,

  },
  textContextMenuButtonB: {

  },
});