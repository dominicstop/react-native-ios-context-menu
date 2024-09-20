import * as React from 'react';
import { StyleSheet, type ViewStyle, View, Text } from 'react-native';


type BaseProps = {
  isMe: boolean;
  style?: ViewStyle;
};

type Props = 
  BaseProps & React.PropsWithChildren 

export function MessageBubbleAuxPreview(props: Props){

  const rootContainerStyle: ViewStyle = {
  };

  return (
    <View style={styles.rootContainer}>
      <Text>
        {'Hello World, Lorum ipsum sit amit dolor'}
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  rootContainer: {
    flex: 0,
    borderRadius: 10,
    overflow: 'hidden',
    paddingHorizontal: 10,
    paddingVertical: 10,
    backgroundColor: 'rgba(255,255,255,0.75)',
    alignItems: 'center',
  },
});


