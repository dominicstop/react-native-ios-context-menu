import React from 'react';
import { StyleSheet, FlatList, View, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';

import * as Helpers from '../../functions/helpers';


function handleEvent(that, event){
  const date = new Date();

  const h = Helpers.pad(date.getHours  ());
  const m = Helpers.pad(date.getMinutes());
  const s = Helpers.pad(date.getSeconds());

  const ms = Helpers.pad(date.getMilliseconds(), 3);
  
  that.setState((prevState) => ({
    events: [{
      timestamp: `${h}:${m}:${s}.${ms}`,
      type: event
    }, ...prevState.events]
  }));
};

export class ContextMenuViewTest05 extends React.PureComponent {
  constructor(props){
    super(props);

    this.state = {
      events: [],
    };
  };

  _renderItem = ({item, index}) => {
    const { events } = this.state;
    const eventCount = events.length;

    return (
      <View>
        <Text>
          {`${Helpers.pad(eventCount - index, 3)} - ${item.timestamp} - `}
          <Text style={{fontWeight: 'bold'}}>
            {item.type}
          </Text>
        </Text>
      </View>
    );
  };

  render(){
    const state = this.state;

    return(
      <ExampleContextMenuItem
        {...this.props}
        style={styles.exampleContextMenu}
        title={'Test #5'}
        subtitle={'context menu events'}
        desc={`Test for logging the menu events`}
        // `ContextMenuView` Props
        onMenuWillShow    ={() => handleEvent(this, 'onMenuWillShow'    )}
        onMenuWillHide    ={() => handleEvent(this, 'onMenuWillHide'    )}
        onMenuWillCancel  ={() => handleEvent(this, 'onMenuWillCancel'  )}
        onMenuDidShow     ={() => handleEvent(this, 'onMenuDidShow'     )}
        onMenuDidHide     ={() => handleEvent(this, 'onMenuDidHide'     )}
        onMenuDidCancel   ={() => handleEvent(this, 'onMenuDidCancel'   )}
        onPressMenuItem   ={() => handleEvent(this, 'onPressMenuItem'   )}
        onPressMenuPreview={() => handleEvent(this, 'onPressMenuPreview')}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest05',
          menuItems: [{
            actionKey  : 'key-01',
            actionTitle: 'Action #1',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'folder',
            }
          }, {
            actionKey  : 'key-02'   ,
            actionTitle: 'Action #2',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'dial.fill',
            }
          }, {
            actionKey  : 'key-03'   ,
            actionTitle: 'Action #3',
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'archivebox.fill',
            }
          }],
        }}
      >
        <FlatList 
          style={styles.scrollview}
          data={state.events}
          renderItem={this._renderItem}
          keyExtractor={item => item.timestamp}
        />
      </ExampleContextMenuItem>
    );
  };
};

const styles = StyleSheet.create({
  exampleContextMenu: {

  },
  scrollview: {
    flex: 1,
    height: 100,
    marginTop: 7,
  },
});