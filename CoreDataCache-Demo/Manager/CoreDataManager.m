//
//  CoreDataManager.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#define StoreName @"Cache.sqlite"

#import "News.h"
@implementation CoreDataManager
static CoreDataManager *_shareManager = nil;

#pragma mark - singleton
+ (CoreDataManager *)shareManager
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _shareManager = [[CoreDataManager alloc] init];
    });
    return _shareManager;
}

#pragma mark ————管理对象上下文————
+ (NSError *)saveContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"cotext saving error!");
        return error;
    }
    return error;
}
#pragma mark - context management
+ (NSManagedObjectContext *)globalContext
{
    return [[CoreDataManager shareManager] managedObjectContext];
}
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}
#pragma mark -被管理的对象模型
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //nil表示连接项目中所有的 .xcodemodel 文件为一个datamodel，这是一个非常好的方法，把多个entity放在各自的xcodemodel文件中分开管理，然后用这个函数连接起来生成一个datamodel，这样就可以对应一个persistentStore。
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
   // NSURL *modelURL = [[NSBundle mainBundle] URLForResource:StoreName withExtension:@"momd"];
   // _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    return _managedObjectModel;
}
#pragma mark -创建调度器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSString *storePath = [[self documentsDirectory] stringByAppendingPathComponent:StoreName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:storePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:StoreName ofType:nil];
        if (defaultStorePath) {
            [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
        }
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSError *error;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeUrl
                                                        options:options
                                                          error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1); // Fail
    }
    return _persistentStoreCoordinator;
}
- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}



//插入数据
- (void)insertCoreDataModel:(NSString*)model DataArray:(NSMutableArray*)dataArray
{
    NSManagedObjectContext *context = [self managedObjectContext];
    for (News *info in dataArray) {
        News *newsInfo = [NSEntityDescription insertNewObjectForEntityForName:model inManagedObjectContext:context];
        newsInfo.newsid = info.newsid;
        newsInfo.title = info.title;
        newsInfo.imgurl = info.imgurl;
        newsInfo.descr = info.descr;
        newsInfo.islook = info.islook;
        
        NSError *error;
        if(![context save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
}

//查询
- (NSMutableArray*)selectCoreDataModel:(NSString*)model Page:(int)pageSize andOffset:(int)currentPage
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 限定查询结果的数量
    //setFetchLimit
    // 查询的偏移量
    //setFetchOffset
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:model inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (News *info in fetchedObjects) {
        NSLog(@"id:%@", info.newsid);
        NSLog(@"title:%@", info.title);
        [resultArray addObject:info];
    }
    return resultArray;
}

//删除
-(void)deleteCoreDataModel:(NSString*)model
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:model inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}
//更新
- (void)updateCoreDataModel:(NSString*)model ID:(NSString*)newsId  withIsLook:(NSString*)islook
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"news" inManagedObjectContext:context]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    
    //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (News *info in result) {
        info.islook = islook;
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}

@end
