//
//  CoreDataManager.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
+ (CoreDataManager *)shareManager;
+ (NSManagedObjectContext *)globalContext;
+ (NSError *)saveContext:(NSManagedObjectContext *)context;

- (void)insertCoreDataModel:(NSString*)model DataArray:(NSMutableArray*)dataArray;
@end
