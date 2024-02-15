import * as React from 'react';
import { StyleSheet, ViewStyle, View, Text } from 'react-native';

import Animated from 'react-native-reanimated';
import { useSharedValue, withSpring, useAnimatedStyle } from 'react-native-reanimated';


type BaseProps = {
  isMe: boolean;
  style?: ViewStyle;
};

type Props = 
  BaseProps & React.PropsWithChildren 

export function MessageBubbleAuxPreview(props: Props){
  const scale = useSharedValue(1);

  const [shouldScale, setShouldScale] = React.useState(false);

  const animatedStyles = useAnimatedStyle(() => ({
    transform: [
      { scaleX: withSpring(scale.value) }, 
      { scaleY: withSpring(scale.value) },
    ],
  }));

  return (
    <View style={styles.rootContainer}>
      <Animated.Text
        style={animatedStyles}
        onPress={() => {
          const scaleValue = shouldScale ? 0.75 : 1;
          setShouldScale(prevValue => !prevValue);
          scale.value = withSpring(scaleValue);
        }}
      >
        {'Hello World, Lorum ipsum sit amit dolor'}
      </Animated.Text>
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


