import * as React from 'react';

import { ContextMenuView } from 'react-native-ios-context-menu';

import type { ContextMenuExampleProps } from './SharedExampleTypes';
import { ContextMenuCard } from '../components/ContextMenuCard';


export function ContextMenuViewExample27(props: ContextMenuExampleProps) {
  return (
    <ContextMenuView
      style={props.style}
      menuConfig={{
        menuTitle: 'ContextMenuViewExample27',
        menuItems: [{
          actionKey  : 'key-01'   ,
          actionTitle: 'Action #1',
          actionSubtitle: 'fallbackBehavior: whileNotLoaded',
          icon: {
            type: 'IMAGE_REMOTE_URL',
            imageValue: {
              url: 'https://fake.url.com/asset-1',
              fallbackImage: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'trash',
                },
              },
            },
            imageLoadingConfig: {
              maxRetryAttempts: 20,
              shouldLazyLoad: true,
              fallbackBehavior: 'whileNotLoaded',
              shouldImmediatelyRetryLoading: true,
            },
          }, 
        }, {
          actionKey  : 'key-02'   ,
          actionTitle: 'Action #2',
          actionSubtitle: 'fallbackBehavior: onLoadError',
          icon: {
            type: 'IMAGE_REMOTE_URL',
            imageValue: {
              url: 'https://fake.url.com/asset-2',
              fallbackImage: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'trash',
                },
              },
            },
            imageLoadingConfig: {
              maxRetryAttempts: 20,
              shouldLazyLoad: true,
              fallbackBehavior: 'onLoadError',
              shouldImmediatelyRetryLoading: true,
            },
          }
        },  {
          actionKey  : 'key-03'   ,
          actionTitle: 'Action #3',
          actionSubtitle: 'fallbackBehavior: afterFinalAttempt',
          icon: {
            type: 'IMAGE_REMOTE_URL',
            imageValue: {
              url: 'https://fake.url.com/asset-3',
              fallbackImage: {
                type: 'IMAGE_SYSTEM',
                imageValue: {
                  systemName: 'trash',
                },
              },
            },
            imageLoadingConfig: {
              maxRetryAttempts: 20,
              shouldLazyLoad: true,
              fallbackBehavior: 'afterFinalAttempt',
              shouldImmediatelyRetryLoading: true,
            },
          }
        }],
      }}
    >
      <ContextMenuCard
        index={props.index}
        title={'ContextMenuViewExample27'}
        subtitle={'ImageType Icons'}

        description={[
          `Context menu with actions that uses 'IMAGE_REMOTE_URL' icons`
        ]}
      />
    </ContextMenuView>
  );
};