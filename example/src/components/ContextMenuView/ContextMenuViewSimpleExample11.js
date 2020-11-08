import React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample11(props) {

  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #11'}
      subtitle={'Custom Preview'}
      desc={`Show a custom preview for the context menu.`}
      // `ContextMenuView` Props
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'white'
      }}
      renderPreview={() => (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
          <Text style={{fontSize: 32}}>
            Hello World
          </Text>
        </View>
      )}
      menuConfig={{
        menuTitle: 'ContextMenuViewSimpleExample11',
      }}
    />
  );
};

const styles = StyleSheet.create({
});