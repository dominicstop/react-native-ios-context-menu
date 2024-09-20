
import * as React from 'react';
import { Alert, View, Text, StyleSheet } from 'react-native';

import { Helpers, CardButton } from 'react-native-ios-utilities';
import { ContextMenuView } from 'react-native-ios-context-menu';

import { ContextMenuCard } from '../components/ContextMenuCard';
import type { ExampleItemProps } from './SharedExampleTypes';


export function ContextMenuAuxPreviewExample16(props: ExampleItemProps) {
  const menuRef = React.useRef<ContextMenuView>(null);
  
  return (
    <ContextMenuView
      ref={menuRef}
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuAuxPreviewExample05',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Lorum ipsum',
        }],
      }}
      auxiliaryPreviewConfig={{
        alignmentHorizontal: 'previewCenter',
        transitionEntranceDelay: 'RECOMMENDED',
        height: 100,
        width: 150,
      }}
      renderAuxiliaryPreview={() => (
        <View style={[styles.auxRootContainer, {
          flex: 1,
          alignItems: 'center',
          justifyContent: 'center',
        }]}>
          <Text style={styles.textLabel}>
            Center
          </Text>
        </View>
      )}
      onPressMenuItem={({nativeEvent}) => {
        Alert.alert(
          'onPressMenuItem Event',
          `actionKey: ${nativeEvent.actionKey} - actionTitle: ${nativeEvent.actionTitle}`
        );
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuAuxPreviewExample16'}
        subtitle={'EXPERIMENTAL - Aux. Preview'}
        description={[
          `Programmatically show the sux. preview as a popover`
        ]}
      >
        <CardButton
          title={'Show Aux. Preview as Popover'}
          subtitle={'Programmatically shows the aux. preview'}
          onPress={async () => {
            await Helpers.timeout(100);
            menuRef.current?.showAuxiliaryPreviewAsPopover();
          }}
        />
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  auxRootContainer: {
    backgroundColor: 'white',
    borderRadius: 10,
    padding: 10,
  },
  textLabel: {
      fontSize: 18,
    fontWeight: '600',
    color: 'black',
  },
});