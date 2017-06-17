//
//  Person.h
//  EasyMappingCoreDataExample
//
//  Created by Alejandro Isaza on 2013-03-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseManagedTestModel.h"

@class ManagedCar;
@class ManagedPhone;

@interface ManagedPerson : BaseManagedTestModel

@property (nonatomic, retain) NSNumber * personID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) ManagedCar *car;

@property (nonatomic, strong) NSSet<ManagedPerson *> * children;
@property (nonatomic, strong) ManagedPerson *relative;

@property (nonatomic, retain) NSSet<ManagedPhone *> *phones;
@property (nonatomic, retain) NSString * gender;
@end

@interface ManagedPerson (CoreDataGeneratedAccessors)

- (void)addPhonesObject:(NSManagedObject *)value;
- (void)removePhonesObject:(NSManagedObject *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

@end
