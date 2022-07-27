/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';
import { View, StyleSheet, Text, FlatList, SafeAreaView, ListRenderItem, KeyboardAvoidingView, TextInput, TouchableOpacity } from 'react-native';

import { ContextMenuView, MenuElementConfig } from 'react-native-ios-context-menu';

import * as Colors  from '../constants/Colors';
//import * as Helpers from '../functions/Helpers';


// Repro for issue #XX

type Message = {
  messageText: string;
  isSender: boolean;
};

const DATA: Message[] = [{
  messageText: 'Hello World',
  isSender: false,
}, {
  messageText: 'Lorum ipsum sit amit dolor aspicing',
  isSender: true,
}, {
  messageText: 'Hello, how are you?',
  isSender: false,
}, {
  messageText: 'lights, camera, action, pose!',
  isSender: false,
}, {
  messageText: 'stan loona, yass kweeeeen',
  isSender: true,
}, {
  messageText: 'its giving... taste??? we love to see it',
  isSender: true,
}, {
  messageText: 'true lmao',
  isSender: false,
}, {
  messageText: "i'm also a indie h0e + bedroom pop btch btw",
  isSender: false,
}, {
  messageText: "asdfghjklfghjkl omg same!!",
  isSender: true,
}, {
  messageText: "have you listened to emails i can't send tho",
  isSender: true,
}, {
  messageText: "its giving olivia rodrigo but w/ a midlife crisis and a failing marriage",
  isSender: true,
}, {
  messageText: "love that for her tho",
  isSender: true,
}, {
  messageText: "okay but its a bop tho",
  isSender: false,
}, {
  messageText: "ik her rent was due and the crops were dying, "
   + "she really gave it her all lmao",
  isSender: false,
}, {
  messageText: "please 😭",
  isSender: true,
}, {
  messageText: "asdfghjkskdhaslkfjkl",
  isSender: true,
}, {
  messageText: "am i wrong tho",
  isSender: false,
}, {
  messageText: "anyways",
  isSender: false,
}, {
  messageText: "killer hybs is also pretty good",
  isSender: false,
}, {
  messageText: "love the intro",
  isSender: true,
}, {
  messageText: "forever a popstan girlie, but bedroom/indie pop hits differenty",
  isSender: true,
}, {
  messageText: "how very i'm not like other girls of u",
  isSender: false,
}, {
  messageText: "but tbh same",
  isSender: false,
}, {
  messageText: "2016-2017 era was basically niki, rex, mxmtoon, and mitski",
  isSender: false,
}, {
  messageText: "naurr the fact that they're not considered indie anymore tho",
  isSender: true,
}, {
  messageText: "well deserve popularity tho ✨",
  isSender: true,
},  {
  messageText: "sdafdghjksdsajlkjkl true",
  isSender: false,
}, {
  messageText: "is boy pablo and phum still considered indie?",
  isSender: false,
}, {
  messageText: "idk they have alot of streams, but did they chart in the top 100?",
  isSender: true,
}, {
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



export const Test03Screen = () => {

  const renderItem: ListRenderItem<Message> = ({ item }) => (
    <ContextMenuView 
      style={[styles.messageMenuContainer, {
        alignSelf: 
          item.isSender ? 'flex-end' : 'flex-start',
        backgroundColor: 
          item.isSender ? Colors.PURPLE[100] : Colors.ORANGE[100],
      }]}
      menuConfig={{
        menuTitle: '',
        menuItems: [
          MENU_CONFIGS.reply,
          MENU_CONFIGS.undo_send,
          MENU_CONFIGS.remove_reactions,
          MENU_CONFIGS.delete,
        ],
      }}
    >
      <Text style={styles.messageTextLabel}>
        {item.messageText}
      </Text>
    </ContextMenuView>
  );

  return (
    <SafeAreaView style={styles.rootContainer}>
      <FlatList
        style={styles.list}
        contentContainerStyle={styles.listContentContainer}
        data={DATA}
        renderItem={renderItem}
        keyExtractor={(_, index) => `${index}`}
      />
      <KeyboardAvoidingView 
        style={styles.bottomBarWrapper}
        behavior={'position'}
        keyboardVerticalOffset={60}
      >
        <View style={styles.bottomBarContainer}>
          <TextInput
            style={styles.messageBoxInput}
            placeholder={'Type your message...'}
          />
          <TouchableOpacity style={styles.sendButton}>
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
    marginBottom: 10,
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 10,
  },
  messageTextLabel: {
    maxWidth: '90%',
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
});