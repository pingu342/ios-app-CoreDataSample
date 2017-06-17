//
//  MyDataController.m
//  sample
//
//  Created by sakamotomasakiyo on 2017/06/04.
//  Copyright © 2017年 saka. All rights reserved.
//

#import "MyDataController.h"

@implementation MyDataController

+ (id)sharedInstance {
    static MyDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
#if 0
    // sqliteファイルの削除
    BOOL ret;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    error = nil;
    ret = [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    if (ret == NO) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
#endif
    
    [self initializeCoreData];
    
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)initializeCoreData {
    
    // NSManagedObjectModel
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"momd"]; // プロジェクトの名前.momdっぽい
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    // NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    // NSManagedObjectContext
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    }); 
}


@end
