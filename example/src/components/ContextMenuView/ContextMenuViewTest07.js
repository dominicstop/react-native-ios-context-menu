import React from 'react';
import { StyleSheet, View, Text, Switch, findNodeHandle } from 'react-native';

import { ExampleContextMenuItem } from '../ExampleContextMenuItem';


class Test extends React.Component {
  constructor(props){
    super(props);
    this.state = {
    };
  };

  render(){
    return(
      <View 
        ref={r => this.viewRef = r}
        style={{width: 100, height: 100, backgroundColor: 'red', alignItems: 'center', justifyContent: 'center'}}
      >
        <Text>{this.state.node}</Text>
      </View>
    );
  }
};

export class ContextMenuViewTest07 extends React.PureComponent {
  constructor(props){
    super(props);

    this.interval = null;

    this.state = {
      counter: 0,
      targetViewNode: null,
      // flags for switch
      isResizeAnimated    : true ,
      togglePreviewType   : false,
      togglePreviewSize   : false,
      toggleBgTransparent : false,
      toggleTargetViewNode: false,
      togglePreferredCommitStyle: false,
    };
  };

  render(){
    const state = this.state;

    let opaque = 'white';
    let transp = 'rgba(255,255,255,0.5)';

    const previewConfig = {
      previewType    : (state.togglePreviewType   ? 'CUSTOM'  : 'DEFAULT'),
      previewSize    : (state.togglePreviewSize   ? 'STRETCH' : 'INHERIT'),
      backgroundColor: (state.toggleBgTransparent ? opaque    :  transp  ),
      ...(state.toggleTargetViewNode && {
        targetViewNode: state.targetViewNode,
      }),
      isResizeAnimated: state.isResizeAnimated,
      preferredCommitStyle: (state.togglePreferredCommitStyle? 'pop' : 'dismiss'),
    };

    return(
      <ExampleContextMenuItem
        {...this.props}
        title={'Test #7'}
        subtitle={'Custom Preview'}
        desc={`Test for the different possible custom menu preview config`}
        // `ContextMenuView` Props
        {...{previewConfig}}
        onMenuWillShow={() => {
          this.interval = setInterval(() => {
            this.setState((prevState) => ({
              counter: prevState.counter + 1,
            }));
          }, 1000);
        }}
        onMenuWillHide={() => {
          if(!this.interval) return;
          clearInterval(this.interval);
        }}
        renderPreview={() => (
          <View style={[styles.previewContainer]}>
            <Text style={{fontWeight: '700', fontSize: 32}}>
              {'Hello World'}
            </Text>
            {(state.counter % 2 == 0) && (
              <Text style={{fontWeight: '700', fontSize: 32, marginTop: 10}}>
                {`Counter: ${state.counter}`}
              </Text>
            )}
          </View>
        )}
        onPressMenuItem={({nativeEvent}) => {
          switch (nativeEvent.actionKey) {
            case 'add':
              this.setState((prevState) => ({
                counter: (prevState.counter + 100)
              }));
              break;

            case 'reset':
              this.setState({ counter: 0 });
              break;
          };
        }}
        menuConfig={{
          menuTitle: 'ContextMenuViewTest07',
          menuItems: [{
            actionKey  : 'add',
            actionTitle: `Add 100`,
            discoverabilityTitle: `Current counter ${state.counter}`,
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'plus',
            }
          }, 
          (state.counter > 0) && {
            actionKey     : 'reset',
            actionTitle   : `Reset Counter`,
            menuAttributes: ['destructive'],
            icon: {
              iconType : 'SYSTEM',
              iconValue: 'trash',
            }
          }],
        }}
      >
        {state.toggleTargetViewNode && (
          <View
            style={styles.targetViewContainer}
            ref={ref => {
              this.setState({
                targetViewNode: findNodeHandle(ref)
              });
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
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.previewType}
            </Text>
          </View>
          <Switch
            value={state.togglePreviewType}
            onValueChange={(flag) => {
              this.setState({togglePreviewType: flag});
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'previewSize'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.previewSize}
            </Text>
          </View>
          <Switch
            value={state.togglePreviewSize}
            onValueChange={(flag) => {
              this.setState({togglePreviewSize: flag});
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'backgroundColor'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.backgroundColor}
            </Text>
          </View>
          <Switch
            value={state.toggleBgTransparent}
            onValueChange={(flag) => {
              this.setState({toggleBgTransparent: flag});
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'isResizeAnimated'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.isResizeAnimated? 'true' : 'false'}
            </Text>
          </View>
          <Switch
            value={state.isResizeAnimated}
            onValueChange={(flag) => {
              this.setState({isResizeAnimated: flag});
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'preferredCommitStyle'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.preferredCommitStyle}
            </Text>
          </View>
          <Switch
            value={state.togglePreferredCommitStyle}
            onValueChange={(flag) => {
              this.setState({togglePreferredCommitStyle: flag});
            }}
          />
        </View>
        <View style={styles.rowContainer}>
          <View style={styles.textRowContainer}>
            <Text style={styles.textRowTitle}>
              {'targetViewNode'}
            </Text>
            <Text style={styles.textRowSubtitle}>
              <Text style={{fontWeight: 'bold'}}>
                {'Value: '}
              </Text>
              {previewConfig.targetViewNode}
            </Text>
          </View>
          <Switch
            value={state.toggleTargetViewNode}
            onValueChange={(flag) => {
              this.setState({toggleTargetViewNode: flag});
            }}
          />
        </View>
      </ExampleContextMenuItem>
    );
  };
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
  }
});