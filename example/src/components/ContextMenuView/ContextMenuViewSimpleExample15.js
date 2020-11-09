import React from 'react';
import { StyleSheet, View, Text, findNodeHandle } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export class ContextMenuViewSimpleExample15 extends React.PureComponent {
  constructor(props){
    super(props);

    this.state = {
      targetViewNode: null,
    };
  };

  componentDidMount(){
    this.setState({
      targetViewNode: findNodeHandle(this.viewRef)
    });
  };

  render(){
    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Simple Example #15'}
        subtitle={'Preview Target'}
        desc={`Example context menu with a specific preview target`}
        // `ContextMenuView` Props
        previewConfig={{
          targetViewNode: this.state.targetViewNode,
        }}
        menuConfig={{
          menuTitle: 'ContextMenuViewSimpleExample15',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
          }],
        }}
      >
        <View
          style={styles.targetContainer}
          ref={r => this.viewRef = r}
        >
          <Text style={styles.text}>
            {`Hello! Target Node: ${this.state.targetViewNode}`}
          </Text>
        </View>
      </ExampleContextMenuItem>
    );
  };
};

const styles = StyleSheet.create({
  targetContainer: {
    backgroundColor: 'rgba(255,255,255,0.5)',
    alignSelf: 'flex-start',
    padding: 10,
    borderRadius: 10,
    marginTop: 10,
  },
  text: {
    fontSize: 16,
  }
});