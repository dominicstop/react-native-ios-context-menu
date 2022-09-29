/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, Animated, Alert, StyleSheet, Text, FlatList, SafeAreaView, ListRenderItem, KeyboardAvoidingView, TextInput, TouchableOpacity } from 'react-native';

import { ContextMenuView, MenuElementConfig } from 'react-native-ios-context-menu';

import * as Colors  from '../constants/Colors';
import * as Helpers from '../functions/Helpers';


// Repro for issue:
// https://github.com/dominicstop/react-native-ios-context-menu/issues/47

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

type Message = {
  id: number;
  messageText: string;
  isSender: boolean;
};

let counterID = 0;
const MESSAGES_INITIAL: Message[] = [{
  id: counterID++,
  messageText: 'Hello World',
  isSender: false,
}, {
  id: counterID++,
  messageText: 'Lorum ipsum sit amit dolor aspicing',
  isSender: true,
}, {
  id: counterID++,
  messageText: 'Hello, how are you?',
  isSender: false,
}, {
  id: counterID++,
  messageText: 'lights, camera, action, pose!',
  isSender: false,
}, {
  id: counterID++,
  messageText: 'stan loona, yass kweeeeen',
  isSender: true,
}, {
  id: counterID++,
  messageText: 'its giving... taste??? we love to see it',
  isSender: true,
}, {
  id: counterID++,
  messageText: 'true lmao',
  isSender: false,
}, {
  id: counterID++,
  messageText: "i'm also a indie h0e + bedroom pop btch btw",
  isSender: false,
}, {
  id: counterID++,
  messageText: "asdfghjklfghjkl omg same!!",
  isSender: true,
}, {
  id: counterID++,
  messageText: "have you listened to emails i can't send tho",
  isSender: true,
}, {
  id: counterID++,
  messageText: "its giving olivia rodrigo but w/ a midlife crisis and a failing marriage",
  isSender: true,
}, {
  id: counterID++,
  messageText: "love that for her tho",
  isSender: true,
}, {
  id: counterID++,
  messageText: "okay but its a bop tho",
  isSender: false,
}, {
  id: counterID++,
  messageText: "ik her rent was due and the crops were dying, "
   + "she really gave it her all lmao",
  isSender: false,
}, {
  id: counterID++,
  messageText: "please 😭",
  isSender: true,
}, {
  id: counterID++,
  messageText: "asdfghjkskdhaslkfjkl",
  isSender: true,
}, {
  id: counterID++,
  messageText: "am i wrong tho",
  isSender: false,
}, {
  id: counterID++,
  messageText: "anyways",
  isSender: false,
}, {
  id: counterID++,
  messageText: "killer hybs is also pretty good",
  isSender: false,
}, {
  id: counterID++,
  messageText: "love the intro",
  isSender: true,
}, {
  id: counterID++,
  messageText: "forever a popstan girlie, but bedroom/indie pop hits differenty",
  isSender: true,
}, {
  id: counterID++,
  messageText: "how very i'm not like other girls of u",
  isSender: false,
}, {
  id: counterID++,
  messageText: "but tbh same",
  isSender: false,
}, {
  id: counterID++,
  messageText: "2016-2017 era was basically niki, rex, mxmtoon, and mitski",
  isSender: false,
}, {
  id: counterID++,
  messageText: "naurr the fact that they're not considered indie anymore tho",
  isSender: true,
}, {
  id: counterID++,
  messageText: "well deserve popularity tho ✨",
  isSender: true,
}, {
  id: counterID++,
  messageText: "sdafdghjksdsajlkjkl true",
  isSender: false,
}, {
  id: counterID++,
  messageText: "is boy pablo and phum still considered indie?",
  isSender: false,
}, {
  id: counterID++,
  messageText: "idk they have alot of streams, but did they chart in the top 100?",
  isSender: true,
}, {
  id: counterID++,
  messageText: "asdgfhjkldsfdjkl too lazy to look it up",
  isSender: true,
}];

const MENU_ITEM_KEYS = {
  reply: 'reply',
  undo_send: 'undo_send',
  remove_reactions: 'remove_reactions',
  delete: 'delete',
};

type MenuItemKeys = keyof typeof MENU_ITEM_KEYS;

const MENU_CONFIGS: Record<MenuItemKeys, MenuElementConfig> = {
  reply: {
    type: 'action',
    actionKey: MENU_ITEM_KEYS.reply,
    actionTitle: 'Reply',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'arrowshape.turn.up.left.2',
      },
    },
  },

  undo_send: {
    actionKey: MENU_ITEM_KEYS.undo_send,
    actionTitle: 'Undo Send',
    actionSubtitle: "gurl they might've seen it already tho...",
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'arrow.uturn.left',
      },
    }
  },

  remove_reactions: {
    actionKey: MENU_ITEM_KEYS.remove_reactions,
    actionTitle: 'Remove Reactions',
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'heart.slash',
      },
    }
  },

  delete: {
    actionKey: MENU_ITEM_KEYS.delete,
    actionTitle: 'Delete Message',
    menuAttributes: ['destructive'],
    icon: {
      type: 'IMAGE_SYSTEM',
      imageValue: {
        systemName: 'trash',
      },
    }
  },
};

const MessageBubble = (props: {
  message: Message;
  reactionMap: Record<string, ReactionKeys>;
  onPressReaction: (reactionKey: ReactionKeys) => void;
  setReaction: (reactionKey: ReactionKeys) => void;
  onPressDeleteMessage: () => void;
}) => {
  const currentReaction = props.reactionMap[props.message.id];
  const [currentVisibleReaction, setCurrentVisibleReaction] = React.useState<ReactionKeys>(null);
  
  const hasReaction = (currentReaction != null);

  const menuRef = React.useRef<ContextMenuView>();

  const animatedReactionOpacity = 
    React.useRef(new Animated.Value(0)).current;

  const animatedMessageContainerMarginTop = 
    React.useRef(new Animated.Value(0)).current;

  const animatedMessageContainerOpacity = 
    React.useRef(new Animated.Value(1)).current;

  const startFadeIn = () => {
    return new Promise(resolve => {
      Animated.timing(animatedReactionOpacity, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  const startFadeOut = () => {
    return new Promise(resolve => {
      Animated.timing(animatedReactionOpacity, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }).start(resolve);
    });
  };

  const startCollapse = () => {

    return Promise.all([
      new Promise(resolve => {
        Animated.timing(animatedMessageContainerMarginTop, {
          toValue: -100,
          duration: 500,
          useNativeDriver: false,
        }).start(resolve);
      }),
      new Promise(resolve => {
        Animated.timing(animatedMessageContainerOpacity, {
          toValue: 0,
          duration: 250,
          useNativeDriver: false,
        }).start(resolve);
      })
    ]);
  };

  const reactionIndicator = (
    <Animated.View style={[styles.messageReactionContainer, {
      marginRight: props.message.isSender? 5 : 0,
      marginLeft: props.message.isSender? 0 : 5,
    }, {
      opacity: animatedReactionOpacity,
    }]}>
      <Text style={styles.messageReactionLabel}>
        {REACTIONS_DICT[currentVisibleReaction]}
      </Text>
    </Animated.View>
  );

  return (
    <Animated.View style={[styles.messageMenuContainer, {
      marginTop: animatedMessageContainerMarginTop,
      opacity: animatedMessageContainerOpacity,
      alignSelf: (props.message.isSender 
        ? 'flex-end' 
        : 'flex-start'
      ),
    }]}>
      {(hasReaction && props.message.isSender) && reactionIndicator}
      <ContextMenuView
        ref={menuRef}
        style={[styles.messageBubbleContainer, {
          backgroundColor: (props.message.isSender 
            ? Colors.PURPLE[100] 
            : Colors.ORANGE[100]
          ),
        }]}
        menuConfig={{
          menuTitle: '',
          menuItems: [
            MENU_CONFIGS.reply,
            MENU_CONFIGS.undo_send,
            hasReaction && MENU_CONFIGS.remove_reactions,
            MENU_CONFIGS.delete,
          ],
        }}
        auxiliaryPreviewConfig={{
          alignmentHorizontal: (props.message.isSender 
            ? 'previewTrailing'
            : 'previewLeading' 
          ),
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
                  props.onPressReaction(reactionKey);
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
        onPressMenuItem={async ({nativeEvent}) => {
          switch(nativeEvent.actionKey){
            case MENU_ITEM_KEYS.remove_reactions:
              await startFadeOut();

              props.setReaction(null);
              setCurrentVisibleReaction(null);
              break;

            case MENU_ITEM_KEYS.delete:
              await startCollapse();
              props.onPressDeleteMessage();
              break;

            case MENU_ITEM_KEYS.undo_send:
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
              break;
          };
        }}
        onMenuDidHide={async () => {
          const didChangeReaction = (currentReaction !== currentVisibleReaction);

          // guard
          if(!didChangeReaction) return;

          (currentVisibleReaction != null) && await startFadeOut();
          setCurrentVisibleReaction(currentReaction);
          (currentReaction != null) && await startFadeIn();
        }}
      >
        <Text style={styles.messageTextLabel}>
          {props.message.messageText}
        </Text>
      </ContextMenuView>
      {(hasReaction && !props.message.isSender) && reactionIndicator}
    </Animated.View>
  );
};


export const Test03Screen = () => {
  let messageText = "";

  const [messages, setMessages] = React.useState(MESSAGES_INITIAL);

  const messageBoxInputRef = React.useRef<TextInput>(null);

  const [reactionMap, setReactionMap] = 
    React.useState<Record<string, ReactionKeys>>({});

  const renderItem: ListRenderItem<Message> = ({item}) => (
    <MessageBubble
      message={item}
      reactionMap={reactionMap}
      setReaction={(reactionKey) => {
        setReactionMap((prev) => {
          return ({
            ...prev,
            [item.id]: reactionKey,
          });
        });
      }}
      onPressReaction={(reactionKey) => {
        setReactionMap((prev) => {
          const prevReaction = prev[reactionKey];
          const didHavePrevReaction = prevReaction != null;

          return ({
            ...prev,
            [item.id]: didHavePrevReaction? null : reactionKey,
          });
        });
      }}
      onPressDeleteMessage={() => {
        setMessages(prev =>
         prev.filter(message => item.id !== message.id)
        );
      }}
    />
  );

  return (
    <SafeAreaView style={styles.rootContainer}>
      <FlatList
        style={styles.list}
        contentContainerStyle={styles.listContentContainer}
        data={messages}
        renderItem={renderItem}
        keyExtractor={(item) => `${item.id}`}
        scrollIndicatorInsets={{
          bottom: 45
        }}
      />
      <KeyboardAvoidingView 
        style={styles.bottomBarWrapper}
        behavior={'position'}
        keyboardVerticalOffset={65}
      >
        <View style={styles.bottomBarContainer}>
          <TextInput
            ref={messageBoxInputRef}
            style={styles.messageBoxInput}
            placeholder={'Type your message...'}
            onChangeText={(text) => {
              messageText = text;
            }}
          />
          <TouchableOpacity 
            style={styles.sendButton}
            onPress={() => {
              setMessages(prev => [...prev, {
                id: counterID++,
                messageText,
                isSender: true,
              }]);
              messageBoxInputRef.current?.clear();
            }}
          >
            <Text style={styles.sendButtonLabel}>
              Send
            </Text>
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  rootContainer: { 
    flex: 1,
  },
  list: {
    flex: 1,
  },
  bottomBarWrapper: {
    position: 'absolute',
    width: '100%',
    bottom: 0,
    backgroundColor: 'white',
    borderTopWidth: 0.75,
    borderTopColor: 'rgb(190,190,190)',
    shadowColor: 'black',
    shadowOpacity: 0.1,
    shadowRadius: 10,
    shadowOffset: {
      height: -5,
      width: 0,
    },
  },
  bottomBarContainer: {
    flexDirection: 'row',
    backgroundColor: 'white',
    paddingHorizontal: 15,
    paddingVertical: 12,
    
  },
  listContentContainer: {
    paddingTop: 10,
    paddingHorizontal: 10,
    paddingBottom: 90,
  },
  messageMenuContainer: {
    flexDirection: 'row',
    marginBottom: 10,
  },
  messageBubbleContainer: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 10,
    maxWidth: '90%',
  },
  messageTextLabel: {
  },
  messageBoxInput: {
    flex: 1,
    marginRight: 10,
  },
  sendButton: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  sendButtonLabel: {
    color: Colors.PURPLE.A700,
    fontWeight: '600',
  },
  auxRootContainer: {
    flexDirection: 'row',
    backgroundColor: 'white',
    borderRadius: 10,
    paddingHorizontal: 15,
    paddingVertical: 8,
    minWidth: 100,
  },
  auxPreviewreactionEmojiButton: {
  },
  auxPreviewReactionEmojiButtonSelected: {
    backgroundColor: Colors.BLUE[100],
    borderRadius: 7,
  },
  auxPreviewLabelReactionEmoji: {
    fontSize: 30,
  },
  messageReactionContainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  messageReactionLabel: {
    fontSize: 16,
  },
});