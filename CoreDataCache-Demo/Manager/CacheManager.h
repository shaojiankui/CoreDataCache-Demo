//
//  CacheManager.h
//  CoreDataCache-Demo
//
//  Created by Jakey on 15/1/30.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^SuccessHandler)(id result);
//typedef void (^FailureHandler)(id error);
//
//typedef NS_ENUM(NSUInteger, WePayType) {
//    WePay_Server,
//    WePay_Client
//};

@interface CacheManager : NSObject
+ (instancetype)shareManager;

@end
