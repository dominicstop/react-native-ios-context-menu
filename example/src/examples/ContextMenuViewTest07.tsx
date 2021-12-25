import * as React from 'react';
import { StyleSheet, View, Text, Switch, findNodeHandle } from 'react-native';

import { ContextMenuView, MenuPreviewConfig } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewTest07(props: ContextMenuExampleProps) {
  const [counter, setCounter] = React.useState(0);
  const [targetViewNode, setTargetViewNode] = React.useState(null);

  const [isResizeAnimated, setIsResizeAnimated] = React.useState(false);
  const [togglePreviewType, setTogglePreviewType] = React.useState(false);
  const [togglePreviewSize, setTogglePreviewSize] = React.useState(false);
  const [toggleBgTransparent, setToggleBgTransparent] = React.useState(false);
  const [toggleTargetViewNode, setToggleTargetViewNode] = React.useState(false);
  const [togglePreferredCommitStyle, setTogglePreferredCommitStyle] = React.useState(false);

  const intervalRef = React.useRef<NodeJS.Timer | undefined>();

  React.useEffect(() => {
    return () => {
      if(!intervalRef.current) return;
      clearInterval(intervalRef.current);
    };
  }, []);

  const previewConfig: MenuPreviewConfig = {
    previewType: 
      (togglePreviewType? 'CUSTOM' : 'DEFAULT'),

    previewSize: 
      (togglePreviewSize? 'STRETCH' : 'INHERIT'),

    preferredCommitStyle: 
      (togglePreferredCommitStyle? 'pop' : 'dismiss'),

    backgroundColor: 
      (toggleBgTransparent ? 'white' :  'rgba(255,255,255,0.5)'),

    isResizeAnimated,
    ...(toggleTargetViewNode && { 
      targetViewNode 
    }),
  };

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest07',
        menuItems: [{
          actionKey  : 'add',
          actionTitle: `Add 100`,
          discoverabilityTitle: `Current counter: ${counter}`,
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'plus',
            },
          }
        }, 
        (counter > 0) && {
          actionKey     : 'reset',
          actionTitle   : `Reset Counter`,
          menuAttributes: ['destructive'],
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'trash',
            },
          }
        }],
      }}
      previewConfig={previewConfig}
      renderPreview={() => (
        <View style={[styles.previewContainer]}>
          <Text style={styles.previewTitleText}>
            {'Hello World'}
          </Text>
          {(counter % 2 === 0) && (
            <Text style={styles.previewCounterText}>
              {`Counter: ${counter}`}
            </Text>
          )}
        </View>
      )}
      onMenuWillShow={() => {
        intervalRef.current = setInterval(() => {
          setCounter((prevValue) => (prevValue + 1));
        }, 1000);
      }}
      onMenuWillHide={() => {
        if(!intervalRef.current) return;
        clearInterval(intervalRef.current);
      }}
      onPressMenuItem={({nativeEvent}) => {
        switch (nativeEvent.actionKey) {
          case 'add':
            setCounter((prevValue) => (prevValue + 100));
            break;

          case 'reset':
            setCounter(0);
            break;
        };
      }}
      >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest07'}
        subtitle={'Custom Preview'}
        description={[
          `Test for the different possible custom menu preview config`
        ]}
      >
        {toggleTargetViewNode && (
          <View
            style={styles.targetViewContainer}
            ref={ref => {
              setTargetViewNode(
                findNodeHandle(ref)
              );
            }}
          >
            <Text style={styles.targetViewText}>
              {'Target View'}
            </Text>
          </View>
        )}
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'previewType'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.previewType}
            </Text>
          </View>
          <Switch
            value={togglePreviewType}
            onValueChange={(flag) => {
              setTogglePreviewType(flag);
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'previewSize'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.previewSize}
            </Text>
          </View>
          <Switch
            value={togglePreviewSize}
            onValueChange={(flag) => {
              setTogglePreviewSize(flag);
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'backgroundColor'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.backgroundColor}
            </Text>
          </View>
          <Switch
            value={toggleBgTransparent}
            onValueChange={(flag) => {
              setToggleBgTransparent(flag);
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'isResizeAnimated'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.isResizeAnimated? 'true' : 'false'}
            </Text>
          </View>
          <Switch
            value={isResizeAnimated}
            onValueChange={(flag) => {
              setIsResizeAnimated(flag);
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'preferredCommitStyle'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.preferredCommitStyle}
            </Text>
          </View>
          <Switch
            value={togglePreferredCommitStyle}
            onValueChange={(flag) => {
              setTogglePreferredCommitStyle(flag)
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'targetViewNode'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={styles.textRowSubtitleLabel}>
                {'Value: '}
              </Text>
              {previewConfig.targetViewNode}
            </Text>
          </View>
          <Switch
            value={toggleTargetViewNode}
            onValueChange={(flag) => {
              setToggleTargetViewNode(flag);
            }}
          />
        </View>
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  rowContainer: {
    flexDirection: 'row',
    marginVertical: 10,
    alignItems: 'center',
  },
  textRowContainer: {
    flex: 1,
  },
  textRowTitle: {
    fontSize: 16,
    fontWeight: '400'
  },
  textRowSubtitle: {
    color: 'rgba(0,0,0,0.6)'
  },
  textRowSubtitleLabel: {
    fontWeight: 'bold'
  },
  targetViewContainer: {
    padding: 15,
    backgroundColor: 'rgba(255,255,255,0.5)',
    borderRadius: 10,
    marginVertical: 10,
    alignItems: 'center',
  },
  targetViewText: {
    fontSize: 16,
    fontWeight: '400',
  },
  previewContainer: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center', 
    padding: 20
  },
  previewTitleText: {
    fontWeight: '700', 
    fontSize: 32
  },
  previewCounterText: {
    fontWeight: '700', 
    fontSize: 32, 
    marginTop: 10
  },
});