//
//  Phone.m
//  EasyMappingCoreDataExample
//
//  Created by Alejandro Isaza on 2013-03-14.
//
//

#import "ManagedPhone.h"
#import "Person.h"


@implementation ManagedPhone

@dynamic phoneID;
@dynamic ddi;
@dynamic ddd;
@dynamic number;

static EKManagedObjectMapping * mapping = nil;

+(void)registerMapping:(EKManagedObjectMapping *)objectMapping
{
    mapping = objectMapping;
}

+(EKManagedObjectMapping *)objectMapping
{
    return mapping;
}

@end
