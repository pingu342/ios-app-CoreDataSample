//
//  PubNubClient.m
//  test
//
//  Created by sakamotomasakiyo on 2017/05/28.
//  Copyright © 2017年 sakamotomasakiyo. All rights reserved.
//

#import "PubNubClient.h"
#import "BFLRealtimeAPI.h"
#import "BFLTicker.h"
#import "BFLBoard.h"
#import "BFLExecution.h"

@interface  PubNubClient ()

@property (nonatomic) PubNub *client;
@property (nonatomic) void (^handler)(NSString * _Nonnull channel, id _Nonnull data);

@end


@implementation PubNubClient

- (void)subscribeToChannels:(NSArray * _Nonnull)channels handler:(void (^ _Nonnull)(NSString * _Nonnull channel, id _Nonnull data))handler {
    
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:@""
                                                                     subscribeKey:@"sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f"];
    self.client = [PubNub clientWithConfiguration:configuration];
    [self.client addListener:self];
    [self.client subscribeToChannels:channels withPresence:NO];
    self.handler = handler;
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (![message.data.channel isEqualToString:message.data.subscription]) {
        
        // Message has been received on channel group stored in message.data.subscription.
    }
    else {
        
        // Message has been received on channel stored in message.data.channel.
    }
    
    //NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
    //      message.data.channel, message.data.timetoken);
    
    id data = nil;
    if ([message.data.channel hasPrefix:kBFLBoardChannel]) {
        if ([message.data.message isKindOfClass:[NSDictionary class]]) {
            data = [[BFLBoard alloc] initWithDictionary:message.data.message];
        }
    } else if ([message.data.channel hasPrefix:kBFLTickerChannel]) {
        if ([message.data.message isKindOfClass:[NSDictionary class]]) {
            data = [[BFLBoard alloc] initWithDictionary:message.data.message];
        }
    } else if ([message.data.channel hasPrefix:kBFLTickerChannel]) {
        if ([message.data.message isKindOfClass:[NSDictionary class]]) {
            data = [[BFLTicker alloc] initWithDictionary:message.data.message];
        }
    } else if ([message.data.channel hasPrefix:kBFLExecutionsChannel]) {
        if ([message.data.message isKindOfClass:[NSArray class]]) {
            data = [NSMutableArray arrayWithCapacity:1];
            [message.data.message enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [data addObject:[[BFLExecution alloc] initWithDictionary:obj]];
                }
            }];
        }
    }
    self.handler(message.data.channel, data);
}

// Handle subscription status change.
- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    
    if (status.operation == PNSubscribeOperation) {
        
        // Check whether received information about successful subscription or restore.
        if (status.category == PNConnectedCategory || status.category == PNReconnectedCategory) {
            
            // Status object for those categories can be casted to `PNSubscribeStatus` for use below.
            PNSubscribeStatus *subscribeStatus = (PNSubscribeStatus *)status;
            if (subscribeStatus.category == PNConnectedCategory) {
                
                // This is expected for a subscribe, this means there is no error or issue whatsoever.
            }
            else {
                
                /**
                 This usually occurs if subscribe temporarily fails but reconnects. This means there was
                 an error but there is no longer any issue.
                 */
            }
        }
        else if (status.category == PNUnexpectedDisconnectCategory) {
            
            /**
             This is usually an issue with the internet connection, this is an error, handle
             appropriately retry will be called automatically.
             */
        }
        // Looks like some kind of issues happened while client tried to subscribe or disconnected from
        // network.
        else {
            
            PNErrorStatus *errorStatus = (PNErrorStatus *)status;
            if (errorStatus.category == PNAccessDeniedCategory) {
                
                /**
                 This means that PAM does allow this client to subscribe to this channel and channel group
                 configuration. This is another explicit error.
                 */
            }
            else {
                
                /**
                 More errors can be directly specified by creating explicit cases for other error categories
                 of `PNStatusCategory` such as: `PNDecryptionErrorCategory`,
                 `PNMalformedFilterExpressionCategory`, `PNMalformedResponseCategory`, `PNTimeoutCategory`
                 or `PNNetworkIssuesCategory`
                 */
            }
        }
    }
}

@end
