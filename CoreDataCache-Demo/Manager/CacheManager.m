//
//  CacheManager.m
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
+ (instancetype)shareManager
{
    static CacheManager *cacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheManager = [[CacheManager alloc] init];
    });
    return cacheManager;
}
@end
