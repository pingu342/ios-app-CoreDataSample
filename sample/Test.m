//
//  test.m
//  sample
//
//  Created by sakamotomasakiyo on 2017/06/04.
//  Copyright © 2017年 saka. All rights reserved.
//

#import "Test.h"

@implementation Test

@dynamic name;

+ (EKManagedObjectMapping *)objectMapping {
    return [EKManagedObjectMapping mappingForEntityName:@"Test" withBlock:^(EKManagedObjectMapping * _Nonnull mapping) {
        [mapping mapPropertiesFromArray:@[@"name"]];
    }];
}

@end
