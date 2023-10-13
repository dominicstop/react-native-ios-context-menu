import * as React from 'react';
import { StyleSheet, TextInput } from 'react-native';

import * as Colors  from '../../constants/Colors';


export class CardRowTextInput extends React.PureComponent<{
  placeholder?: string
}> {
  
  state = {
    textInput: '',
  };

  getText = () => {
    return this.state.textInput;
  };

  _handleOnChangeText = (text: string) => {
    this.setState({textInput: text});
  };

  render(){
    const props = this.props;

    return(
      <TextInput
        style={styles.cardRowTextInput}
        onChangeText={this._handleOnChangeText}
        placeholder={props.placeholder}
        placeholderTextColor={Colors.INDIGO[300]}
      />
    );
  };
};

const styles = StyleSheet.create({
  cardRowTextInput: {
    backgroundColor: Colors.INDIGO[100],
    fontSize: 16,
    color: Colors.INDIGO[900],
    paddingHorizontal: 12,
    paddingVertical: 7,
    borderRadius: 10,
    marginTop: 12,
  },
});