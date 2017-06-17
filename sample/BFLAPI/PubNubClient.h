//
//  PubNubClient.h
//  test
//
//  Created by sakamotomasakiyo on 2017/05/28.
//  Copyright © 2017年 sakamotomasakiyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

@interface PubNubClient : NSObject <PNObjectEventListener>

- (void)subscribeToChannels:(NSArray * _Nonnull)channels handler:(void (^ _Nonnull)(NSString * _Nonnull channel, id _Nonnull data))handler;

@end
