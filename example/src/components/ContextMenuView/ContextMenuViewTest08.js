import React, { useState, useRef } from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewTest08 extends React.PureComponent {
  constructor(props){
    super(props);

    this.timer = null;

    this.state = {
      counter: 0,
    };
  };

  componentWillUnmount() {
    this.resetTimer();
  };

  startTimer = () => {
    this.timer = setInterval(() => {
      const { counter } = this.state;
      if (counter < 3){
        this.setState(prevState => ({
          counter: (prevState.counter + 1)
        }));

      } else {
        const ref = this.contexMenuItemRef.getContextMenuRef()
        ref.dismissMenu();
        this.resetTimer();
      };
    }, 500);
  };

  resetTimer = () => {
    if(this.timer){
      clearInterval(this.timer);
      this.setState({ counter: 0 });
    };
  };

  render(){
    return (
      <ExampleContextMenuItem
        {...this.props}
        ref={r => this.contexMenuItemRef = r}
        title={'Test #8'}
        subtitle={'dismiss menu'}
        desc={`Test for programatically dismissing the menu.`}
        // `ContextMenuView` Props
        previewConfig={{
          previewType: 'CUSTOM',
          backgroundColor: 'white'
        }}
        renderPreview={() => (
          <View style={{ padding: 20 }}>
            <Text style={{fontSize: 32}}>
              {`Will Dismiss in: ${3 - this.state.counter}`}
            </Text>
          </View>
        )}
        onMenuDidShow={() => this.startTimer()}
        onMenuDidHide={() => this.resetTimer()}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest08',
        }}
      />
    );
  };
};

const styles = StyleSheet.create({
});