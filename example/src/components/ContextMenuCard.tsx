import * as React from 'react';
import { StyleSheet, View, Text, type ViewStyle, type TextStyle } from 'react-native';

import { Colors } from 'react-native-ios-utilities';
import { ContextMenuViewContext } from 'react-native-ios-context-menu';


export type ColorConfig = {
  headerBGColorActive  : string;
  headerBGColorInactive: string;

  bodyBGColorActive  : string;
  bodyBGColorInactive: string;

  bodyDescriptionLabelColor: string;
};

export type ContextMenuCardProps = {
  index?: number;
  title?: string;
  subtitle?: string;
  description?: string[];
  colorConfig?: ColorConfig,

  style?: ViewStyle;
  extraContentContainerStyle?: ViewStyle;
  children?: JSX.Element | JSX.Element[];
};

const defaultColorConfig: ColorConfig = {
  headerBGColorActive  : Colors.PURPLE.A700,
  headerBGColorInactive: Colors.BLUE  .A700,

  bodyBGColorActive  : Colors.PURPLE[100],
  bodyBGColorInactive: Colors.BLUE  [100],

  bodyDescriptionLabelColor: Colors.BLUE[1100],
};

export function ContextMenuCard(props: ContextMenuCardProps) {
  const menuContext = React.useContext(ContextMenuViewContext);

  const descriptionMain = props.description?.[0];
  const descriptionSub  = props.description?.slice(1);

  const colorConfig = props.colorConfig ?? defaultColorConfig;

  const headerContainerStyle: ViewStyle = {
    backgroundColor: (menuContext.isMenuVisible
      ? colorConfig.headerBGColorActive
      : colorConfig.headerBGColorInactive
    )
  };

  const bodyContainerStyle: ViewStyle = {
    backgroundColor: (menuContext.isMenuVisible
      ? colorConfig.bodyBGColorActive
      : colorConfig.bodyBGColorInactive
    )
  };

  const bodyDescriptionLabelTextStyle: TextStyle = {
    color: colorConfig.bodyDescriptionLabelColor,
  };

  const shouldShowHeaderTitleIndex = props.index != null;
  const isTitleOnly = props.subtitle == null;

  const headerTitleTextStyle: TextStyle = {
    ...(isTitleOnly && {
      fontSize: 16,
    }),
  };

  const titleAndSubtitleElement = (
    <React.Fragment>
      <Text style={[styles.headerTitleText, headerTitleTextStyle]}>
        {props.title ?? 'N/A'}
      </Text>
      {props.subtitle && (
        <Text style={styles.headerSubtitleText}>
          {props.subtitle}
        </Text>
      )}
    </React.Fragment>
  );

  return (
    <View style={[styles.rootContainer, props.style]}>
      <View style={[styles.headerContainer, headerContainerStyle]}>
        {shouldShowHeaderTitleIndex ? (
          <React.Fragment>
            <Text style={styles.headerTitleIndexText}>
              {`${props.index!}. `}
            </Text>
            <View style={styles.headerTitleContainer}>
              {titleAndSubtitleElement}
            </View>
          </React.Fragment>
        ) : (
          titleAndSubtitleElement
        )}
      </View>
      <View style={[styles.bodyContainer, bodyContainerStyle]}>
        {descriptionMain && (
          <Text style={styles.bodyDescriptionText}>
            <Text style={[styles.bodyDescriptionLabelText, bodyDescriptionLabelTextStyle]}>
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
        {(React.Children.count(props.children) > 0) && (
          <View style={props.extraContentContainerStyle}>
            {props.children}
          </View>
        )}
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
    fontWeight: '600',
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
    fontWeight: 'bold',
  },
  bodyDescriptionSubText: {
    marginTop: 10,
  },
});
