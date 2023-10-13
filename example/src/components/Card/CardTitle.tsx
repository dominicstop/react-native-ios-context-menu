import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';

import * as Colors  from '../../constants/Colors';

/**
 * ```
 * ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐
 *              .─────────────.   
 * │ Title     (  Pill  Title  ) │
 *              `─────────────'   
 * │ Subtitle...                 │
 *  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
 * ```
 */                           
export function CardTitle(props: {
  extraMarginTop?: number;
  //
  title?: string;
  pillTitle?: string;
  subtitle?: string;
}){

  const hasTitle = (props.title != null);

  const cardPillWrapper = {
    marginLeft: (hasTitle? 10 : 0)
  };

  return (
    <React.Fragment>
      <View style={[styles.cardTitleContainer, { marginTop: props.extraMarginTop ?? 0 }]}>
        <Text style={styles.cardTitle}>
          {props.title ?? ''}
        </Text>
        {props.pillTitle && (
          <View style={[styles.cardPillWrapper, cardPillWrapper]}>
            <View style={styles.cardPillContainer}>
              <Text 
                style={styles.cardPillTitleText}
                numberOfLines={1}
              >
                {props.pillTitle}
              </Text>
            </View>
          </View>
        )}
      </View>
      {props.subtitle && (
        <Text style={styles.cardSubtitleText}>
          {props.subtitle ?? 'subtitle'}
        </Text>
      )}
    </React.Fragment>
  );
};

const styles = StyleSheet.create({
  cardTitleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: '600',
  },
  cardPillWrapper: {
    flex: 1,
    alignItems: 'flex-start',
  },
  cardPillContainer: {
    backgroundColor: Colors.BLUE.A400,
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 10,
  },
  cardPillTitleText: {
    color: 'white',
    fontWeight: '600',
    fontSize: 15,
  },
  cardSubtitleText: {
    marginTop: 7,
    fontWeight: '300',
    fontSize: 14,
    color: 'rgba(0,0,0,0.5)'
  },
});