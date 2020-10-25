import React from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';
import Proptypes from 'prop-types';

import * as Colors from '../constants/Colors';

import { ContextMenuView } from 'react-native-ios-context-menu';

function ContextMenuContent(props){
  const titleContainerStyle = {
    backgroundColor: (props.menuVisible
      ? Colors.PURPLE.A700
      : Colors.BLUE  .A700
    )
  };

  const subtitleContainerStyle = {
    backgroundColor: (props.menuVisible
      ? Colors.PURPLE[100]
      : Colors.BLUE  [100]
    )
  };

  return (
    <React.Fragment>
      <View style={[styles.titleContainer, titleContainerStyle]}>
        <Text style={styles.textTitleIndex}>
          {`${props.index ?? 0}. `}
        </Text>
        <Text style={styles.textTitle}>
          {props.title ?? 'N/A'}
          {props.subtitle && (
            <Text style={styles.textSubtitle}>
              {` (${props.subtitle})`}
            </Text>
          )}
        </Text>
      </View>
      <View style={[styles.subtitleContainer, subtitleContainerStyle]}>
        <Text style={styles.textDescription}>
          <Text style={styles.textDescriptionLabel}>
            {'Description: '}
          </Text>
          {props.desc ?? "N/A"}
        </Text>
        {props.children}
      </View>
    </React.Fragment>
  );
};


export class ExampleContextMenuItem extends React.Component {
  static proptypes = {
    title   : Proptypes.string,
    subtitle: Proptypes.string,
    desc    : Proptypes.string,
    index   : Proptypes.number,
  };

  render(){
    const { title, subtitle, desc, index, style, ...props } = this.props;

    return(
      <ContextMenuView 
        style={[styles.rootContainer, style]}
        {...props}
      >
       <ContextMenuContent
         {...{title, subtitle, desc, index}}
       />
      </ContextMenuView>
    );
  };
};

const styles = StyleSheet.create({
  rootContainer: {
    borderRadius: 10,
    margin: 20,
    overflow: 'hidden',
  },
  titleContainer: {
    flexDirection: 'row',
    paddingHorizontal: 15,
    paddingVertical: 8,
    alignItems: 'center',
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
    color: Colors.BLUE[1100],
    fontWeight: 'bold',
  },
});