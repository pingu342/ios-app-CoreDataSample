//
//  MyDataController.h
//  sample
//
//  Created by sakamotomasakiyo on 2017/06/04.
//  Copyright © 2017年 saka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MyDataController : NSObject

@property (strong) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;

@end
