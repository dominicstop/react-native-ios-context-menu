import React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


export function ContextMenuViewSimpleExample14(props) {

  return(
    <ExampleContextMenuItem
      {...props}
      title={'Simple Example #14'}
      subtitle={'Custom Preview'}
      desc={`Show a custom preview for the context menu with the "preferredCommitStyle" property in the "PreviewConfig" prop set to "pop"`}
      // `ContextMenuView` Props
      previewConfig={{
        previewType: 'CUSTOM',
        previewSize: 'STRETCH',
        backgroundColor: 'rgba(255,255,255,0.75)',
        preferredCommitStyle: 'pop',
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
        menuTitle: 'ContextMenuViewSimpleExample14',
      }}
    />
  );
};

const styles = StyleSheet.create({
});