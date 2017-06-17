//
//  test.h
//  sample
//
//  Created by sakamotomasakiyo on 2017/06/04.
//  Copyright © 2017年 saka. All rights reserved.
//

#import <EasyMapping/EasyMapping.h>

@interface Test : EKManagedObjectModel

@property (nonatomic) NSString *name;

+ (EKManagedObjectMapping *)objectMapping;

@end
