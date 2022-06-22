/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { Alert, View, Text, StyleSheet, findNodeHandle, TouchableOpacity, Animated } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as COLORS  from '../constants/Colors';
import * as Helpers from '../functions/Helpers';


const MENU_ITEM_DICT = {
  reply: 'reply',
  remove_reactions: 'remove_reactions',
  undo_send: 'undo_send',
  delete: 'delete',
};

const REACTIONS_DICT = {
  like  : "👍",
  laugh : "😂",
  crying: "😭",
  sad   : "😔",
  heart : "💖",
  love  : "🥰",
};

type ReactionKeys = keyof typeof REACTIONS_DICT;

const REACTIONS_KEYS =
  Object.keys(REACTIONS_DICT) as ReactionKeys[];
  

export function ContextMenuAuxPreviewTest01(props: ContextMenuExampleProps) {
  const [targetViewNode, setTargetViewNode] = React.useState(null);

  const [currentReaction, setCurrentReaction] = React.useState<ReactionKeys>(null);
  const [currentVisibleReaction, setCurrentVisibleReaction] = React.useState<ReactionKeys>(null);

  const hasReaction = (currentVisibleReaction != null)

  const viewRef = React.useRef();
  const menuRef = React.useRef<ContextMenuView>();

  React.useEffect(() => {
    setTargetViewNode(
      findNodeHandle(viewRef.current)
    );
  }, []);

  const onPressReaction = React.useCallback((reactionKey: ReactionKeys) => {
    setCurrentReaction(prev => 
      prev === reactionKey? null : reactionKey
    );
  }, []);

  const fadeAnimation = 
    React.useRef(new Animated.Value(0)).current;

  const fadeIn = () => {
    return new Promise(resolve => {
      Animated.timing(fadeAnimation, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  const fadeOut = () => {
    return new Promise(resolve => {
      Animated.timing(fadeAnimation, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  return (
    <ContextMenuView
      style={props.style}
      ref={menuRef}
      shouldWaitForMenuToHideBeforeFiringOnPressMenuItem={false}
      menuConfig={{
        menuTitle: '',
        menuItems: [{
          actionKey: MENU_ITEM_DICT.reply,
          actionTitle: 'Reply',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'arrowshape.turn.up.left.2',
            },
          }
        }, {
          actionKey : MENU_ITEM_DICT.undo_send,
          actionTitle: 'Undo Send',
          actionSubtitle: "gurl they might've seen it already tho...",
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'arrow.uturn.left',
            },
          }
        }, currentReaction && {
          actionKey: MENU_ITEM_DICT.remove_reactions,
          actionTitle: 'Remove Reactions',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'heart.slash',
            },
            imageOptions: {
              renderingMode: 'alwaysOriginal',
              tint: 'red',
            },
          }
        }, {
          actionKey: MENU_ITEM_DICT.delete,
          actionTitle: 'Delete Message',
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }],
      }}
      previewConfig={{
        targetViewNode: targetViewNode,
      }}
      auxiliaryPreviewConfig={{
        alignmentHorizontal: 'previewLeading',
        transitionEntranceDelay: 'RECOMMENDED',
        transitionConfigEntrance: {
          transition: 'zoomAndSlide',
          zoomOffset: 0.1,
          slideOffset: 15,
          duration: 0.25,
          options: ['curveEaseInOut'],
        },
      }}
      renderAuxiliaryPreview={() => (
        <View style={styles.auxRootContainer}>
          {REACTIONS_KEYS.map((reactionKey, index) => (
            <TouchableOpacity
              key={`root-${reactionKey}`}
              style={[styles.auxPreviewreactionEmojiButton, {
                paddingHorizontal: (index === 0)? 0 : 5
              }, (currentReaction === reactionKey) && 
                styles.auxPreviewReactionEmojiButtonSelected
              ]}
              onPress={async () => {
                onPressReaction(reactionKey);
                await Helpers.timeout((currentReaction == null)? 550 : 200);
                menuRef.current.dismissMenu();
              }}
            >
              <Text style={styles.auxPreviewLabelReactionEmoji}>
                {REACTIONS_DICT[reactionKey]}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      )}
      onPressMenuItem={({nativeEvent}) => {
        switch(nativeEvent.actionKey){
          case MENU_ITEM_DICT.remove_reactions:
            setCurrentReaction(null);
            break;

          case MENU_ITEM_DICT.undo_send:
            Alert.alert(
              'naurrr',
              `the tea cannot be unspilled babes, sorry xoxo`
            );
            break;

          default:
            Alert.alert(
              'onPressMenuItem Event',
              `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
            );
        };

        
      }}
      onMenuDidHide={async () => {
        (currentVisibleReaction != null) && await fadeOut();
        setCurrentVisibleReaction(currentReaction);
        (currentReaction != null) && await fadeIn();
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewTest01'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Auxillary preview - message reactions demo`,
        ]}
      >
        <View style={styles.demoContainer}>
          <View style={styles.avatarContainer}>
            <Text style={styles.avatarText}>
              {'Bb'}
            </Text>
          </View>
          <View
            style={styles.messageContainer}
            ref={viewRef}
          >
            <Text style={styles.messageText}>
              {"ghorl the tea is piping hawt\nmy wig is in orbittttt"}
            </Text>
          </View>
          {hasReaction && (
            <Animated.View style={[styles.messageReactionContainer, {
              opacity: fadeAnimation,
            }]}>
              <Text style={styles.messageReactionLabel}>
                {REACTIONS_DICT[currentVisibleReaction]}
              </Text>
            </Animated.View>
          )}
        </View>
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer: {
    flexDirection: 'row',
    backgroundColor: 'white',
    borderRadius: 10,
    paddingHorizontal: 15,
    paddingVertical: 8,
  },
  demoContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 15,
  },
  messageContainer: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    paddingVertical: 10,
    paddingHorizontal: 15,
    borderRadius: 10,
    marginLeft: 10,
  },
  messageText: {
    fontSize: 14,
    fontWeight: '300',
  },
  auxPreviewreactionEmojiButton: {
  },
  auxPreviewReactionEmojiButtonSelected: {
    backgroundColor: COLORS.BLUE[100],
    borderRadius: 7,
  },
  auxPreviewLabelReactionEmoji: {
    fontSize: 30,
  },
  messageReactionContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    marginLeft: 10,
  },
  messageReactionLabel: {
    fontSize: 32,
  },
  avatarContainer: {
    width: 45,
    height: 45,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: COLORS.PURPLE[100],
    borderRadius: 45/2,
  },
  avatarText: {
    color: COLORS.PURPLE[900],
    fontWeight: '500',
  },
});