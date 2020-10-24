import React from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';
import Proptypes from 'prop-types';

import * as Colors from '../constants/Colors';

import { ContextMenuView } from 'react-native-ios-context-menu';


export class ExampleContextMenuItem extends React.Component {
  static proptypes = {
    title: Proptypes.string,
    desc : Proptypes.string,
    index: Proptypes.number,
  };

  render(){
    const { title, desc, index, style, ...props } = this.props;

    return(
      <ContextMenuView 
        style={[styles.rootContainer, style]}
        {...props}
      >
        <View style={styles.titleContainer}>
          <Text style={styles.textTitleIndex}>
            {`${index ?? 0}. `}
          </Text>
          <Text style={styles.textTitle}>
            {title ?? 'N/A'}
          </Text>
        </View>
        <View style={styles.subtitleContainer}>
          <Text style={styles.textSubtitle}>
            <Text style={styles.textSubtitleLabel}>
              {'Description: '}
            </Text>
            {desc ?? "N/A"}
          </Text>
          {props.children}
        </View>
      </ContextMenuView>
    );
  };
};

const styles = StyleSheet.create({
  rootContainer: {
    borderRadius: 10,
    margin: 20,
    overflow: 'hidden',
    backgroundColor: Colors.BLUE[100],
  },
  titleContainer: {
    flexDirection: 'row',
    paddingHorizontal: 15,
    paddingVertical: 8,
    alignItems: 'center',
    backgroundColor: Colors.BLUE.A700,
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
  subtitleContainer: {
    paddingHorizontal: 15,
    paddingVertical: 10,
  },
  textSubtitle: {
    fontWeight: '300',
    color: 'rgba(0,0,0,0.75)'
  },
  textSubtitleLabel: {
    color: Colors.BLUE[1100],
    fontWeight: 'bold',
  },
});