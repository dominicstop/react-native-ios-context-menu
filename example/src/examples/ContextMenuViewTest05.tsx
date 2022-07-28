import * as React from 'react';
import { StyleSheet, View, Text, ScrollView } from 'react-native';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';

import * as Helpers from '../functions/Helpers';


type EventItem = {
  timestamp: string;
  type: string;
  index: number;
};

export function ContextMenuViewTest05(props: ContextMenuExampleProps) {
  const [events, setEvents] = React.useState<Array<EventItem>>([]);

  const hasEvents = (events.length > 0);
  const recentEvents = events.reverse().slice(-15);

  const handleEvent = (eventName: string) => {
    const date = new Date();

    const h = Helpers.pad(date.getHours  ());
    const m = Helpers.pad(date.getMinutes());
    const s = Helpers.pad(date.getSeconds());

    const ms = Helpers.pad(date.getMilliseconds(), 3);
    
    setEvents((prevValue) => ([ ...prevValue, {
      timestamp: `${h}:${m}:${s}.${ms}`,
      type: eventName,
      index: prevValue.length
    }]));
  };

  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewTest05',
        menuItems: [{
          actionKey  : 'key-01',
          actionTitle: 'Action #1',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'folder',
            },
          }
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'dial.fill',
            },
          }
        }, {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          icon: {
            type: 'IMAGE_SYSTEM',
            imageValue: {
              systemName: 'archivebox.fill',
            },
          }
        }],
      }}
      onMenuWillShow    ={() => handleEvent('onMenuWillShow'    )}
      onMenuWillHide    ={() => handleEvent('onMenuWillHide'    )}
      onMenuWillCancel  ={() => handleEvent('onMenuWillCancel'  )}
      onMenuDidShow     ={() => handleEvent('onMenuDidShow'     )}
      onMenuDidHide     ={() => handleEvent('onMenuDidHide'     )}
      onMenuDidCancel   ={() => handleEvent('onMenuDidCancel'   )}
      onPressMenuItem   ={() => handleEvent('onPressMenuItem'   )}
      onPressMenuPreview={() => handleEvent('onPressMenuPreview')}

      shouldWaitForMenuToHideBeforeFiringOnPressMenuItem={false}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewTest05'}
        subtitle={'context menu events'}
        description={[
          `Test for logging the menu events`
        ]}
      >
        {hasEvents? (
          <ScrollView 
            contentContainerStyle={styles.eventContainer}
            nestedScrollEnabled={true}
          >
            {recentEvents.map((item) => (
              <View 
                key={`event-${item.timestamp}-${item.type}`}
                style={styles.eventListItemContainer}
              >
                <Text style={styles.eventItemIndexText}>
                  {`${Helpers.pad(item.index, 3)}`}
                </Text>
                <Text style={styles.eventItemTimestampText}>
                  {`${item.timestamp}`}
                </Text>
                <Text style={styles.eventItemTypeText}>
                  {item.type}
                </Text>
              </View>
            ))}
          </ScrollView>
        ):(
          <View style={[styles.eventContainer, styles.eventContainerEmpty]}>
            <Text style={styles.eventEmptyText}>
              {'No Events To Show'}
            </Text>
          </View>
        )}
      </ContextMenuCard>
    </ContextMenuView>
  );
};

const styles = StyleSheet.create({
  eventContainer: {
    marginTop: 15,
    height: 150,
    backgroundColor: 'rgba(255,255,255,0.3)',
    borderRadius: 10,
    paddingHorizontal: 12,
    paddingVertical: 7,
  },
  eventContainerEmpty: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  eventEmptyText: {
    fontWeight: '600',
    fontSize: 16,
    color: 'rgba(0,0,0,0.4)',
  },
  eventListItemContainer: {
    flexDirection: 'row',
  },
  eventItemIndexText: {
    fontVariant: ['tabular-nums'],
    fontWeight: '600',
    color: 'rgba(0,0,0,0.3)',
  },
  eventItemTimestampText: {
    fontVariant: ['tabular-nums'],
    marginLeft: 12,
    fontWeight: '300',
    color: 'rgba(0,0,0,0.75)',
  },
  eventItemTypeText: {
    marginLeft: 12,
    fontWeight: '400',
    color: 'rgba(0,0,0,0.9)',
  },
});