import React from 'react';
import { StyleSheet, View, Text, Image } from 'react-native';
import Proptypes from 'prop-types';

import * as Colors from '../constants/Colors';

import { ContextMenuButton } from 'react-native-ios-context-menu';


function ContextMenuButtonContents(props){
  const rootContainerStyle = {
    backgroundColor: (props.menuVisible
      ? Colors.AMBER .A700
      : Colors.ORANGE.A700
    )
  };

  return (
    <View style={[styles.contextMenuButtonContentsContainer, rootContainerStyle]}>
      <Text style={styles.textContextMenuButton}>
        {props.buttonTitle}
      </Text>
    </View>
  );
};

export class ExampleContextMenuButtonItem extends React.Component {
  static proptypes = {
    title      : Proptypes.string,
    subtitle   : Proptypes.string,
    desc       : Proptypes.string,
    index      : Proptypes.number,
    buttonTitle: Proptypes.string,
    showButton : Proptypes.bool  ,
  };

  static defaultProps = {
    showButton: true,
  };

  render(){
    const { title, subtitle, desc, index,  buttonTitle, showButton, children, ...props } = this.props;

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
        {showButton && (
          <View style={styles.buttonContainer}>
            <ContextMenuButton
              style={styles.contextMenuButtonA}
              {...props}
            >
              <ContextMenuButtonContents
                buttonTitle={buttonTitle ?? '⭐️ Context Menu Button'}
              />
            </ContextMenuButton>
            <ContextMenuButton
              style={styles.contextMenuButtonB}
              {...props}
            >
              <ContextMenuButtonContents
                buttonTitle={'⭐️'}
              />
            </ContextMenuButton>
          </View>
        )}
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
  },
  contextMenuButtonB: {
    alignItems: 'center',
    justifyContent: 'center',
    marginLeft: 10,
  },
  contextMenuButtonContentsContainer: {
    padding: 10,
    borderRadius: 10,
  },
  textContextMenuButton: {
    color: 'white',
    fontWeight: '500'
  },
});