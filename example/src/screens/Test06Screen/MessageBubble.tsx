import * as React from 'react';
import { StyleSheet, type ViewStyle } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';
import { MessageBubbleAuxPreview } from './MessageBubbleAuxPreview';

type BaseProps = {
  isMe: boolean;
  style?: ViewStyle;
};

type Props = 
  BaseProps & React.PropsWithChildren 

export function MessageBubble(props: Props){

  const rootContainerStyle: ViewStyle = {
    backgroundColor: (props.isMe
      ? 'rgb(255,227,227)'
      : 'rgb(227,230,255)'
    ),
    alignSelf: (props.isMe
      ? 'flex-start'
      : 'flex-end'
    ),
  };

  return (
    <ContextMenuView 
      style={[
        styles.rootContainer,
        rootContainerStyle,
        props.style
      ]}
      menuConfig={{
        menuTitle: '',
        menuItems: [{
          actionKey: 'action-like',
          actionTitle: 'Like',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'heart.fill',
            },
            imageOptions: {
              tint: 'red',
              renderingMode: 'alwaysOriginal',
            },
          }
        }],
      }}
      onPressMenuItem={({nativeEvent}) => {
        switch(nativeEvent.actionKey) {
          case "action-like":
            break;
        };
      }}
      auxiliaryPreviewConfig={{
        verticalAnchorPosition: 'automatic',
        horizontalAlignment: (props.isMe
          ? 'targetLeading' 
          : 'targetTrailing'
        ),
        marginVerticalInner: 10,
        transitionConfigEntrance: {
          mode: 'syncedToMenuEntranceTransition',
          shouldAnimateSize: true,
        },
        transitionExitPreset: {
          mode: 'zoomAndSlide',
          zoomOffset: 0.8,
          slideOffset: 20,
        },
      }}
      renderAuxiliaryPreview={() => (
        <MessageBubbleAuxPreview
          isMe={props.isMe}
        />
      )}
    >
      {props.children}
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  rootContainer: {
    flex: 0,
    borderRadius: 10,
    overflow: 'hidden',
    paddingHorizontal: 10,
    paddingVertical: 10,
    marginBottom: 12,
  },
});


